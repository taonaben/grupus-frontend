import 'dart:convert';

import '../../models/message_model.dart';

enum ParsedWebSocketEventType { message, typing, presence, error, unknown }

class ParsedWebSocketEvent {
  final ParsedWebSocketEventType type;
  final Message? message;
  final String? userId;
  final bool? isTyping;
  final UserPresence? presence;
  final String? errorMessage;
  final String? rawEventType;

  const ParsedWebSocketEvent._({
    required this.type,
    this.message,
    this.userId,
    this.isTyping,
    this.presence,
    this.errorMessage,
    this.rawEventType,
  });

  factory ParsedWebSocketEvent.message(Message message) {
    return ParsedWebSocketEvent._(
      type: ParsedWebSocketEventType.message,
      message: message,
    );
  }

  factory ParsedWebSocketEvent.typing(String userId, bool isTyping) {
    return ParsedWebSocketEvent._(
      type: ParsedWebSocketEventType.typing,
      userId: userId,
      isTyping: isTyping,
    );
  }

  factory ParsedWebSocketEvent.presence(UserPresence presence) {
    return ParsedWebSocketEvent._(
      type: ParsedWebSocketEventType.presence,
      presence: presence,
    );
  }

  factory ParsedWebSocketEvent.error(String message) {
    return ParsedWebSocketEvent._(
      type: ParsedWebSocketEventType.error,
      errorMessage: message,
    );
  }

  factory ParsedWebSocketEvent.unknown(String rawEventType) {
    return ParsedWebSocketEvent._(
      type: ParsedWebSocketEventType.unknown,
      rawEventType: rawEventType,
    );
  }
}

class WebSocketEventParser {
  const WebSocketEventParser();

  ParsedWebSocketEvent parse(dynamic rawMessage) {
    final jsonData = jsonDecode(rawMessage as String) as Map<String, dynamic>;
    final event = WebSocketEvent.fromJson(jsonData);

    switch (event.type) {
      case 'message':
        final messageData = event.data['data'] as Map<String, dynamic>?;
        if (messageData == null) {
          return ParsedWebSocketEvent.error('Message payload missing data');
        }
        return ParsedWebSocketEvent.message(Message.fromJson(messageData));

      case 'typing':
        final userId = event.data['user_id'] as String?;
        if (userId == null) {
          return ParsedWebSocketEvent.error('Typing payload missing user_id');
        }
        final isTyping = event.data['is_typing'] as bool? ?? false;
        return ParsedWebSocketEvent.typing(userId, isTyping);

      case 'user_joined':
      case 'user_left':
        return ParsedWebSocketEvent.presence(UserPresence.fromJson(event.data));

      case 'error':
        final errorMsg = event.data['message'] as String? ?? 'Unknown error';
        return ParsedWebSocketEvent.error(errorMsg);

      default:
        return ParsedWebSocketEvent.unknown(event.type);
    }
  }
}
