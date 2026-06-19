import 'package:grupus/shared/utils/logs.dart';

import '../models/message_model.dart';
import '../services/websocket_services.dart';
import 'chat_messages_repository.dart';

class ChatSocketMessageIngestion {
  ChatSocketMessageIngestion({
    required ChatWebSocketService webSocket,
    required ChatMessagesRepository repository,
    required String roomId,
  }) : _webSocket = webSocket,
       _repository = repository,
       _roomId = roomId {
    _webSocket.onMessage(_handleMessage);
    DevLogs.logInfo('[ChatIngest:$_roomId] WebSocket message ingestion attached');
  }

  final ChatWebSocketService _webSocket;
  final ChatMessagesRepository _repository;
  final String _roomId;

  Future<void> _handleMessage(Message message) async {
    try {
      await _repository.upsertServerMessage(message);
      DevLogs.logInfo('[ChatIngest:$_roomId] message upserted id=${message.id}');
    } catch (error) {
      DevLogs.logError('[ChatIngest:$_roomId] message upsert failed: $error');
    }
  }

  void dispose() {
    _webSocket.offMessage(_handleMessage);
    DevLogs.logInfo('[ChatIngest:$_roomId] WebSocket message ingestion detached');
  }
}
