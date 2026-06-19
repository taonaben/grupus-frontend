import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grupus/core/database/database_provider.dart';
import 'package:grupus/features/chat/data/chat_message_send_service.dart';
import 'package:grupus/features/chat/data/chat_messages_repository.dart';
import 'package:grupus/features/chat/data/chat_outbox_flusher.dart';
import 'package:grupus/features/chat/data/chat_socket_message_ingestion.dart';
import 'package:grupus/shared/utils/logs.dart';

import '../../models/message_model.dart';
import '../../services/websocket_services.dart';
import '../chat_state.dart';
import '../chat_types.dart';
import '../notifiers/chat_connection_state_notifier.dart';
import '../notifiers/chat_error_notifier.dart';
import '../notifiers/chat_room_users_notifier.dart';
import '../notifiers/chat_typing_notifier.dart';

class ChatRoomScope {
  final String roomId;
  final String baseUrl;
  final String token;

  const ChatRoomScope({
    required this.roomId,
    required this.baseUrl,
    required this.token,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ChatRoomScope &&
        other.roomId == roomId &&
        other.baseUrl == baseUrl &&
        other.token == token;
  }

  @override
  int get hashCode => Object.hash(roomId, baseUrl, token);
}

final chatWebSocketServiceProvider = Provider.autoDispose
    .family<ChatWebSocketService, ChatRoomScope>((ref, scope) {
      final service = ChatWebSocketService(
        baseUrl: scope.baseUrl,
        token: scope.token,
      );

      DevLogs.logInfo('[ChatProvider:${scope.roomId}] WebSocket service created');
      ref.onDispose(() {
        DevLogs.logInfo('[ChatProvider:${scope.roomId}] WebSocket provider dispose');
        service.dispose();
      });
      return service;
    });

final chatMessagesRepositoryProvider = Provider<ChatMessagesRepository>((ref) {
  final database = ref.watch(appDatabaseProvider);
  return ChatMessagesRepository(dao: database.chatMessagesDao);
});

final chatMessageSendServiceProvider = Provider<ChatMessageSendService>((ref) {
  final database = ref.watch(appDatabaseProvider);
  return ChatMessageSendService(database: database);
});

/// Manages the list of messages in the current chat
final chatMessagesProvider = StreamProvider.autoDispose
    .family<List<Message>, ChatRoomScope>((ref, scope) {
      final repository = ref.watch(chatMessagesRepositoryProvider);
      return repository.watchMessages(scope.roomId);
    });

final chatSocketMessageIngestionProvider = Provider.autoDispose
    .family<ChatSocketMessageIngestion, ChatRoomScope>((ref, scope) {
      final webSocket = ref.watch(chatWebSocketServiceProvider(scope));
      final repository = ref.watch(chatMessagesRepositoryProvider);
      final ingestion = ChatSocketMessageIngestion(
        webSocket: webSocket,
        repository: repository,
        roomId: scope.roomId,
      );
      ref.onDispose(ingestion.dispose);
      return ingestion;
    });

final chatOutboxFlusherProvider = Provider.autoDispose
    .family<ChatOutboxFlusher, ChatRoomScope>((ref, scope) {
      final database = ref.watch(appDatabaseProvider);
      final webSocket = ref.watch(chatWebSocketServiceProvider(scope));
      final flusher = ChatOutboxFlusher(
        outboxDao: database.syncOutboxDao,
        webSocket: webSocket,
        roomId: scope.roomId,
      );
      ref.onDispose(flusher.dispose);
      return flusher;
    });

/// Manages typing indicators for other users
final chatTypingUsersProvider = StateNotifierProvider.autoDispose
    .family<ChatTypingNotifier, TypingUsersState, ChatRoomScope>((ref, scope) {
      final webSocket = ref.watch(chatWebSocketServiceProvider(scope));
      return ChatTypingNotifier(webSocket);
    });

/// Manages user presence in the room
final chatRoomUsersProvider = StateNotifierProvider.autoDispose
    .family<ChatRoomUsersNotifier, RoomUsersState, ChatRoomScope>((ref, scope) {
      final webSocket = ref.watch(chatWebSocketServiceProvider(scope));
      return ChatRoomUsersNotifier(webSocket);
    });

/// Provides the connection state of the WebSocket
final chatConnectionStateProvider = StateNotifierProvider.autoDispose.family<
  ChatConnectionStateNotifier,
  WebSocketConnectionState,
  ChatRoomScope
>((ref, scope) {
  final webSocket = ref.watch(chatWebSocketServiceProvider(scope));
  return ChatConnectionStateNotifier(webSocket);
});

/// Provides the last error message, if any
final chatErrorProvider = StateNotifierProvider.autoDispose
    .family<ChatErrorNotifier, String?, ChatRoomScope>((ref, scope) {
      final webSocket = ref.watch(chatWebSocketServiceProvider(scope));
      return ChatErrorNotifier(webSocket);
    });

/// Composite provider for quick access to all chat state
final chatStateProvider = Provider.autoDispose.family<ChatState, ChatRoomScope>(
  (ref, scope) {
    ref.watch(chatSocketMessageIngestionProvider(scope));
    ref.watch(chatOutboxFlusherProvider(scope));
    final messages = ref.watch(chatMessagesProvider(scope)).valueOrNull ?? const <Message>[];
    final typingUsers = ref.watch(chatTypingUsersProvider(scope));
    final roomUsers = ref.watch(chatRoomUsersProvider(scope));
    final connectionState = ref.watch(chatConnectionStateProvider(scope));
    final error = ref.watch(chatErrorProvider(scope));

    return ChatState(
      messages: messages,
      typingUsers: typingUsers,
      roomUsers: roomUsers,
      connectionState: connectionState,
      error: error,
    );
  },
);
