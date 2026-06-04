import '../models/message_model.dart';
import 'chat_types.dart';
import '../services/websocket_services.dart';

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
