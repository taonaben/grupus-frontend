class WebSocketEventPayloadBuilder {
  const WebSocketEventPayloadBuilder();

  Map<String, dynamic> buildTextMessage(
    String content, {
    Map<String, dynamic>? metadata,
  }) {
    return {
      'type': 'message',
      'message_type': 'text',
      'content': content,
      'metadata': metadata ?? <String, dynamic>{},
    };
  }

  Map<String, dynamic> buildTyping(bool isTyping) {
    return {'type': 'typing', 'is_typing': isTyping};
  }

  Map<String, dynamic> buildReaction({
    required String messageId,
    required String emoji,
  }) {
    return {'type': 'reaction', 'message_id': messageId, 'emoji': emoji};
  }

  Map<String, dynamic> buildReminder(
    String content, {
    required DateTime dueDate,
    String priority = 'medium',
    Map<String, dynamic>? metadata,
  }) {
    return {
      'type': 'message',
      'message_type': 'reminder',
      'content': content,
      'metadata': {
        'due_date': dueDate.toIso8601String(),
        'priority': priority,
        if (metadata != null) ...metadata,
      },
    };
  }

  Map<String, dynamic> buildAlert(
    String content, {
    String alertLevel = 'info',
    Map<String, dynamic>? metadata,
  }) {
    return {
      'type': 'message',
      'message_type': 'alert',
      'content': content,
      'metadata': {
        'alert_level': alertLevel,
        if (metadata != null) ...metadata,
      },
    };
  }
}
