import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import '../../services/websocket_services.dart';
import '../chat_types.dart';

class ChatTypingNotifier extends StateNotifier<TypingUsersState> {
  final ChatWebSocketService _webSocket;
  final Logger _logger = Logger();
  late final TypingCallback _typingListener;

  ChatTypingNotifier(this._webSocket) : super({}) {
    _setupListeners();
  }

  void _setupListeners() {
    _typingListener = (userId, isTyping) {
      if (isTyping) {
        state = {...state, userId: isTyping};
        _logger.d('User $userId is typing');
      } else {
        state = {...state}..remove(userId);
        _logger.d('User $userId stopped typing');
      }
    };
    _webSocket.onTyping(_typingListener);
  }

  /// Broadcasts typing status to other users
  Future<void> setTyping(bool isTyping) async {
    try {
      await _webSocket.broadcastTyping(isTyping);
    } catch (e) {
      _logger.e('Error setting typing: $e');
    }
  }

  /// Gets the list of users currently typing
  List<String> get typingUsers =>
      state.entries.where((e) => e.value).map((e) => e.key).toList();

  /// Check if any user is typing
  bool get anyUserTyping => typingUsers.isNotEmpty;

  @override
  void dispose() {
    _webSocket.offTyping(_typingListener);
    super.dispose();
  }
}
