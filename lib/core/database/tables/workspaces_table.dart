import 'package:drift/drift.dart';

import '../converters/json_converters.dart';

@TableIndex(
  name: 'workspaces_server_id_unique',
  columns: {#serverId},
  unique: true,
)
class Workspaces extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get serverId => text().nullable()();
  TextColumn get name => text()();
  TextColumn get description => text().nullable()();
  TextColumn get workspaceType => text()();
  TextColumn get workspaceTypeName => text()();
  TextColumn get accessCode => text().nullable()();
  BoolColumn get isPublic => boolean().nullable()();
  BoolColumn get requiresApproval => boolean().nullable()();
  IntColumn get memberCount => integer().nullable()();
  IntColumn get maxMembers => integer().nullable()();
  IntColumn get channelCount => integer().nullable()();
  IntColumn get groupCount => integer().nullable()();
  TextColumn get contentGuidelines => text().nullable()();
  TextColumn get rulesJson =>
      text().nullable().map(const NullableJsonListConverter())();
  TextColumn get metadataJson => text().map(const JsonMapConverter())();
  TextColumn get createdBy => text().nullable()();
  DateTimeColumn get serverCreatedAt => dateTime().nullable()();
  DateTimeColumn get serverUpdatedAt => dateTime().nullable()();
  DateTimeColumn get lastSyncedAt => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
