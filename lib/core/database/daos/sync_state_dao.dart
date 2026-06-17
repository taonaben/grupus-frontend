part of '../app_database.dart';

@DriftAccessor(tables: [SyncState])
class SyncStateDao extends DatabaseAccessor<AppDatabase>
    with _$SyncStateDaoMixin {
  SyncStateDao(super.db);

  Future<SyncStateData?> getScopeState({
    required String scopeType,
    required String scopeId,
  }) {
    return (select(syncState)
          ..where(
            (state) =>
                state.scopeType.equals(scopeType) &
                state.scopeId.equals(scopeId),
          )
          ..limit(1))
        .getSingleOrNull();
  }

  Future<void> upsertScopeSequence({
    required String scopeType,
    required String scopeId,
    required int serverSequence,
  }) async {
    await into(syncState).insertOnConflictUpdate(
      SyncStateCompanion.insert(
        scopeType: scopeType,
        scopeId: scopeId,
        lastServerSequence: Value(serverSequence),
        lastSyncedAt: Value(DateTime.now()),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }
}
