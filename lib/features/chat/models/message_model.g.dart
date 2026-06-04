// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) =>
    User(id: json['id'] as String, username: json['username'] as String);

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  'id': instance.id,
  'username': instance.username,
};

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
  id: json['id'] as String,
  content: json['content'] as String,
  messageType: $enumDecode(_$MessageTypeEnumMap, json['message_type']),
  sender: User.fromJson(json['sender'] as Map<String, dynamic>),
  channelId: json['channel_id'] as String,
  createdAt: DateTime.parse(json['created_at'] as String),
  isEdited: json['is_edited'] as bool? ?? false,
  metadata: json['metadata'] as Map<String, dynamic>? ?? {},
);

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
  'id': instance.id,
  'content': instance.content,
  'message_type': _$MessageTypeEnumMap[instance.messageType]!,
  'sender': instance.sender,
  'channel_id': instance.channelId,
  'created_at': instance.createdAt.toIso8601String(),
  'is_edited': instance.isEdited,
  'metadata': instance.metadata,
};

const _$MessageTypeEnumMap = {
  MessageType.text: 'text',
  MessageType.reminder: 'reminder',
  MessageType.alert: 'alert',
  MessageType.notification: 'notification',
  MessageType.file: 'file',
  MessageType.mention: 'mention',
  MessageType.reaction: 'reaction',
};

WebSocketEvent _$WebSocketEventFromJson(Map<String, dynamic> json) =>
    WebSocketEvent(
      type: json['type'] as String,
      data: json['data'] as Map<String, dynamic>? ?? {},
      userId: json['user_id'] as String?,
      username: json['username'] as String?,
      isTyping: json['is_typing'] as bool?,
      messageId: json['message_id'] as String?,
      emoji: json['emoji'] as String?,
      message: json['message'] as String?,
      timestamp:
          json['timestamp'] == null
              ? null
              : DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$WebSocketEventToJson(WebSocketEvent instance) =>
    <String, dynamic>{
      'type': instance.type,
      'data': instance.data,
      'user_id': instance.userId,
      'username': instance.username,
      'is_typing': instance.isTyping,
      'message_id': instance.messageId,
      'emoji': instance.emoji,
      'message': instance.message,
      'timestamp': instance.timestamp?.toIso8601String(),
    };

TypingEvent _$TypingEventFromJson(Map<String, dynamic> json) =>
    TypingEvent(isTyping: json['is_typing'] as bool);

Map<String, dynamic> _$TypingEventToJson(TypingEvent instance) =>
    <String, dynamic>{'is_typing': instance.isTyping};

UserPresence _$UserPresenceFromJson(Map<String, dynamic> json) => UserPresence(
  userId: json['user_id'] as String,
  username: json['username'] as String,
  type: json['type'] as String,
  timestamp: DateTime.parse(json['timestamp'] as String),
);

Map<String, dynamic> _$UserPresenceToJson(UserPresence instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'username': instance.username,
      'type': instance.type,
      'timestamp': instance.timestamp.toIso8601String(),
    };

ReactionEvent _$ReactionEventFromJson(Map<String, dynamic> json) =>
    ReactionEvent(
      type: json['type'] as String,
      messageId: json['message_id'] as String,
      userId: json['user_id'] as String,
      username: json['username'] as String,
      emoji: json['emoji'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$ReactionEventToJson(ReactionEvent instance) =>
    <String, dynamic>{
      'type': instance.type,
      'message_id': instance.messageId,
      'user_id': instance.userId,
      'username': instance.username,
      'emoji': instance.emoji,
      'timestamp': instance.timestamp.toIso8601String(),
    };
