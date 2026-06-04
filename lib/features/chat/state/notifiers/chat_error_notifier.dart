import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'dart:async';

import '../../services/websocket_services.dart';

class ChatErrorNotifier extends StateNotifier<String?> {
  final ChatWebSocketService _webSocket;
  final Logger _logger = Logger();
  late final ErrorCallback _errorListener;
  Timer? _clearErrorTimer;
  bool _isDisposed = false;

  ChatErrorNotifier(this._webSocket) : super(null) {
    _setupListeners();
  }

  void _setupListeners() {
    _errorListener = (error) {
      if (_isDisposed) {
        return;
      }

      state = error;
      _logger.e('Chat error: $error');

      // Clear error after 5 seconds
      _clearErrorTimer?.cancel();
      _clearErrorTimer = Timer(const Duration(seconds: 5), () {
        if (!_isDisposed && state == error) {
          state = null;
        }
      });
    };
    _webSocket.onError(_errorListener);
  }

  /// Manually clear the error
  void clearError() {
    state = null;
  }

  /// Check if there's an error
  bool get hasError => state != null;

  @override
  void dispose() {
    _isDisposed = true;
    _clearErrorTimer?.cancel();
    _clearErrorTimer = null;
    _webSocket.offError(_errorListener);
    super.dispose();
  }
}
