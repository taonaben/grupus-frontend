import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import '../../services/websocket_services.dart';
import '../chat_types.dart';

class ChatRoomUsersNotifier extends StateNotifier<RoomUsersState> {
  final ChatWebSocketService _webSocket;
  final Logger _logger = Logger();

  ChatRoomUsersNotifier(this._webSocket) : super({}) {
    _setupListeners();
  }

  void _setupListeners() {
    _webSocket.onPresence((presence) {
      if (presence.type == 'user_joined') {
        state = {...state, presence.userId: presence.username};
        _logger.d('User ${presence.username} joined');
      } else if (presence.type == 'user_left') {
        state = {...state}..remove(presence.userId);
        _logger.d('User ${presence.username} left');
      }
    });
  }

  /// Gets list of users in the room
  List<String> get roomUsernames => state.values.toList();

  /// Get user count
  int get userCount => state.length;
}
