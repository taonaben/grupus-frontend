import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:grupus/shared/utils/logs.dart';

import '../../services/websocket_services.dart';

class ChatConnectionStateNotifier
    extends StateNotifier<WebSocketConnectionState> {
  final ChatWebSocketService _webSocket;
  final Logger _logger = Logger();
  late final ConnectionStateCallback _connectionListener;

  ChatConnectionStateNotifier(this._webSocket)
    : super(WebSocketConnectionState.disconnected) {
    _setupListeners();
  }

  void _setupListeners() {
    _connectionListener = (newState) {
      DevLogs.logInfo(
        '[ChatConnectionNotifier] listener state ${state.name} -> ${newState.name}',
      );
      state = newState;
      _logger.d('Connection state changed: ${newState.name}');
    };
    _webSocket.onConnectionStateChanged(_connectionListener);
  }

  /// Connect to a room
  Future<void> connectToRoom(String roomId) async {
    try {
      DevLogs.logInfo('[ChatConnectionNotifier] connectToRoom room=$roomId');
      await _webSocket.connect(roomId);
      DevLogs.logInfo('[ChatConnectionNotifier] connectToRoom complete room=$roomId');
    } catch (e) {
      DevLogs.logError('[ChatConnectionNotifier] connectToRoom error: $e');
      _logger.e('Error connecting to room: $e');
      rethrow;
    }
  }

  /// Disconnect from room
  void disconnect() {
    DevLogs.logInfo('[ChatConnectionNotifier] disconnect called');
    _webSocket.disconnect();
  }

  /// Check if connected
  bool get isConnected => state == WebSocketConnectionState.connected;

  @override
  void dispose() {
    DevLogs.logInfo('[ChatConnectionNotifier] dispose start');
    _webSocket.offConnectionStateChanged(_connectionListener);
    super.dispose();
    DevLogs.logInfo('[ChatConnectionNotifier] dispose complete');
  }
}
