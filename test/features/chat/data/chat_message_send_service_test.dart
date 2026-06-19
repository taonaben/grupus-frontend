import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:grupus/core/database/app_database.dart';
import 'package:grupus/core/database/sync_enums.dart';
import 'package:grupus/features/chat/data/chat_message_send_service.dart';
import 'package:grupus/features/chat/models/message_metadata_keys.dart';

void main() {
  late AppDatabase database;
  late ChatMessageSendService service;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
    service = ChatMessageSendService(database: database);
  });

  tearDown(() async {
    await database.close();
  });

  test('sendTextMessage inserts local message and outbox row', () async {
    final result = await service.sendTextMessage(
      content: 'Hello',
      channelId: 'channel-1',
      senderId: 'user-1',
      senderUsername: 'taona',
    );

    final messages = await database.select(database.messages).get();
    final outbox = await database.select(database.syncOutbox).get();

    expect(messages, hasLength(1));
    expect(messages.single.content, 'Hello');
    expect(messages.single.clientMessageId, result.clientMessageId);
    expect(messages.single.serverId, isNull);
    expect(messages.single.deliveryStatus, MessageDeliveryStatus.sending);

    expect(outbox, hasLength(1));
    expect(outbox.single.clientMutationId, result.clientMutationId);
    expect(outbox.single.entityType, 'message');
    expect(outbox.single.operation, SyncMutationOperation.create);
    expect(outbox.single.scopeType, 'channel');
    expect(outbox.single.scopeId, 'channel-1');
  });

  test('generated metadata contains client message and mutation ids', () async {
    final result = await service.sendTextMessage(
      content: 'Hello',
      channelId: 'channel-1',
      senderId: 'user-1',
      senderUsername: 'taona',
    );

    final message = await database.select(database.messages).getSingle();
    final mutation = await database.select(database.syncOutbox).getSingle();
    final payloadMetadata = mutation.payloadJson['metadata'];

    expect(
      message.metadataJson[MessageMetadataKeys.clientMessageId],
      result.clientMessageId,
    );
    expect(
      message.metadataJson[MessageMetadataKeys.clientMutationId],
      result.clientMutationId,
    );
    expect(payloadMetadata, isA<Map<String, dynamic>>());
    expect(
      (payloadMetadata as Map<String, dynamic>)[
          MessageMetadataKeys.clientMessageId],
      result.clientMessageId,
    );
    expect(payloadMetadata.containsKey(MessageMetadataKeys.clientMutationId), isFalse);
  });
}
