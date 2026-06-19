import 'package:drift/drift.dart';
import 'package:grupus/core/database/app_database.dart' hide Message;
import 'package:grupus/core/database/sync_enums.dart';
import 'package:uuid/uuid.dart';

import '../models/message_metadata_keys.dart';
import '../models/message_model.dart' show Message, MessageType, User;
import '../services/websocket/websocket_event_payload_builder.dart';
import 'chat_message_mapper.dart';

class ChatMessageSendResult {
  final Message message;
  final String clientMessageId;
  final String clientMutationId;

  const ChatMessageSendResult({
    required this.message,
    required this.clientMessageId,
    required this.clientMutationId,
  });
}

class ChatMessageSendService {
  ChatMessageSendService({
    required AppDatabase database,
    ChatMessageMapper mapper = const ChatMessageMapper(),
    Uuid uuid = const Uuid(),
    WebSocketEventPayloadBuilder payloadBuilder =
        const WebSocketEventPayloadBuilder(),
  }) : _database = database,
       _mapper = mapper,
       _uuid = uuid,
       _payloadBuilder = payloadBuilder;

  final AppDatabase _database;
  final ChatMessageMapper _mapper;
  final Uuid _uuid;
  final WebSocketEventPayloadBuilder _payloadBuilder;

  Future<ChatMessageSendResult> sendTextMessage({
    required String content,
    required String channelId,
    required String senderId,
    required String senderUsername,
  }) async {
    final trimmedContent = content.trim();
    if (trimmedContent.isEmpty) {
      throw ArgumentError.value(content, 'content', 'Message cannot be empty');
    }

    final clientMessageId = _uuid.v4();
    final clientMutationId = _uuid.v4();
    final metadata = <String, dynamic>{
      MessageMetadataKeys.clientMessageId: clientMessageId,
      MessageMetadataKeys.clientMutationId: clientMutationId,
    };
    final transportMetadata = <String, dynamic>{
      MessageMetadataKeys.clientMessageId: clientMessageId,
    };
    final now = DateTime.now();
    final message = Message(
      id: clientMessageId,
      content: trimmedContent,
      messageType: MessageType.text,
      sender: User(id: senderId, username: senderUsername),
      channelId: channelId,
      createdAt: now,
      metadata: metadata,
    );
    final payload = _payloadBuilder.buildTextMessage(
      trimmedContent,
      metadata: transportMetadata,
    );

    await _database.transaction(() async {
      await _database.chatMessagesDao.insertLocalMessage(
        _mapper.localMessageToCompanion(message),
      );
      await _database.syncOutboxDao.enqueueMessageCreate(
        SyncOutboxCompanion.insert(
          clientMutationId: clientMutationId,
          entityType: 'message',
          entityLocalId: Value(clientMessageId),
          operation: SyncMutationOperation.create,
          payloadJson: payload,
          scopeType: const Value('channel'),
          scopeId: Value(channelId),
          status: const Value(SyncMutationStatus.pending),
          updatedAt: Value(now),
        ),
      );
    });

    return ChatMessageSendResult(
      message: message,
      clientMessageId: clientMessageId,
      clientMutationId: clientMutationId,
    );
  }
}
