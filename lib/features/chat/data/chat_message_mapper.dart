import 'package:drift/drift.dart';
import 'package:grupus/core/database/app_database.dart' as db;
import 'package:grupus/core/database/sync_enums.dart';

import '../models/message_metadata_keys.dart';
import '../models/message_model.dart';

class ChatMessageMapper {
  const ChatMessageMapper();

  db.MessagesCompanion localMessageToCompanion(Message message) {
    final clientMessageId = _clientMessageIdFor(message) ?? message.id;
    return db.MessagesCompanion.insert(
      clientMessageId: Value(clientMessageId),
      channelId: message.channelId,
      senderId: message.sender.id,
      senderUsername: message.sender.username,
      content: message.content,
      messageType: _messageTypeToJson(message.messageType),
      metadataJson: message.metadata,
      clientCreatedAt: message.createdAt,
      isEdited: Value(message.isEdited),
      deliveryStatus: const Value(MessageDeliveryStatus.sending),
      updatedAt: Value(DateTime.now()),
    );
  }

  db.MessagesCompanion serverMessageToCompanion(Message message) {
    return db.MessagesCompanion.insert(
      serverId: Value(message.id),
      clientMessageId: Value(_clientMessageIdFor(message)),
      channelId: message.channelId,
      senderId: message.sender.id,
      senderUsername: message.sender.username,
      content: message.content,
      messageType: _messageTypeToJson(message.messageType),
      metadataJson: message.metadata,
      clientCreatedAt: message.createdAt,
      serverCreatedAt: Value(message.createdAt),
      serverUpdatedAt: Value(DateTime.now()),
      isEdited: Value(message.isEdited),
      deliveryStatus: const Value(MessageDeliveryStatus.sent),
      lastSyncedAt: Value(DateTime.now()),
      updatedAt: Value(DateTime.now()),
    );
  }

  Message rowToMessage(db.Message row) {
    return Message(
      id: row.serverId ?? row.clientMessageId ?? row.id.toString(),
      content: row.content,
      messageType: _messageTypeFromJson(row.messageType),
      sender: User(id: row.senderId, username: row.senderUsername),
      channelId: row.channelId,
      createdAt: row.serverCreatedAt ?? row.clientCreatedAt,
      isEdited: row.isEdited,
      metadata: row.metadataJson,
    );
  }

  String? _clientMessageIdFor(Message message) {
    final clientMessageId =
        message.metadata[MessageMetadataKeys.clientMessageId];
    return clientMessageId is String && clientMessageId.isNotEmpty
        ? clientMessageId
        : null;
  }

  MessageType _messageTypeFromJson(String value) {
    return switch (value) {
      'reminder' => MessageType.reminder,
      'alert' => MessageType.alert,
      'notification' => MessageType.notification,
      'file' => MessageType.file,
      'mention' => MessageType.mention,
      'reaction' => MessageType.reaction,
      _ => MessageType.text,
    };
  }

  String _messageTypeToJson(MessageType type) {
    return switch (type) {
      MessageType.text => 'text',
      MessageType.reminder => 'reminder',
      MessageType.alert => 'alert',
      MessageType.notification => 'notification',
      MessageType.file => 'file',
      MessageType.mention => 'mention',
      MessageType.reaction => 'reaction',
    };
  }
}
