import 'package:json_annotation/json_annotation.dart';

part 'message_model.g.dart';

/// Represents the different types of messages supported by the chat system
enum MessageType {
  @JsonValue('text')
  text,
  @JsonValue('reminder')
  reminder,
  @JsonValue('alert')
  alert,
  @JsonValue('notification')
  notification,
  @JsonValue('file')
  file,
  @JsonValue('mention')
  mention,
  @JsonValue('reaction')
  reaction,
}

/// Represents a user who sends messages
@JsonSerializable()
class User {
  final String id;
  final String username;

  User({required this.id, required this.username});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

/// Represents a single message in the chat
@JsonSerializable(fieldRename: FieldRename.snake)
class Message {
  final String id;
  final String content;
  final MessageType messageType;
  final User sender;
  final String channelId;
  final DateTime createdAt;
  @JsonKey(defaultValue: false)
  final bool isEdited;
  @JsonKey(defaultValue: {})
  final Map<String, dynamic> metadata;

  Message({
    required this.id,
    required this.content,
    required this.messageType,
    required this.sender,
    required this.channelId,
    required this.createdAt,
    this.isEdited = false,
    this.metadata = const {},
  });

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);

  /// Creates a copy of this message with optional fields overridden
  Message copyWith({
    String? id,
    String? content,
    MessageType? messageType,
    User? sender,
    String? channelId,
    DateTime? createdAt,
    bool? isEdited,
    Map<String, dynamic>? metadata,
  }) {
    return Message(
      id: id ?? this.id,
      content: content ?? this.content,
      messageType: messageType ?? this.messageType,
      sender: sender ?? this.sender,
      channelId: channelId ?? this.channelId,
      createdAt: createdAt ?? this.createdAt,
      isEdited: isEdited ?? this.isEdited,
      metadata: metadata ?? this.metadata,
    );
  }
}

/// Represents a WebSocket event from the server
@JsonSerializable(fieldRename: FieldRename.snake)
class WebSocketEvent {
  final String
  type; // 'message', 'typing', 'user_joined', 'user_left', 'reaction', 'error'
  @JsonKey(defaultValue: {})
  final Map<String, dynamic> data;

  @JsonKey(name: 'user_id')
  final String? userId;

  final String? username;

  @JsonKey(name: 'is_typing')
  final bool? isTyping;

  @JsonKey(name: 'message_id')
  final String? messageId;

  final String? emoji;
  final String? message;
  final DateTime? timestamp;

  WebSocketEvent({
    required this.type,
    this.data = const {},
    this.userId,
    this.username,
    this.isTyping,
    this.messageId,
    this.emoji,
    this.message,
    this.timestamp,
  });

  factory WebSocketEvent.fromJson(Map<String, dynamic> json) =>
      _$WebSocketEventFromJson(json);

  Map<String, dynamic> toJson() => _$WebSocketEventToJson(this);
}

/// Represents typing indicator state
@JsonSerializable(fieldRename: FieldRename.snake)
class TypingEvent {
  final String type; // 'typing'
  final bool isTyping;

  TypingEvent({required this.isTyping}) : type = 'typing';

  factory TypingEvent.fromJson(Map<String, dynamic> json) =>
      _$TypingEventFromJson(json);

  Map<String, dynamic> toJson() => _$TypingEventToJson(this);
}

/// Represents user presence in the chat
@JsonSerializable(fieldRename: FieldRename.snake)
class UserPresence {
  final String userId;
  final String username;
  final String type; // 'user_joined' or 'user_left'
  final DateTime timestamp;

  UserPresence({
    required this.userId,
    required this.username,
    required this.type,
    required this.timestamp,
  });

  factory UserPresence.fromJson(Map<String, dynamic> json) =>
      _$UserPresenceFromJson(json);

  Map<String, dynamic> toJson() => _$UserPresenceToJson(this);
}

/// Represents message reactions from chat users
@JsonSerializable(fieldRename: FieldRename.snake)
class ReactionEvent {
  final String type; // 'reaction'
  final String messageId;
  final String userId;
  final String username;
  final String emoji;
  final DateTime timestamp;

  ReactionEvent({
    required this.type,
    required this.messageId,
    required this.userId,
    required this.username,
    required this.emoji,
    required this.timestamp,
  });

  factory ReactionEvent.fromJson(Map<String, dynamic> json) =>
      _$ReactionEventFromJson(json);

  Map<String, dynamic> toJson() => _$ReactionEventToJson(this);
}
