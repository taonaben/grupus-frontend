part of '../app_database.dart';

@DriftAccessor(tables: [SyncOutbox])
class SyncOutboxDao extends DatabaseAccessor<AppDatabase>
    with _$SyncOutboxDaoMixin {
  SyncOutboxDao(super.db);

  Future<void> enqueueMessageCreate(SyncOutboxCompanion companion) async {
    await into(syncOutbox).insertOnConflictUpdate(companion);
  }

  Stream<int> watchPendingCount({
    required String scopeType,
    required String scopeId,
  }) {
    final count = syncOutbox.id.count();
    final query = selectOnly(syncOutbox)
      ..addColumns([count])
      ..where(syncOutbox.scopeType.equals(scopeType))
      ..where(syncOutbox.scopeId.equals(scopeId))
      ..where(syncOutbox.status.equalsValue(SyncMutationStatus.pending));

    return query.watchSingle().map((row) => row.read(count) ?? 0);
  }

  Future<List<SyncOutboxData>> getPendingMessageCreates({
    required String scopeId,
  }) {
    return (select(syncOutbox)
          ..where((row) => row.entityType.equals('message'))
          ..where((row) => row.operation.equalsValue(SyncMutationOperation.create))
          ..where((row) => row.scopeType.equals('channel'))
          ..where((row) => row.scopeId.equals(scopeId))
          ..where((row) => row.status.equalsValue(SyncMutationStatus.pending))
          ..orderBy([
            (row) => OrderingTerm.asc(row.createdAt),
            (row) => OrderingTerm.asc(row.id),
          ]))
        .get();
  }

  Future<void> markSynced(String clientMutationId) async {
    await (update(syncOutbox)
          ..where((row) => row.clientMutationId.equals(clientMutationId)))
        .write(
          SyncOutboxCompanion(
            status: const Value(SyncMutationStatus.synced),
            lastError: const Value(null),
            updatedAt: Value(DateTime.now()),
          ),
        );
  }

  Future<void> markRetrying({
    required String clientMutationId,
    required String error,
  }) async {
    final existing =
        await (select(syncOutbox)
              ..where((row) => row.clientMutationId.equals(clientMutationId))
              ..limit(1))
            .getSingleOrNull();

    await (update(syncOutbox)
          ..where((row) => row.clientMutationId.equals(clientMutationId)))
        .write(
          SyncOutboxCompanion(
            status: const Value(SyncMutationStatus.retrying),
            attemptCount: Value((existing?.attemptCount ?? 0) + 1),
            lastError: Value(error),
            updatedAt: Value(DateTime.now()),
          ),
        );
  }

  Future<void> resetRetryingToPending({required String scopeId}) async {
    await (update(syncOutbox)
          ..where((row) => row.scopeType.equals('channel'))
          ..where((row) => row.scopeId.equals(scopeId))
          ..where((row) => row.status.equalsValue(SyncMutationStatus.retrying)))
        .write(
          SyncOutboxCompanion(
            status: const Value(SyncMutationStatus.pending),
            updatedAt: Value(DateTime.now()),
          ),
        );
  }
}
