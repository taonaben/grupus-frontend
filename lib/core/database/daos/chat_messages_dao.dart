part of '../app_database.dart';

@DriftAccessor(tables: [Messages])
class ChatMessagesDao extends DatabaseAccessor<AppDatabase>
    with _$ChatMessagesDaoMixin {
  ChatMessagesDao(super.db);

  Stream<List<Message>> watchByChannel(String channelId) {
    return (select(messages)..where((row) => row.channelId.equals(channelId)))
        .watch()
        .map(_sortForDisplay);
  }

  Future<void> insertLocalMessage(MessagesCompanion companion) async {
    await into(messages).insertOnConflictUpdate(companion);
  }

  Future<void> upsertServerMessage(MessagesCompanion companion) async {
    final clientMessageId =
        companion.clientMessageId.present ? companion.clientMessageId.value : null;
    if (clientMessageId != null && clientMessageId.isNotEmpty) {
      final pending = await _findByClientMessageId(clientMessageId);
      if (pending != null) {
        await (update(messages)..where((row) => row.id.equals(pending.id)))
            .write(_serverUpdateForExisting(companion));
        return;
      }
    }

    final serverId = companion.serverId.present ? companion.serverId.value : null;
    if (serverId != null && serverId.isNotEmpty) {
      final existing = await _findByServerId(serverId);
      if (existing != null) {
        await (update(messages)..where((row) => row.id.equals(existing.id)))
            .write(_serverUpdateForExisting(companion));
        return;
      }
    }

    await into(messages).insertOnConflictUpdate(companion);
  }

  Future<Message?> _findByClientMessageId(String clientMessageId) {
    return (select(messages)
          ..where((row) => row.clientMessageId.equals(clientMessageId))
          ..limit(1))
        .getSingleOrNull();
  }

  Future<Message?> _findByServerId(String serverId) {
    return (select(messages)
          ..where((row) => row.serverId.equals(serverId))
          ..limit(1))
        .getSingleOrNull();
  }

  MessagesCompanion _serverUpdateForExisting(MessagesCompanion source) {
    return MessagesCompanion(
      serverId: source.serverId,
      clientMessageId: source.clientMessageId,
      channelId: source.channelId,
      senderId: source.senderId,
      senderUsername: source.senderUsername,
      content: source.content,
      messageType: source.messageType,
      metadataJson: source.metadataJson,
      serverCreatedAt: source.serverCreatedAt,
      serverUpdatedAt: source.serverUpdatedAt,
      serverSequence: source.serverSequence,
      version: source.version,
      isEdited: source.isEdited,
      editedAt: source.editedAt,
      deletedAt: source.deletedAt,
      deliveryStatus: source.deliveryStatus,
      lastSyncError: const Value(null),
      lastSyncedAt: Value(DateTime.now()),
      updatedAt: Value(DateTime.now()),
    );
  }

  List<Message> _sortForDisplay(List<Message> rows) {
    final sorted = [...rows];
    sorted.sort((left, right) {
      final leftSequence = left.serverSequence;
      final rightSequence = right.serverSequence;
      if (leftSequence != null && rightSequence != null) {
        final sequenceCompare = leftSequence.compareTo(rightSequence);
        if (sequenceCompare != 0) {
          return sequenceCompare;
        }
      }

      final leftTime = left.serverCreatedAt ?? left.clientCreatedAt;
      final rightTime = right.serverCreatedAt ?? right.clientCreatedAt;
      final timeCompare = leftTime.compareTo(rightTime);
      if (timeCompare != 0) {
        return timeCompare;
      }

      return left.id.compareTo(right.id);
    });
    return sorted;
  }
}
