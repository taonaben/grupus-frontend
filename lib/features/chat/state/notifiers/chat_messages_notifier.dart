import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import '../../models/message_metadata_keys.dart';
import '../../models/message_model.dart';
import '../../services/websocket_services.dart';

class ChatMessagesNotifier extends StateNotifier<List<Message>> {
  final ChatWebSocketService _webSocket;
  final Logger _logger = Logger();
  late final MessageCallback _messageListener;

  ChatMessagesNotifier(this._webSocket) : super([]) {
    _setupListeners();
  }

  void _setupListeners() {
    _messageListener = (message) {
      if (state.any((existing) => existing.id == message.id)) {
        return;
      }

      final clientMessageId = _clientMessageIdFor(message);
      if (clientMessageId != null) {
        final pendingIndex = state.indexWhere(
          (existing) =>
              existing.id != message.id &&
              _clientMessageIdFor(existing) == clientMessageId,
        );

        if (pendingIndex != -1) {
          final updatedMessages = [...state];
          updatedMessages[pendingIndex] = message;
          state = updatedMessages;
          _logger.d(
            'Pending message reconciled. Total messages: ${state.length}',
          );
          return;
        }
      }

      state = [...state, message];
      _logger.d('Message added. Total messages: ${state.length}');
    };
    _webSocket.onMessage(_messageListener);
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
  Future<void> sendMessage(
    String content, {
    Map<String, dynamic>? metadata,
  }) async {
    try {
      await _webSocket.sendMessage(content, metadata: metadata);
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

  /// Sends a reaction event for a message
  Future<void> sendReaction({
    required String messageId,
    required String emoji,
  }) async {
    try {
      await _webSocket.sendReaction(messageId: messageId, emoji: emoji);
    } catch (e) {
      _logger.e('Error sending reaction: $e');
      rethrow;
    }
  }

  @override
  void dispose() {
    _webSocket.offMessage(_messageListener);
    super.dispose();
  }

  String? _clientMessageIdFor(Message message) {
    final clientMessageId =
        message.metadata[MessageMetadataKeys.clientMessageId];
    return clientMessageId is String && clientMessageId.isNotEmpty
        ? clientMessageId
        : null;
  }
}
