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
  messageType: $enumDecode(_$MessageTypeEnumMap, json['messageType']),
  sender: User.fromJson(json['sender'] as Map<String, dynamic>),
  channelId: json['channelId'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  isEdited: json['isEdited'] as bool? ?? false,
  metadata: json['metadata'] as Map<String, dynamic>? ?? {},
);

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
  'id': instance.id,
  'content': instance.content,
  'messageType': _$MessageTypeEnumMap[instance.messageType]!,
  'sender': instance.sender,
  'channelId': instance.channelId,
  'createdAt': instance.createdAt.toIso8601String(),
  'isEdited': instance.isEdited,
  'metadata': instance.metadata,
};

const _$MessageTypeEnumMap = {
  MessageType.text: 'text',
  MessageType.reminder: 'reminder',
  MessageType.alert: 'alert',
  MessageType.notification: 'notification',
};

WebSocketEvent _$WebSocketEventFromJson(Map<String, dynamic> json) =>
    WebSocketEvent(
      type: json['type'] as String,
      data: json['data'] as Map<String, dynamic>? ?? {},
    );

Map<String, dynamic> _$WebSocketEventToJson(WebSocketEvent instance) =>
    <String, dynamic>{'type': instance.type, 'data': instance.data};

TypingEvent _$TypingEventFromJson(Map<String, dynamic> json) =>
    TypingEvent(isTyping: json['isTyping'] as bool);

Map<String, dynamic> _$TypingEventToJson(TypingEvent instance) =>
    <String, dynamic>{'isTyping': instance.isTyping};

UserPresence _$UserPresenceFromJson(Map<String, dynamic> json) => UserPresence(
  userId: json['userId'] as String,
  username: json['username'] as String,
  type: json['type'] as String,
  timestamp: DateTime.parse(json['timestamp'] as String),
);

Map<String, dynamic> _$UserPresenceToJson(UserPresence instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'username': instance.username,
      'type': instance.type,
      'timestamp': instance.timestamp.toIso8601String(),
    };
