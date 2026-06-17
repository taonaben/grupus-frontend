import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:uuid/uuid.dart';

import 'converters/json_converters.dart';
import 'converters/sync_enum_converters.dart';
import 'sync_enums.dart';
import 'tables/app_settings_table.dart';
import 'tables/channels_table.dart';
import 'tables/message_attachments_table.dart';
import 'tables/messages_table.dart';
import 'tables/sync_tables.dart';
import 'tables/users_table.dart';
import 'tables/workspaces_table.dart';

part 'app_database.g.dart';
part 'daos/installation_identity_dao.dart';
part 'daos/sync_state_dao.dart';

@DriftDatabase(
  tables: [
    AppSettings,
    LocalUsers,
    Workspaces,
    Channels,
    Messages,
    MessageAttachments,
    SyncOutbox,
    SyncState,
    SyncErrors,
  ],
  daos: [InstallationIdentityDao, SyncStateDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator migrator) async {
      await migrator.createAll();
    },
    onUpgrade: (Migrator migrator, int from, int to) async {
      // Future schema versions must add explicit non-destructive migrations here.
    },
    beforeOpen: (OpeningDetails details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'grupus_offline');
  }
}
