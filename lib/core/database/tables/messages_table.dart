import 'package:drift/drift.dart';

import '../converters/json_converters.dart';
import '../converters/sync_enum_converters.dart';

@TableIndex(
  name: 'messages_server_id_unique',
  columns: {#serverId},
  unique: true,
)
@TableIndex(
  name: 'messages_client_message_id_unique',
  columns: {#clientMessageId},
  unique: true,
)
@TableIndex(
  name: 'messages_channel_sequence',
  columns: {#channelId, #serverSequence},
)
class Messages extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get serverId => text().nullable()();
  TextColumn get clientMessageId => text().nullable()();
  TextColumn get channelId => text()();
  TextColumn get senderId => text()();
  TextColumn get senderUsername => text()();
  TextColumn get content => text()();
  TextColumn get messageType => text()();
  TextColumn get metadataJson => text().map(const JsonMapConverter())();
  DateTimeColumn get clientCreatedAt => dateTime()();
  DateTimeColumn get serverCreatedAt => dateTime().nullable()();
  DateTimeColumn get serverUpdatedAt => dateTime().nullable()();
  IntColumn get serverSequence => integer().nullable()();
  IntColumn get version => integer().nullable()();
  BoolColumn get isEdited => boolean().withDefault(const Constant(false))();
  DateTimeColumn get editedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
  TextColumn get deliveryStatus =>
      text()
          .withDefault(const Constant('sending'))
          .map(const MessageDeliveryStatusConverter())();
  TextColumn get lastSyncError => text().nullable()();
  DateTimeColumn get lastSyncedAt => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
