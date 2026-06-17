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

  test('opens and creates expected tables', () async {
    final tables =
        await database
            .customSelect("select name from sqlite_master where type = 'table'")
            .get();
    final tableNames = tables.map((row) => row.read<String>('name')).toSet();

    expect(tableNames, contains('app_settings'));
    expect(tableNames, contains('local_users'));
    expect(tableNames, contains('workspaces'));
    expect(tableNames, contains('channels'));
    expect(tableNames, contains('messages'));
    expect(tableNames, contains('message_attachments'));
    expect(tableNames, contains('sync_outbox'));
    expect(tableNames, contains('sync_state'));
    expect(tableNames, contains('sync_errors'));
  });

  test('installation_id is generated once and reused', () async {
    final first =
        await database.installationIdentityDao.getOrCreateInstallationId();
    final second =
        await database.installationIdentityDao.getOrCreateInstallationId();

    expect(first, isNotEmpty);
    expect(second, first);
  });

  test('JSON converters round-trip workspace and message metadata', () async {
    final workspaceId = await database
        .into(database.workspaces)
        .insert(
          WorkspacesCompanion.insert(
            name: 'Research Lab',
            workspaceType: 'research',
            workspaceTypeName: 'Research',
            metadataJson: {'field': 'AI', 'members': 3},
          ),
        );

    final messageId = await database
        .into(database.messages)
        .insert(
          MessagesCompanion.insert(
            clientMessageId: const Value('client-message-1'),
            channelId: 'channel-1',
            senderId: 'user-1',
            senderUsername: 'taona',
            content: 'Hello',
            messageType: 'text',
            metadataJson: {'client_message_id': 'client-message-1'},
            clientCreatedAt: DateTime.utc(2026, 6, 17),
          ),
        );

    final workspace =
        await (database.select(database.workspaces)
          ..where((table) => table.id.equals(workspaceId))).getSingle();
    final message =
        await (database.select(database.messages)
          ..where((table) => table.id.equals(messageId))).getSingle();

    expect(workspace.metadataJson['field'], 'AI');
    expect(workspace.metadataJson['members'], 3);
    expect(message.metadataJson['client_message_id'], 'client-message-1');
  });

  test('message uniqueness prevents duplicate server and client ids', () async {
    await database
        .into(database.messages)
        .insert(
          MessagesCompanion.insert(
            serverId: const Value('server-message-1'),
            clientMessageId: const Value('client-message-1'),
            channelId: 'channel-1',
            senderId: 'user-1',
            senderUsername: 'taona',
            content: 'Hello',
            messageType: 'text',
            metadataJson: const {},
            clientCreatedAt: DateTime.utc(2026, 6, 17),
          ),
        );

    expect(
      () => database
          .into(database.messages)
          .insert(
            MessagesCompanion.insert(
              serverId: const Value('server-message-1'),
              channelId: 'channel-1',
              senderId: 'user-1',
              senderUsername: 'taona',
              content: 'Duplicate server id',
              messageType: 'text',
              metadataJson: const {},
              clientCreatedAt: DateTime.utc(2026, 6, 17),
            ),
          ),
      throwsA(anything),
    );

    expect(
      () => database
          .into(database.messages)
          .insert(
            MessagesCompanion.insert(
              clientMessageId: const Value('client-message-1'),
              channelId: 'channel-1',
              senderId: 'user-1',
              senderUsername: 'taona',
              content: 'Duplicate client id',
              messageType: 'text',
              metadataJson: const {},
              clientCreatedAt: DateTime.utc(2026, 6, 17),
            ),
          ),
      throwsA(anything),
    );
  });

  test('outbox uniqueness prevents duplicate client_mutation_id', () async {
    await database
        .into(database.syncOutbox)
        .insert(
          SyncOutboxCompanion.insert(
            clientMutationId: 'mutation-1',
            entityType: 'message',
            operation: SyncMutationOperation.create,
            payloadJson: {'content': 'Hello'},
          ),
        );

    expect(
      () => database
          .into(database.syncOutbox)
          .insert(
            SyncOutboxCompanion.insert(
              clientMutationId: 'mutation-1',
              entityType: 'message',
              operation: SyncMutationOperation.create,
              payloadJson: {'content': 'Duplicate'},
            ),
          ),
      throwsA(anything),
    );
  });

  test('sync state stores and updates per-channel sequence', () async {
    await database.syncStateDao.upsertScopeSequence(
      scopeType: 'channel',
      scopeId: 'channel-1',
      serverSequence: 10,
    );
    await database.syncStateDao.upsertScopeSequence(
      scopeType: 'channel',
      scopeId: 'channel-1',
      serverSequence: 12,
    );

    final state = await database.syncStateDao.getScopeState(
      scopeType: 'channel',
      scopeId: 'channel-1',
    );

    expect(state?.lastServerSequence, 12);
  });
}
