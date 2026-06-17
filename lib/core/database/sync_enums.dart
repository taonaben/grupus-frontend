enum SyncMutationStatus { pending, retrying, synced, failed, deadLettered }

enum SyncMutationOperation { create, update, delete }

enum MessageDeliveryStatus { sending, sent, failed }

enum AttachmentTransferStatus {
  localOnly,
  uploading,
  uploaded,
  downloaded,
  failed,
}
