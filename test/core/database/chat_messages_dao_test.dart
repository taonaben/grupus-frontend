import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:grupus/core/database/app_database.dart';
import 'package:grupus/core/database/sync_enums.dart';

void main() {
  late AppDatabase database;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
  });

  tearDown(() async {
    await database.close();
  });

  MessagesCompanion message({
    String? serverId,
    String? clientMessageId,
    String channelId = 'channel-1',
    String content = 'Hello',
    DateTime? clientCreatedAt,
    int? serverSequence,
  }) {
    return MessagesCompanion.insert(
      serverId: Value(serverId),
      clientMessageId: Value(clientMessageId),
      channelId: channelId,
      senderId: 'user-1',
      senderUsername: 'taona',
      content: content,
      messageType: 'text',
      metadataJson: {
        if (clientMessageId != null) 'client_message_id': clientMessageId,
      },
      clientCreatedAt: clientCreatedAt ?? DateTime.utc(2026, 6, 17, 10),
      serverCreatedAt:
          serverId == null
              ? const Value.absent()
              : Value(clientCreatedAt ?? DateTime.utc(2026, 6, 17, 10)),
      serverSequence:
          serverSequence == null ? const Value.absent() : Value(serverSequence),
      deliveryStatus: Value(
        serverId == null
            ? MessageDeliveryStatus.sending
            : MessageDeliveryStatus.sent,
      ),
    );
  }

  test('watchByChannel emits inserted messages for that channel', () async {
    final stream = database.chatMessagesDao.watchByChannel('channel-1');

    await database.chatMessagesDao.insertLocalMessage(
      message(clientMessageId: 'client-1'),
    );
    await database.chatMessagesDao.insertLocalMessage(
      message(channelId: 'channel-2', clientMessageId: 'client-2'),
    );

    final rows = await stream.firstWhere((items) => items.isNotEmpty);

    expect(rows, hasLength(1));
    expect(rows.single.clientMessageId, 'client-1');
  });

  test('upsertServerMessage inserts new server messages', () async {
    await database.chatMessagesDao.upsertServerMessage(
      message(serverId: 'server-1', clientMessageId: 'client-1'),
    );

    final rows = await database.select(database.messages).get();

    expect(rows, hasLength(1));
    expect(rows.single.serverId, 'server-1');
    expect(rows.single.deliveryStatus, MessageDeliveryStatus.sent);
  });

  test('upsertServerMessage reconciles pending row by client_message_id', () async {
    await database.chatMessagesDao.insertLocalMessage(
      message(clientMessageId: 'client-1', content: 'Pending'),
    );

    await database.chatMessagesDao.upsertServerMessage(
      message(
        serverId: 'server-1',
        clientMessageId: 'client-1',
        content: 'Confirmed',
        serverSequence: 4,
      ),
    );

    final rows = await database.select(database.messages).get();

    expect(rows, hasLength(1));
    expect(rows.single.serverId, 'server-1');
    expect(rows.single.content, 'Confirmed');
    expect(rows.single.serverSequence, 4);
    expect(rows.single.deliveryStatus, MessageDeliveryStatus.sent);
  });

  test('duplicate server_id updates existing row instead of inserting', () async {
    await database.chatMessagesDao.upsertServerMessage(
      message(serverId: 'server-1', content: 'First'),
    );
    await database.chatMessagesDao.upsertServerMessage(
      message(serverId: 'server-1', content: 'Updated'),
    );

    final rows = await database.select(database.messages).get();

    expect(rows, hasLength(1));
    expect(rows.single.content, 'Updated');
  });

  test('watchByChannel sorts confirmed messages by sequence', () async {
    await database.chatMessagesDao.upsertServerMessage(
      message(
        serverId: 'server-2',
        content: 'Second',
        clientCreatedAt: DateTime.utc(2026, 6, 17, 10, 2),
        serverSequence: 2,
      ),
    );
    await database.chatMessagesDao.insertLocalMessage(
      message(
        clientMessageId: 'client-pending',
        content: 'Pending',
        clientCreatedAt: DateTime.utc(2026, 6, 17, 10, 3),
      ),
    );
    await database.chatMessagesDao.upsertServerMessage(
      message(
        serverId: 'server-1',
        content: 'First',
        clientCreatedAt: DateTime.utc(2026, 6, 17, 10, 1),
        serverSequence: 1,
      ),
    );

    final rows =
        await database.chatMessagesDao
            .watchByChannel('channel-1')
            .firstWhere((items) => items.length == 3);

    expect(rows.map((row) => row.content), ['First', 'Second', 'Pending']);
  });
}
