import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import '../models/message_model.dart';
import '../services/websocket_services.dart';

final logger = Logger();

/// Represents the state of typing users (userId -> isTyping)
typedef TypingUsersState = Map<String, bool>;

/// Represents the state of users in the room
typedef RoomUsersState = Map<String, String>; // userId -> username

/// Global reference to the active WebSocketService (set by ChatScreen)
ChatWebSocketService? _activeWebSocketService;

/// Returns the currently active WebSocket service
ChatWebSocketService? _getWebSocketService() => _activeWebSocketService;

/// Sets the active WebSocket service (called by ChatScreen on init)
void _setWebSocketService(ChatWebSocketService service) {
  _activeWebSocketService = service;
}

/// Clears the WebSocket service reference (called by ChatScreen on dispose)
void _clearWebSocketService() {
  _activeWebSocketService = null;
}

/// Public function to set the WebSocket service (call this from ChatScreen)
void initializeChatWebSocket(ChatWebSocketService service) {
  _setWebSocketService(service);
}

/// Public function to clear the WebSocket service (call this from ChatScreen.dispose)
void disposeChatWebSocket() {
  _clearWebSocketService();
}

/// Manages the list of messages in the current chat
final chatMessagesProvider = StateNotifierProvider<
  ChatMessagesNotifier,
  List<Message>
>((ref) {
  final webSocket = _getWebSocketService();
  if (webSocket == null) {
    throw StateError(
      'WebSocket service not initialized. Make sure ChatScreen is properly mounted.',
    );
  }
  return ChatMessagesNotifier(webSocket);
});

/// Manages typing indicators for other users
final chatTypingUsersProvider = StateNotifierProvider<
  ChatTypingNotifier,
  TypingUsersState
>((ref) {
  final webSocket = _getWebSocketService();
  if (webSocket == null) {
    throw StateError(
      'WebSocket service not initialized. Make sure ChatScreen is properly mounted.',
    );
  }
  return ChatTypingNotifier(webSocket);
});

/// Manages user presence in the room
final chatRoomUsersProvider = StateNotifierProvider<
  ChatRoomUsersNotifier,
  RoomUsersState
>((ref) {
  final webSocket = _getWebSocketService();
  if (webSocket == null) {
    throw StateError(
      'WebSocket service not initialized. Make sure ChatScreen is properly mounted.',
    );
  }
  return ChatRoomUsersNotifier(webSocket);
});

/// Provides the connection state of the WebSocket
final chatConnectionStateProvider = StateNotifierProvider<
  ChatConnectionStateNotifier,
  WebSocketConnectionState
>((ref) {
  final webSocket = _getWebSocketService();
  if (webSocket == null) {
    throw StateError(
      'WebSocket service not initialized. Make sure ChatScreen is properly mounted.',
    );
  }
  return ChatConnectionStateNotifier(webSocket);
});

/// Provides the last error message, if any
final chatErrorProvider = StateNotifierProvider<ChatErrorNotifier, String?>((
  ref,
) {
  final webSocket = _getWebSocketService();
  if (webSocket == null) {
    throw StateError(
      'WebSocket service not initialized. Make sure ChatScreen is properly mounted.',
    );
  }
  return ChatErrorNotifier(webSocket);
});

/// Notifier for managing chat messages
class ChatMessagesNotifier extends StateNotifier<List<Message>> {
  final ChatWebSocketService _webSocket;

  ChatMessagesNotifier(this._webSocket) : super([]) {
    _setupListeners();
  }

  void _setupListeners() {
    _webSocket.onMessage((message) {
      state = [...state, message];
      logger.d('Message added. Total messages: ${state.length}');
    });
  }

  /// Adds a message locally (before it's sent)
  void addLocalMessage(Message message) {
    state = [...state, message];
  }

  /// Clears all messages
  void clearMessages() {
    state = [];
  }

  /// Sends a text message
  Future<void> sendMessage(String content) async {
    try {
      await _webSocket.sendMessage(content);
    } catch (e) {
      logger.e('Error sending message: $e');
      rethrow;
    }
  }

  /// Sends a reminder message
  Future<void> sendReminder(
    String content, {
    required DateTime dueDate,
    String priority = 'medium',
  }) async {
    try {
      await _webSocket.sendReminder(
        content,
        dueDate: dueDate,
        priority: priority,
      );
    } catch (e) {
      logger.e('Error sending reminder: $e');
      rethrow;
    }
  }

  /// Sends an alert message
  Future<void> sendAlert(String content, {String alertLevel = 'info'}) async {
    try {
      await _webSocket.sendAlert(content, alertLevel: alertLevel);
    } catch (e) {
      logger.e('Error sending alert: $e');
      rethrow;
    }
  }
}

/// Notifier for managing typing indicators
class ChatTypingNotifier extends StateNotifier<TypingUsersState> {
  final ChatWebSocketService _webSocket;

  ChatTypingNotifier(this._webSocket) : super({}) {
    _setupListeners();
  }

  void _setupListeners() {
    _webSocket.onTyping((userId, isTyping) {
      if (isTyping) {
        state = {...state, userId: isTyping};
        logger.d('User $userId is typing');
      } else {
        state = {...state}..remove(userId);
        logger.d('User $userId stopped typing');
      }
    });
  }

  /// Broadcasts typing status to other users
  Future<void> setTyping(bool isTyping) async {
    try {
      await _webSocket.broadcastTyping(isTyping);
    } catch (e) {
      logger.e('Error setting typing: $e');
    }
  }

  /// Gets the list of users currently typing
  List<String> get typingUsers =>
      state.entries.where((e) => e.value).map((e) => e.key).toList();

  /// Check if any user is typing
  bool get anyUserTyping => typingUsers.isNotEmpty;
}

/// Notifier for managing room users
class ChatRoomUsersNotifier extends StateNotifier<RoomUsersState> {
  final ChatWebSocketService _webSocket;

  ChatRoomUsersNotifier(this._webSocket) : super({}) {
    _setupListeners();
  }

  void _setupListeners() {
    _webSocket.onPresence((presence) {
      if (presence.type == 'user_joined') {
        state = {...state, presence.userId: presence.username};
        logger.d('User ${presence.username} joined');
      } else if (presence.type == 'user_left') {
        state = {...state}..remove(presence.userId);
        logger.d('User ${presence.username} left');
      }
    });
  }

  /// Gets list of users in the room
  List<String> get roomUsernames => state.values.toList();

  /// Get user count
  int get userCount => state.length;
}

/// Notifier for connection state
class ChatConnectionStateNotifier
    extends StateNotifier<WebSocketConnectionState> {
  final ChatWebSocketService _webSocket;

  ChatConnectionStateNotifier(this._webSocket)
    : super(WebSocketConnectionState.disconnected) {
    _setupListeners();
  }

  void _setupListeners() {
    _webSocket.onConnectionStateChanged((newState) {
      state = newState;
      logger.d('Connection state changed: ${newState.name}');
    });
  }

  /// Connect to a room
  Future<void> connectToRoom(String roomId) async {
    try {
      await _webSocket.connect(roomId);
    } catch (e) {
      logger.e('Error connecting to room: $e');
      rethrow;
    }
  }

  /// Disconnect from room
  void disconnect() {
    _webSocket.disconnect();
  }

  /// Check if connected
  bool get isConnected => state == WebSocketConnectionState.connected;
}

/// Notifier for error state
class ChatErrorNotifier extends StateNotifier<String?> {
  final ChatWebSocketService _webSocket;

  ChatErrorNotifier(this._webSocket) : super(null) {
    _setupListeners();
  }

  void _setupListeners() {
    _webSocket.onError((error) {
      state = error;
      logger.e('Chat error: $error');
      // Clear error after 5 seconds
      Future.delayed(const Duration(seconds: 5), () {
        if (state == error) {
          state = null;
        }
      });
    });
  }

  /// Manually clear the error
  void clearError() {
    state = null;
  }

  /// Check if there's an error
  bool get hasError => state != null;
}

/// Composite provider for quick access to all chat state
final chatStateProvider = Provider<ChatState>((ref) {
  final messages = ref.watch(chatMessagesProvider);
  final typingUsers = ref.watch(chatTypingUsersProvider);
  final roomUsers = ref.watch(chatRoomUsersProvider);
  final connectionState = ref.watch(chatConnectionStateProvider);
  final error = ref.watch(chatErrorProvider);

  return ChatState(
    messages: messages,
    typingUsers: typingUsers,
    roomUsers: roomUsers,
    connectionState: connectionState,
    error: error,
  );
});

/// Composite chat state
class ChatState {
  final List<Message> messages;
  final TypingUsersState typingUsers;
  final RoomUsersState roomUsers;
  final WebSocketConnectionState connectionState;
  final String? error;

  ChatState({
    required this.messages,
    required this.typingUsers,
    required this.roomUsers,
    required this.connectionState,
    required this.error,
  });

  bool get isConnected => connectionState == WebSocketConnectionState.connected;

  bool get isLoading => connectionState == WebSocketConnectionState.connecting;

  bool get hasError => error != null;

  List<String> get typingUsersList =>
      typingUsers.entries.where((e) => e.value).map((e) => e.key).toList();

  bool get anyoneTyping => typingUsersList.isNotEmpty;
}
