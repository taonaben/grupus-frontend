import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import '../../models/message_model.dart';
import '../../services/websocket_services.dart';

class ChatMessagesNotifier extends StateNotifier<List<Message>> {
  final ChatWebSocketService _webSocket;
  final Logger _logger = Logger();

  ChatMessagesNotifier(this._webSocket) : super([]) {
    _setupListeners();
  }

  void _setupListeners() {
    _webSocket.onMessage((message) {
      if (state.any((existing) => existing.id == message.id)) {
        return;
      }
      state = [...state, message];
      _logger.d('Message added. Total messages: ${state.length}');
    });
  }

  /// Adds a message locally (before it's sent)
  void addLocalMessage(Message message) {
    if (state.any((existing) => existing.id == message.id)) {
      return;
    }
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
      _logger.e('Error sending message: $e');
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
      _logger.e('Error sending reminder: $e');
      rethrow;
    }
  }

  /// Sends an alert message
  Future<void> sendAlert(String content, {String alertLevel = 'info'}) async {
    try {
      await _webSocket.sendAlert(content, alertLevel: alertLevel);
    } catch (e) {
      _logger.e('Error sending alert: $e');
      rethrow;
    }
  }
}
