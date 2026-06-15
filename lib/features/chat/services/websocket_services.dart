import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;
import 'package:logger/logger.dart';
import 'package:grupus/shared/utils/logs.dart';
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
  final String _debugId = DateTime.now().microsecondsSinceEpoch.toString();

  ChatWebSocketService({required this.baseUrl, required this.token});

  void _trace(String message) {
    DevLogs.logInfo('[ChatWS:$_debugId] $message');
  }

  void _warn(String message) {
    DevLogs.logWarning('[ChatWS:$_debugId] $message');
  }

  void _errorLog(String message) {
    DevLogs.logError('[ChatWS:$_debugId] $message');
  }

  void _closeChannel(WebSocketChannel? channel) {
    if (channel == null) {
      _trace('closeChannel skipped: channel is null');
      return;
    }

    _trace('closeChannel start');
    unawaited(
      channel.sink
          .close(status.goingAway)
          .then((_) => _trace('closeChannel complete'))
          .catchError((Object error, StackTrace stackTrace) {
            _errorLog('closeChannel error: $error');
            _errorLog('closeChannel stack: $stackTrace');
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
    _trace(
      'connect requested room=$roomId state=${_connectionState.name} disposed=$_isDisposed manual=$_manualDisconnect',
    );
    if (_isDisposed) {
      _warn('connect ignored: service already disposed');
      return;
    }

    if (_connectionState == WebSocketConnectionState.connecting ||
        _connectionState == WebSocketConnectionState.connected) {
      _warn('connect ignored: already ${_connectionState.name}');
      return;
    }

    _currentRoomId = roomId;
    _reconnectAttempts = 0;
    _manualDisconnect = false;
    await _performConnect();
  }

  /// Internal method to perform the actual connection
  Future<void> _performConnect() async {
    _trace(
      'performConnect enter room=$_currentRoomId disposed=$_isDisposed manual=$_manualDisconnect',
    );
    if (_isDisposed || _manualDisconnect) {
      _trace('performConnect exit early');
      return;
    }

    try {
      _updateConnectionState(WebSocketConnectionState.connecting);

      // Ensure previous subscription/channel are cleaned before reconnecting.
      _trace('performConnect cleanup previous subscription/channel');
      await _subscription?.cancel();
      _trace('performConnect previous subscription cancelled');
      _subscription = null;
      _closeChannel(_channel);
      _channel = null;

      final wsUrl = _buildWebSocketUrl();
      final redactedWsUrl = Uri.parse(wsUrl).replace(
        queryParameters: {'token': '<redacted>'},
      );
      _trace('connecting to WebSocket: $redactedWsUrl');

      final channel = WebSocketChannel.connect(Uri.parse(wsUrl));
      _channel = channel;

      // Await the handshake — throws if the server rejects the upgrade (e.g. 401/403)
      _trace('awaiting channel.ready');
      await channel.ready;
      _trace('channel.ready completed');

      if (_isDisposed || _manualDisconnect || _channel != channel) {
        _warn(
          'ready completed after stale/disposed state: disposed=$_isDisposed manual=$_manualDisconnect stale=${_channel != channel}',
        );
        _closeChannel(channel);
        return;
      }

      // Listen to the channel
      _trace('attaching stream listener');
      _subscription = channel.stream.listen(
        _handleMessage,
        onError: _handleError,
        onDone: _handleDone,
      );

      _updateConnectionState(WebSocketConnectionState.connected);
      _reconnectAttempts = 0;
      _trace('connected successfully');
    } catch (e) {
      if (_isDisposed || _manualDisconnect) {
        _warn('performConnect caught error after teardown: $e');
        return;
      }

      _errorLog('connection error: $e');
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
    _trace('handleMessage called disposed=$_isDisposed');
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

      _trace('received event: $eventType');

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
      _errorLog('error parsing message: $e');
      _broadcastError('Failed to parse message: $e');
    }
  }

  /// Handles WebSocket errors
  void _handleError(error) {
    _errorLog(
      'handleError called error=$error disposed=$_isDisposed manual=$_manualDisconnect',
    );
    if (_isDisposed || _manualDisconnect) {
      return;
    }

    _broadcastError('Connection error: $error');
    _updateConnectionState(WebSocketConnectionState.connectionFailed);
    if (!_manualDisconnect) {
      _scheduleReconnect();
    }
  }

  /// Handles WebSocket closure
  void _handleDone() {
    _trace('handleDone called disposed=$_isDisposed manual=$_manualDisconnect');
    if (_isDisposed || _manualDisconnect) {
      return;
    }

    _trace('WebSocket closed by stream');
    _updateConnectionState(WebSocketConnectionState.closed);
    if (!_manualDisconnect) {
      _scheduleReconnect();
    }
  }

  /// Schedules a reconnect attempt with exponential backoff
  void _scheduleReconnect() {
    _trace(
      'scheduleReconnect called attempts=$_reconnectAttempts disposed=$_isDisposed manual=$_manualDisconnect',
    );
    if (_isDisposed || _manualDisconnect) {
      return;
    }

    if (_reconnectAttempts >= _maxReconnectAttempts) {
      _errorLog('max reconnection attempts reached');
      _updateConnectionState(WebSocketConnectionState.disconnected);
      return;
    }

    _reconnectAttempts++;
    final delaySeconds = math
        .pow(2, _reconnectAttempts)
        .toInt()
        .clamp(3, _maxReconnectDelay);
    final delay = Duration(seconds: delaySeconds);

    _trace(
      'Scheduling reconnect attempt $_reconnectAttempts in ${delay.inSeconds}s',
    );

    _reconnectTimer?.cancel();
    _reconnectTimer = Timer(delay, () {
      if (!_isDisposed && !_manualDisconnect && _currentRoomId != null) {
        _trace('reconnect timer fired');
        _performConnect();
      } else {
        _trace(
          'reconnect timer ignored disposed=$_isDisposed manual=$_manualDisconnect room=$_currentRoomId',
        );
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
    _trace(
      'sendPayload type=${event['type']} state=${_connectionState.name} disposed=$_isDisposed',
    );
    if (_isDisposed) {
      _warn('sendPayload ignored: service disposed');
      return;
    }

    if (!isConnected) {
      _warn('sendPayload ignored: not connected');
      _broadcastError('Not connected to chat');
      return;
    }

    try {
      _channel?.sink.add(jsonEncode(event));
      _trace('sent event: ${event['type']}');
    } catch (e) {
      _errorLog('error sending event: $e');
      _broadcastError('Failed to send message: $e');
    }
  }

  /// Updates connection state and broadcasts to all listeners
  void _updateConnectionState(WebSocketConnectionState newState) {
    _trace(
      'updateConnectionState ${_connectionState.name} -> ${newState.name} disposed=$_isDisposed callbacks=${_connectionStateCallbacks.length}',
    );
    if (_isDisposed) {
      return;
    }

    if (_connectionState != newState) {
      _connectionState = newState;
      for (final callback in _connectionStateCallbacks) {
        try {
          callback(newState);
        } catch (e) {
          _errorLog('connection state callback failed: $e');
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
    _errorLog('broadcastError callbacks=${_errorCallbacks.length}: $error');
    for (final callback in _errorCallbacks) {
      try {
        callback(error);
      } catch (e) {
        _errorLog('error callback failed: $e');
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
    _trace(
      'disconnect start state=${_connectionState.name} room=$_currentRoomId disposed=$_isDisposed manual=$_manualDisconnect',
    );
    _manualDisconnect = true;
    _reconnectTimer?.cancel();
    _trace('disconnect reconnect timer cancelled');
    _reconnectTimer = null;
    final subscription = _subscription;
    _subscription = null;
    if (subscription != null) {
      _trace('disconnect cancelling subscription');
      unawaited(
        subscription
            .cancel()
            .then((_) => _trace('disconnect subscription cancel complete'))
            .catchError((Object error, StackTrace stackTrace) {
              _errorLog('disconnect subscription cancel error: $error');
              _errorLog('disconnect subscription cancel stack: $stackTrace');
            }),
      );
    } else {
      _trace('disconnect no subscription to cancel');
    }
    _closeChannel(_channel);
    _channel = null;
    _updateConnectionState(WebSocketConnectionState.disconnected);
    _currentRoomId = null;
    _trace('disconnect complete');
  }

  /// Dispose resources
  void dispose() {
    _trace('dispose start');
    _isDisposed = true;
    disconnect();
    _messageCallbacks.clear();
    _typingCallbacks.clear();
    _presenceCallbacks.clear();
    _reactionCallbacks.clear();
    _errorCallbacks.clear();
    _connectionStateCallbacks.clear();
    _trace('dispose callbacks cleared');
  }
}
