import 'package:drift/drift.dart';

@TableIndex(
  name: 'channels_server_id_unique',
  columns: {#serverId},
  unique: true,
)
class Channels extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get serverId => text().nullable()();
  TextColumn get workspaceId => text().nullable()();
  TextColumn get groupId => text().nullable()();
  TextColumn get name => text()();
  BoolColumn get isPrivate => boolean().withDefault(const Constant(false))();
  TextColumn get createdBy => text().nullable()();
  DateTimeColumn get serverCreatedAt => dateTime().nullable()();
  DateTimeColumn get lastSyncedAt => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
