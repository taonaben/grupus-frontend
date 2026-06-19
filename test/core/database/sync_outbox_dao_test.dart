import 'package:drift/drift.dart' hide isNull;
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

  SyncOutboxCompanion mutation(String id, {DateTime? createdAt}) {
    return SyncOutboxCompanion.insert(
      clientMutationId: id,
      entityType: 'message',
      entityLocalId: Value('client-message-$id'),
      operation: SyncMutationOperation.create,
      payloadJson: {
        'type': 'message',
        'message_type': 'text',
        'content': 'Hello $id',
        'metadata': {'client_mutation_id': id},
      },
      scopeType: const Value('channel'),
      scopeId: const Value('channel-1'),
      createdAt:
          createdAt == null ? const Value.absent() : Value(createdAt),
    );
  }

  test('enqueues message create mutation', () async {
    await database.syncOutboxDao.enqueueMessageCreate(mutation('mutation-1'));

    final rows = await database.select(database.syncOutbox).get();

    expect(rows, hasLength(1));
    expect(rows.single.clientMutationId, 'mutation-1');
    expect(rows.single.status, SyncMutationStatus.pending);
  });

  test('fetches pending message creates in FIFO order by channel', () async {
    await database.syncOutboxDao.enqueueMessageCreate(
      mutation('mutation-2', createdAt: DateTime.utc(2026, 6, 17, 10, 2)),
    );
    await database.syncOutboxDao.enqueueMessageCreate(
      mutation('mutation-1', createdAt: DateTime.utc(2026, 6, 17, 10, 1)),
    );

    final rows = await database.syncOutboxDao.getPendingMessageCreates(
      scopeId: 'channel-1',
    );

    expect(rows.map((row) => row.clientMutationId), [
      'mutation-1',
      'mutation-2',
    ]);
  });

  test('marks mutation synced', () async {
    await database.syncOutboxDao.enqueueMessageCreate(mutation('mutation-1'));

    await database.syncOutboxDao.markSynced('mutation-1');

    final row = await database.select(database.syncOutbox).getSingle();
    expect(row.status, SyncMutationStatus.synced);
    expect(row.lastError, isNull);
  });

  test('duplicate client_mutation_id is upsert-safe', () async {
    await database.syncOutboxDao.enqueueMessageCreate(mutation('mutation-1'));
    await database.syncOutboxDao.enqueueMessageCreate(mutation('mutation-1'));

    final rows = await database.select(database.syncOutbox).get();

    expect(rows, hasLength(1));
    expect(rows.single.clientMutationId, 'mutation-1');
  });
}
