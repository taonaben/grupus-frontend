import 'package:drift/drift.dart';

import '../converters/json_converters.dart';
import '../converters/sync_enum_converters.dart';

@TableIndex(
  name: 'sync_outbox_client_mutation_id_unique',
  columns: {#clientMutationId},
  unique: true,
)
@TableIndex(name: 'sync_outbox_scope_status', columns: {#scopeId, #status})
class SyncOutbox extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get clientMutationId => text()();
  TextColumn get entityType => text()();
  TextColumn get entityLocalId => text().nullable()();
  TextColumn get entityServerId => text().nullable()();
  TextColumn get operation => text().map(const MutationOperationConverter())();
  TextColumn get payloadJson => text().map(const JsonMapConverter())();
  TextColumn get scopeType => text().nullable()();
  TextColumn get scopeId => text().nullable()();
  TextColumn get status =>
      text()
          .withDefault(const Constant('pending'))
          .map(const MutationStatusConverter())();
  IntColumn get attemptCount => integer().withDefault(const Constant(0))();
  DateTimeColumn get nextRetryAt => dateTime().nullable()();
  TextColumn get lastError => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

@TableIndex(
  name: 'sync_state_scope_unique',
  columns: {#scopeType, #scopeId},
  unique: true,
)
class SyncState extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get scopeType => text()();
  TextColumn get scopeId => text()();
  IntColumn get lastServerSequence => integer().nullable()();
  DateTimeColumn get lastSyncedAt => dateTime().nullable()();
  TextColumn get cursorJson =>
      text().nullable().map(const NullableJsonMapConverter())();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

class SyncErrors extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get clientMutationId => text().nullable()();
  TextColumn get entityType => text()();
  TextColumn get entityLocalId => text().nullable()();
  TextColumn get entityServerId => text().nullable()();
  TextColumn get operation => text().map(const MutationOperationConverter())();
  TextColumn get errorCode => text().nullable()();
  TextColumn get errorMessage => text()();
  BoolColumn get retryable => boolean().withDefault(const Constant(false))();
  TextColumn get status =>
      text()
          .withDefault(const Constant('failed'))
          .map(const MutationStatusConverter())();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
