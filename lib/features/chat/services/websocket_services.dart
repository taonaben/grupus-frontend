import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;
import 'package:logger/logger.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;
import '../models/message_model.dart';

typedef MessageCallback = void Function(Message message);
typedef TypingCallback = void Function(String userId, bool isTyping);
typedef PresenceCallback = void Function(UserPresence presence);
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

  Timer? _reconnectTimer;

  /// Maximum delay between reconnection attempts
  static const int _maxReconnectDelay = 30;

  // Callbacks
  final List<MessageCallback> _messageCallbacks = [];
  final List<TypingCallback> _typingCallbacks = [];
  final List<PresenceCallback> _presenceCallbacks = [];
  final List<ErrorCallback> _errorCallbacks = [];
  final List<ConnectionStateCallback> _connectionStateCallbacks = [];

  ChatWebSocketService({required this.baseUrl, required this.token});

  /// Gets current connection state
  WebSocketConnectionState get connectionState => _connectionState;

  /// Gets the current room ID
  String? get currentRoomId => _currentRoomId;

  /// Returns true if currently connected
  bool get isConnected =>
      _connectionState == WebSocketConnectionState.connected;

  /// Connect to a specific room's WebSocket
  Future<void> connect(String roomId) async {
    if (_connectionState == WebSocketConnectionState.connecting ||
        _connectionState == WebSocketConnectionState.connected) {
      logger.w('Already connecting or connected');
      return;
    }

    _currentRoomId = roomId;
    _reconnectAttempts = 0;
    await _performConnect();
  }

  /// Internal method to perform the actual connection
  Future<void> _performConnect() async {
    try {
      _updateConnectionState(WebSocketConnectionState.connecting);

      final wsUrl = _buildWebSocketUrl();
      logger.i('Connecting to WebSocket: $wsUrl');

      _channel = WebSocketChannel.connect(Uri.parse(wsUrl));

      // Listen to the channel
      _subscription = _channel!.stream.listen(
        _handleMessage,
        onError: _handleError,
        onDone: _handleDone,
      );

      _updateConnectionState(WebSocketConnectionState.connected);
      _reconnectAttempts = 0;
      logger.i('WebSocket connected successfully');
    } catch (e) {
      logger.e('Connection error: $e');
      _updateConnectionState(WebSocketConnectionState.connectionFailed);
      _scheduleReconnect();
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
    ];

    final wsUri = parsedBase.replace(
      scheme: wsScheme,
      pathSegments: pathSegments,
      queryParameters: {'token': token},
    );

    return wsUri.toString();
  }

  /// Handles incoming messages from the WebSocket
  void _handleMessage(dynamic message) {
    try {
      final jsonData = jsonDecode(message) as Map<String, dynamic>;
      final event = WebSocketEvent.fromJson(jsonData);

      logger.d('Received event: ${event.type}');

      switch (event.type) {
        case 'message':
          final messageData = event.data['data'] as Map<String, dynamic>?;
          if (messageData != null) {
            final chatMessage = Message.fromJson(messageData);
            _broadcastMessage(chatMessage);
          }
          break;

        case 'typing':
          final userId = event.data['user_id'] as String?;
          final isTyping = event.data['is_typing'] as bool? ?? false;
          if (userId != null) {
            _broadcastTyping(userId, isTyping);
          }
          break;

        case 'user_joined':
        case 'user_left':
          final presence = UserPresence.fromJson(event.data);
          _broadcastPresence(presence);
          break;

        case 'error':
          final errorMsg = event.data['message'] as String?;
          _broadcastError(errorMsg ?? 'Unknown error');
          break;

        default:
          logger.w('Unknown event type: ${event.type}');
      }
    } catch (e) {
      logger.e('Error parsing message: $e');
      _broadcastError('Failed to parse message: $e');
    }
  }

  /// Handles WebSocket errors
  void _handleError(error) {
    logger.e('WebSocket error: $error');
    _broadcastError('Connection error: $error');
    _updateConnectionState(WebSocketConnectionState.connectionFailed);
    _scheduleReconnect();
  }

  /// Handles WebSocket closure
  void _handleDone() {
    logger.i('WebSocket closed');
    _updateConnectionState(WebSocketConnectionState.closed);
    _scheduleReconnect();
  }

  /// Schedules a reconnect attempt with exponential backoff
  void _scheduleReconnect() {
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
      'Scheduling reconnect attempt ${_reconnectAttempts} in ${delay.inSeconds}s',
    );

    _reconnectTimer?.cancel();
    _reconnectTimer = Timer(delay, () {
      if (_currentRoomId != null) {
        _performConnect();
      }
    });
  }

  /// Sends a text message to the room
  Future<void> sendMessage(
    String content, {
    Map<String, dynamic>? metadata,
  }) async {
    await _sendEvent(
      type: 'message',
      payload: {
        'message_type': 'text',
        'content': content,
        'metadata': metadata ?? {},
      },
    );
  }

  /// Broadcasts typing status
  Future<void> broadcastTyping(bool isTyping) async {
    await _sendEvent(type: 'typing', payload: {'is_typing': isTyping});
  }

  /// Sends a reminder message
  Future<void> sendReminder(
    String content, {
    required DateTime dueDate,
    String priority = 'medium',
    Map<String, dynamic>? metadata,
  }) async {
    await _sendEvent(
      type: 'message',
      payload: {
        'message_type': 'reminder',
        'content': content,
        'metadata': {
          'due_date': dueDate.toIso8601String(),
          'priority': priority,
          if (metadata != null) ...metadata,
        },
      },
    );
  }

  /// Sends an alert message
  Future<void> sendAlert(
    String content, {
    String alertLevel = 'info',
    Map<String, dynamic>? metadata,
  }) async {
    await _sendEvent(
      type: 'message',
      payload: {
        'message_type': 'alert',
        'content': content,
        'metadata': {
          'alert_level': alertLevel,
          if (metadata != null) ...metadata,
        },
      },
    );
  }

  /// Internal method to send any event to the WebSocket
  Future<void> _sendEvent({
    required String type,
    required Map<String, dynamic> payload,
  }) async {
    if (!isConnected) {
      logger.w('Not connected, cannot send event: $type');
      _broadcastError('Not connected to chat');
      return;
    }

    try {
      final event = {'type': type, ...payload};
      _channel?.sink.add(jsonEncode(event));
      logger.d('Sent event: $type');
    } catch (e) {
      logger.e('Error sending event: $e');
      _broadcastError('Failed to send message: $e');
    }
  }

  /// Updates connection state and broadcasts to all listeners
  void _updateConnectionState(WebSocketConnectionState newState) {
    if (_connectionState != newState) {
      _connectionState = newState;
      for (final callback in _connectionStateCallbacks) {
        callback(newState);
      }
    }
  }

  /// Broadcasts a message to all listeners
  void _broadcastMessage(Message message) {
    for (final callback in _messageCallbacks) {
      callback(message);
    }
  }

  /// Broadcasts typing event to all listeners
  void _broadcastTyping(String userId, bool isTyping) {
    for (final callback in _typingCallbacks) {
      callback(userId, isTyping);
    }
  }

  /// Broadcasts presence event to all listeners
  void _broadcastPresence(UserPresence presence) {
    for (final callback in _presenceCallbacks) {
      callback(presence);
    }
  }

  /// Broadcasts error to all listeners
  void _broadcastError(String error) {
    for (final callback in _errorCallbacks) {
      callback(error);
    }
  }

  /// Register listeners
  void onMessage(MessageCallback callback) => _messageCallbacks.add(callback);

  void onTyping(TypingCallback callback) => _typingCallbacks.add(callback);

  void onPresence(PresenceCallback callback) =>
      _presenceCallbacks.add(callback);

  void onError(ErrorCallback callback) => _errorCallbacks.add(callback);

  void onConnectionStateChanged(ConnectionStateCallback callback) =>
      _connectionStateCallbacks.add(callback);

  /// Disconnect from WebSocket
  void disconnect() {
    logger.i('Disconnecting WebSocket');
    _reconnectTimer?.cancel();
    _subscription?.cancel();
    _channel?.sink.close(status.goingAway);
    _updateConnectionState(WebSocketConnectionState.disconnected);
    _currentRoomId = null;
  }

  /// Dispose resources
  void dispose() {
    disconnect();
    _messageCallbacks.clear();
    _typingCallbacks.clear();
    _presenceCallbacks.clear();
    _errorCallbacks.clear();
    _connectionStateCallbacks.clear();
  }
}
