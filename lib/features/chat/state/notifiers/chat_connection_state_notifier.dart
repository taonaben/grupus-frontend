import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import '../../services/websocket_services.dart';

class ChatConnectionStateNotifier
    extends StateNotifier<WebSocketConnectionState> {
  final ChatWebSocketService _webSocket;
  final Logger _logger = Logger();

  ChatConnectionStateNotifier(this._webSocket)
    : super(WebSocketConnectionState.disconnected) {
    _setupListeners();
  }

  void _setupListeners() {
    _webSocket.onConnectionStateChanged((newState) {
      state = newState;
      _logger.d('Connection state changed: ${newState.name}');
    });
  }

  /// Connect to a room
  Future<void> connectToRoom(String roomId) async {
    try {
      await _webSocket.connect(roomId);
    } catch (e) {
      _logger.e('Error connecting to room: $e');
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
