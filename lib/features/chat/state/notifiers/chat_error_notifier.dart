import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import '../../services/websocket_services.dart';

class ChatErrorNotifier extends StateNotifier<String?> {
  final ChatWebSocketService _webSocket;
  final Logger _logger = Logger();

  ChatErrorNotifier(this._webSocket) : super(null) {
    _setupListeners();
  }

  void _setupListeners() {
    _webSocket.onError((error) {
      state = error;
      _logger.e('Chat error: $error');
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
