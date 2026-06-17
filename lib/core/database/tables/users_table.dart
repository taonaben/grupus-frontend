import 'package:drift/drift.dart';

import '../converters/json_converters.dart';

@TableIndex(
  name: 'local_users_server_id_unique',
  columns: {#serverId},
  unique: true,
)
class LocalUsers extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get serverId => text().nullable()();
  TextColumn get username => text()();
  TextColumn get email => text().nullable()();
  BoolColumn get isEmailVerified =>
      boolean().withDefault(const Constant(false))();
  TextColumn get profileJson =>
      text().nullable().map(const NullableJsonMapConverter())();
  TextColumn get statsJson =>
      text().nullable().map(const NullableJsonMapConverter())();
  TextColumn get subscriptionJson =>
      text().nullable().map(const NullableJsonMapConverter())();
  DateTimeColumn get lastSyncedAt => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
