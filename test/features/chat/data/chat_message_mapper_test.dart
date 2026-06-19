import 'package:flutter_test/flutter_test.dart';
import 'package:grupus/core/database/app_database.dart' as db;
import 'package:grupus/core/database/sync_enums.dart';
import 'package:grupus/features/chat/data/chat_message_mapper.dart';
import 'package:grupus/features/chat/models/message_metadata_keys.dart';
import 'package:grupus/features/chat/models/message_model.dart';

void main() {
  const mapper = ChatMessageMapper();

  test('server Message maps to Drift companion with sync metadata', () {
    final message = Message(
      id: 'server-1',
      content: 'Hello',
      messageType: MessageType.text,
      sender: User(id: 'user-1', username: 'taona'),
      channelId: 'channel-1',
      createdAt: DateTime.utc(2026, 6, 17, 10),
      metadata: const {MessageMetadataKeys.clientMessageId: 'client-1'},
    );

    final companion = mapper.serverMessageToCompanion(message);

    expect(companion.serverId.value, 'server-1');
    expect(companion.clientMessageId.value, 'client-1');
    expect(companion.channelId.value, 'channel-1');
    expect(companion.deliveryStatus.value, MessageDeliveryStatus.sent);
  });

  test('local Message maps to pending Drift companion', () {
    final message = Message(
      id: 'client-1',
      content: 'Pending',
      messageType: MessageType.text,
      sender: User(id: 'user-1', username: 'taona'),
      channelId: 'channel-1',
      createdAt: DateTime.utc(2026, 6, 17, 10),
      metadata: const {MessageMetadataKeys.clientMessageId: 'client-1'},
    );

    final companion = mapper.localMessageToCompanion(message);

    expect(companion.clientMessageId.value, 'client-1');
    expect(companion.content.value, 'Pending');
    expect(companion.deliveryStatus.value, MessageDeliveryStatus.sending);
  });

  test('Drift row maps back to existing chat Message model', () {
    final row = db.Message(
      id: 1,
      serverId: 'server-1',
      clientMessageId: 'client-1',
      channelId: 'channel-1',
      senderId: 'user-1',
      senderUsername: 'taona',
      content: 'Hello',
      messageType: 'reminder',
      metadataJson: const {
        MessageMetadataKeys.clientMessageId: 'client-1',
        'priority': 'high',
      },
      clientCreatedAt: DateTime.utc(2026, 6, 17, 9, 59),
      serverCreatedAt: DateTime.utc(2026, 6, 17, 10),
      serverUpdatedAt: DateTime.utc(2026, 6, 17, 10),
      serverSequence: 1,
      version: 1,
      isEdited: false,
      editedAt: null,
      deletedAt: null,
      deliveryStatus: MessageDeliveryStatus.sent,
      lastSyncError: null,
      lastSyncedAt: DateTime.utc(2026, 6, 17, 10),
      createdAt: DateTime.utc(2026, 6, 17, 9, 59),
      updatedAt: DateTime.utc(2026, 6, 17, 10),
    );

    final message = mapper.rowToMessage(row);

    expect(message.id, 'server-1');
    expect(message.content, 'Hello');
    expect(message.messageType, MessageType.reminder);
    expect(message.sender.id, 'user-1');
    expect(message.sender.username, 'taona');
    expect(message.channelId, 'channel-1');
    expect(message.createdAt, DateTime.utc(2026, 6, 17, 10));
    expect(message.metadata[MessageMetadataKeys.clientMessageId], 'client-1');
  });
}
