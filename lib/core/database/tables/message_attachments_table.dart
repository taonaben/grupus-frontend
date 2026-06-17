import 'package:drift/drift.dart';

import '../converters/sync_enum_converters.dart';

@TableIndex(
  name: 'message_attachments_server_id_unique',
  columns: {#serverId},
  unique: true,
)
class MessageAttachments extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get serverId => text().nullable()();
  IntColumn get messageLocalId => integer().nullable()();
  TextColumn get messageServerId => text().nullable()();
  TextColumn get localFilePath => text().nullable()();
  TextColumn get remoteUrl => text().nullable()();
  TextColumn get mimeType => text().nullable()();
  IntColumn get sizeBytes => integer().nullable()();
  TextColumn get checksum => text().nullable()();
  TextColumn get transferStatus =>
      text()
          .withDefault(const Constant('local_only'))
          .map(const AttachmentTransferStatusConverter())();
  IntColumn get attemptCount => integer().withDefault(const Constant(0))();
  TextColumn get lastError => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
