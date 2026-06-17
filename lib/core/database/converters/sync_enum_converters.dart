import 'package:drift/drift.dart';

import '../sync_enums.dart';

class MessageDeliveryStatusConverter
    extends TypeConverter<MessageDeliveryStatus, String> {
  const MessageDeliveryStatusConverter();

  @override
  MessageDeliveryStatus fromSql(String fromDb) {
    return switch (fromDb) {
      'sending' => MessageDeliveryStatus.sending,
      'sent' => MessageDeliveryStatus.sent,
      'failed' => MessageDeliveryStatus.failed,
      _ => MessageDeliveryStatus.failed,
    };
  }

  @override
  String toSql(MessageDeliveryStatus value) => switch (value) {
    MessageDeliveryStatus.sending => 'sending',
    MessageDeliveryStatus.sent => 'sent',
    MessageDeliveryStatus.failed => 'failed',
  };
}

class MutationOperationConverter
    extends TypeConverter<SyncMutationOperation, String> {
  const MutationOperationConverter();

  @override
  SyncMutationOperation fromSql(String fromDb) {
    return switch (fromDb) {
      'create' => SyncMutationOperation.create,
      'update' => SyncMutationOperation.update,
      'delete' => SyncMutationOperation.delete,
      _ => SyncMutationOperation.update,
    };
  }

  @override
  String toSql(SyncMutationOperation value) => switch (value) {
    SyncMutationOperation.create => 'create',
    SyncMutationOperation.update => 'update',
    SyncMutationOperation.delete => 'delete',
  };
}

class MutationStatusConverter
    extends TypeConverter<SyncMutationStatus, String> {
  const MutationStatusConverter();

  @override
  SyncMutationStatus fromSql(String fromDb) {
    return switch (fromDb) {
      'pending' => SyncMutationStatus.pending,
      'retrying' => SyncMutationStatus.retrying,
      'synced' => SyncMutationStatus.synced,
      'failed' => SyncMutationStatus.failed,
      'dead_lettered' => SyncMutationStatus.deadLettered,
      _ => SyncMutationStatus.failed,
    };
  }

  @override
  String toSql(SyncMutationStatus value) => switch (value) {
    SyncMutationStatus.pending => 'pending',
    SyncMutationStatus.retrying => 'retrying',
    SyncMutationStatus.synced => 'synced',
    SyncMutationStatus.failed => 'failed',
    SyncMutationStatus.deadLettered => 'dead_lettered',
  };
}

class AttachmentTransferStatusConverter
    extends TypeConverter<AttachmentTransferStatus, String> {
  const AttachmentTransferStatusConverter();

  @override
  AttachmentTransferStatus fromSql(String fromDb) {
    return switch (fromDb) {
      'local_only' => AttachmentTransferStatus.localOnly,
      'uploading' => AttachmentTransferStatus.uploading,
      'uploaded' => AttachmentTransferStatus.uploaded,
      'downloaded' => AttachmentTransferStatus.downloaded,
      'failed' => AttachmentTransferStatus.failed,
      _ => AttachmentTransferStatus.failed,
    };
  }

  @override
  String toSql(AttachmentTransferStatus value) => switch (value) {
    AttachmentTransferStatus.localOnly => 'local_only',
    AttachmentTransferStatus.uploading => 'uploading',
    AttachmentTransferStatus.uploaded => 'uploaded',
    AttachmentTransferStatus.downloaded => 'downloaded',
    AttachmentTransferStatus.failed => 'failed',
  };
}
