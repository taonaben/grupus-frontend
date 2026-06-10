import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;
import 'package:logger/logger.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;
import '../models/message_model.dart';
import 'websocket/websocket_event_payload_builder.dart';

typedef MessageCallback = void Function(Message message);
typedef TypingCallback = void Function(String userId, bool isTyping);
typedef PresenceCallback = void Function(UserPresence presence);
typedef ReactionCallback = void Function(ReactionEvent reaction);
typedef ErrorCallback = void Function(String error);
typedef ConnectionStateCallback = void Function(WebSocketConnectionState state);

/// Represents the connection state of the WebSocket
enum WebSocketConnectionState {
  disconnected,
  connecting,
  connected,
  connectionFailed,
  closed,
}

/// Manages WebSocket connections for the chat system.
/// Handles automatic reconnection, message serialization, and event broadcasting.
class ChatWebSocketService {
  final String baseUrl; // e.g., 'ws://localhost:8000'
  final String token; // JWT token for authentication
  final Logger logger = Logger();

  WebSocketChannel? _channel;
  StreamSubscription<dynamic>? _subscription;

  String? _currentRoomId;
  WebSocketConnectionState _connectionState =
      WebSocketConnectionState.disconnected;
  int _reconnectAttempts = 0;
  static const int _maxReconnectAttempts = 5;
  bool _manualDisconnect = false;
  bool _isDisposed = false;

  Timer? _reconnectTimer;

  /// Maximum delay between reconnection attempts
  static const int _maxReconnectDelay = 30;

  // Callbacks
  final List<MessageCallback> _messageCallbacks = [];
  final List<TypingCallback> _typingCallbacks = [];
  final List<PresenceCallback> _presenceCallbacks = [];
  final List<ReactionCallback> _reactionCallbacks = [];
  final List<ErrorCallback> _errorCallbacks = [];
  final List<ConnectionStateCallback> _connectionStateCallbacks = [];
  final WebSocketEventPayloadBuilder _payloadBuilder =
      const WebSocketEventPayloadBuilder();

  ChatWebSocketService({required this.baseUrl, required this.token});

  void _closeChannel(WebSocketChannel? channel) {
    if (channel == null) {
      return;
    }

    unawaited(
      channel.sink.close(status.goingAway).catchError((Object error) {
        logger.w('Ignoring WebSocket close error: $error');
      }),
    );
  }

  /// Gets current connection state
  WebSocketConnectionState get connectionState => _connectionState;

  /// Gets the current room ID
  String? get currentRoomId => _currentRoomId;

  /// Returns true if currently connected
  bool get isConnected =>
      _connectionState == WebSocketConnectionState.connected;

  /// Connect to a specific room's WebSocket
  Future<void> connect(String roomId) async {
    if (_isDisposed) {
      logger.w('Cannot connect disposed WebSocket service');
      return;
    }

    if (_connectionState == WebSocketConnectionState.connecting ||
        _connectionState == WebSocketConnectionState.connected) {
      logger.w('Already connecting or connected');
      return;
    }

    _currentRoomId = roomId;
    _reconnectAttempts = 0;
    _manualDisconnect = false;
    await _performConnect();
  }

  /// Internal method to perform the actual connection
  Future<void> _performConnect() async {
    if (_isDisposed || _manualDisconnect) {
      return;
    }

    try {
      _updateConnectionState(WebSocketConnectionState.connecting);

      // Ensure previous subscription/channel are cleaned before reconnecting.
      await _subscription?.cancel();
      _subscription = null;
      _closeChannel(_channel);
      _channel = null;

      final wsUrl = _buildWebSocketUrl();
      logger.i('Connecting to WebSocket: $wsUrl');

      final channel = WebSocketChannel.connect(Uri.parse(wsUrl));
      _channel = channel;

      // Await the handshake — throws if the server rejects the upgrade (e.g. 401/403)
      await channel.ready;

      if (_isDisposed || _manualDisconnect || _channel != channel) {
        _closeChannel(channel);
        return;
      }

      // Listen to the channel
      _subscription = channel.stream.listen(
        _handleMessage,
        onError: _handleError,
        onDone: _handleDone,
      );

      _updateConnectionState(WebSocketConnectionState.connected);
      _reconnectAttempts = 0;
      logger.i('WebSocket connected successfully');
    } catch (e) {
      if (_isDisposed || _manualDisconnect) {
        return;
      }

      logger.e('Connection error: $e');
      _updateConnectionState(WebSocketConnectionState.connectionFailed);
      if (!_manualDisconnect) {
        _scheduleReconnect();
      }
    }
  }

  /// Builds a valid WebSocket URL from the provided base URL.
  /// Accepts ws/wss/http/https inputs and always returns ws or wss.
  String _buildWebSocketUrl() {
    final parsedBase = Uri.parse(baseUrl);
    final wsScheme = parsedBase.scheme == 'https' ? 'wss' : 'ws';

    final pathSegments = <String>[
      ...parsedBase.pathSegments.where((segment) => segment.isNotEmpty),
      'ws',
      'chat',
      _currentRoomId!,
      '',
    ];

    // Construct from scratch to avoid Uri.replace() carrying over an empty
    // fragment field, which serialises as a trailing '#' and breaks the upgrade.
    final wsUri = Uri(
      scheme: wsScheme,
      host: parsedBase.host,
      port: parsedBase.port,
      pathSegments: pathSegments,
      queryParameters: {'token': token},
    );

    return wsUri.toString();
  }

  /// Handles incoming messages from the WebSocket
  void _handleMessage(dynamic message) {
    if (_isDisposed) {
      return;
    }

    try {
      final jsonData = jsonDecode(message) as Map<String, dynamic>;
      final eventType = jsonData['type'] as String?;

      if (eventType == null || eventType.isEmpty) {
        _broadcastError('Received event without type');
        return;
      }

      logger.d('Received event: $eventType');

      switch (eventType) {
        case 'message':
          final messageData = jsonData['data'] as Map<String, dynamic>?;
          if (messageData != null) {
            final chatMessage = Message.fromJson(messageData);
            _broadcastMessage(chatMessage);
          } else {
            _broadcastError('Message payload missing data');
          }
          break;

        case 'typing':
          final userId = jsonData['user_id'] as String?;
          final isTyping = jsonData['is_typing'] as bool? ?? false;
          if (userId != null) {
            _broadcastTyping(userId, isTyping);
          } else {
            _broadcastError('Typing payload missing user_id');
          }
          break;

        case 'user_joined':
        case 'user_left':
          final presence = UserPresence.fromJson(jsonData);
          _broadcastPresence(presence);
          break;

        case 'reaction':
          final reaction = ReactionEvent.fromJson(jsonData);
          _broadcastReaction(reaction);
          break;

        case 'error':
          final errorMsg = jsonData['message'] as String?;
          _broadcastError(errorMsg ?? 'Unknown error');
          break;

        default:
          logger.w('Unknown event type: $eventType');
      }
    } catch (e) {
      logger.e('Error parsing message: $e');
      _broadcastError('Failed to parse message: $e');
    }
  }

  /// Handles WebSocket errors
  void _handleError(error) {
    if (_isDisposed || _manualDisconnect) {
      return;
    }

    logger.e('WebSocket error: $error');
    _broadcastError('Connection error: $error');
    _updateConnectionState(WebSocketConnectionState.connectionFailed);
    if (!_manualDisconnect) {
      _scheduleReconnect();
    }
  }

  /// Handles WebSocket closure
  void _handleDone() {
    if (_isDisposed || _manualDisconnect) {
      return;
    }

    logger.i('WebSocket closed');
    _updateConnectionState(WebSocketConnectionState.closed);
    if (!_manualDisconnect) {
      _scheduleReconnect();
    }
  }

  /// Schedules a reconnect attempt with exponential backoff
  void _scheduleReconnect() {
    if (_isDisposed || _manualDisconnect) {
      return;
    }

    if (_reconnectAttempts >= _maxReconnectAttempts) {
      logger.e('Max reconnection attempts reached');
      _updateConnectionState(WebSocketConnectionState.disconnected);
      return;
    }

    _reconnectAttempts++;
    final delaySeconds = math
        .pow(2, _reconnectAttempts)
        .toInt()
        .clamp(3, _maxReconnectDelay);
    final delay = Duration(seconds: delaySeconds);

    logger.i(
      'Scheduling reconnect attempt $_reconnectAttempts in ${delay.inSeconds}s',
    );

    _reconnectTimer?.cancel();
    _reconnectTimer = Timer(delay, () {
      if (!_isDisposed && !_manualDisconnect && _currentRoomId != null) {
        _performConnect();
      }
    });
  }

  /// Sends a text message to the room
  Future<void> sendMessage(
    String content, {
    Map<String, dynamic>? metadata,
  }) async {
    await _sendPayload(
      _payloadBuilder.buildTextMessage(content, metadata: metadata),
    );
  }

  /// Broadcasts typing status
  Future<void> broadcastTyping(bool isTyping) async {
    await _sendPayload(_payloadBuilder.buildTyping(isTyping));
  }

  /// Sends a reminder message
  Future<void> sendReminder(
    String content, {
    required DateTime dueDate,
    String priority = 'medium',
    Map<String, dynamic>? metadata,
  }) async {
    await _sendPayload(
      _payloadBuilder.buildReminder(
        content,
        dueDate: dueDate,
        priority: priority,
        metadata: metadata,
      ),
    );
  }

  /// Sends an alert message
  Future<void> sendAlert(
    String content, {
    String alertLevel = 'info',
    Map<String, dynamic>? metadata,
  }) async {
    await _sendPayload(
      _payloadBuilder.buildAlert(
        content,
        alertLevel: alertLevel,
        metadata: metadata,
      ),
    );
  }

  /// Sends a reaction event for an existing message
  Future<void> sendReaction({
    required String messageId,
    required String emoji,
  }) async {
    final trimmedEmoji = emoji.trim();
    if (trimmedEmoji.isEmpty || trimmedEmoji.length > 10) {
      _broadcastError('Reaction emoji must be between 1 and 10 characters');
      return;
    }

    await _sendPayload(
      _payloadBuilder.buildReaction(messageId: messageId, emoji: trimmedEmoji),
    );
  }

  Future<void> _sendPayload(Map<String, dynamic> event) async {
    if (_isDisposed) {
      logger.w('Disposed WebSocket service cannot send event: ${event['type']}');
      return;
    }

    if (!isConnected) {
      logger.w('Not connected, cannot send event: ${event['type']}');
      _broadcastError('Not connected to chat');
      return;
    }

    try {
      _channel?.sink.add(jsonEncode(event));
      logger.d('Sent event: ${event['type']}');
    } catch (e) {
      logger.e('Error sending event: $e');
      _broadcastError('Failed to send message: $e');
    }
  }

  /// Updates connection state and broadcasts to all listeners
  void _updateConnectionState(WebSocketConnectionState newState) {
    if (_isDisposed) {
      return;
    }

    if (_connectionState != newState) {
      _connectionState = newState;
      for (final callback in _connectionStateCallbacks) {
        try {
          callback(newState);
        } catch (e) {
          logger.e('Connection state callback failed: $e');
        }
      }
    }
  }

  /// Broadcasts a message to all listeners
  void _broadcastMessage(Message message) {
    for (final callback in _messageCallbacks) {
      try {
        callback(message);
      } catch (e) {
        logger.e('Message callback failed: $e');
      }
    }
  }

  /// Broadcasts typing event to all listeners
  void _broadcastTyping(String userId, bool isTyping) {
    for (final callback in _typingCallbacks) {
      try {
        callback(userId, isTyping);
      } catch (e) {
        logger.e('Typing callback failed: $e');
      }
    }
  }

  /// Broadcasts presence event to all listeners
  void _broadcastPresence(UserPresence presence) {
    for (final callback in _presenceCallbacks) {
      try {
        callback(presence);
      } catch (e) {
        logger.e('Presence callback failed: $e');
      }
    }
  }

  /// Broadcasts reaction event to all listeners
  void _broadcastReaction(ReactionEvent reaction) {
    for (final callback in _reactionCallbacks) {
      try {
        callback(reaction);
      } catch (e) {
        logger.e('Reaction callback failed: $e');
      }
    }
  }

  /// Broadcasts error to all listeners
  void _broadcastError(String error) {
    for (final callback in _errorCallbacks) {
      try {
        callback(error);
      } catch (e) {
        logger.e('Error callback failed: $e');
      }
    }
  }

  /// Register listeners
  void onMessage(MessageCallback callback) => _messageCallbacks.add(callback);

  void offMessage(MessageCallback callback) =>
      _messageCallbacks.remove(callback);

  void onTyping(TypingCallback callback) => _typingCallbacks.add(callback);

  void offTyping(TypingCallback callback) => _typingCallbacks.remove(callback);

  void onPresence(PresenceCallback callback) =>
      _presenceCallbacks.add(callback);

  void offPresence(PresenceCallback callback) =>
      _presenceCallbacks.remove(callback);

  void onReaction(ReactionCallback callback) =>
      _reactionCallbacks.add(callback);

  void offReaction(ReactionCallback callback) =>
      _reactionCallbacks.remove(callback);

  void onError(ErrorCallback callback) => _errorCallbacks.add(callback);

  void offError(ErrorCallback callback) => _errorCallbacks.remove(callback);

  void onConnectionStateChanged(ConnectionStateCallback callback) =>
      _connectionStateCallbacks.add(callback);

  void offConnectionStateChanged(ConnectionStateCallback callback) =>
      _connectionStateCallbacks.remove(callback);

  /// Disconnect from WebSocket
  void disconnect() {
    logger.i('Disconnecting WebSocket');
    _manualDisconnect = true;
    _reconnectTimer?.cancel();
    _reconnectTimer = null;
    _subscription?.cancel();
    _subscription = null;
    _closeChannel(_channel);
    _channel = null;
    _updateConnectionState(WebSocketConnectionState.disconnected);
    _currentRoomId = null;
  }

  /// Dispose resources
  void dispose() {
    _isDisposed = true;
    disconnect();
    _messageCallbacks.clear();
    _typingCallbacks.clear();
    _presenceCallbacks.clear();
    _reactionCallbacks.clear();
    _errorCallbacks.clear();
    _connectionStateCallbacks.clear();
  }
}
