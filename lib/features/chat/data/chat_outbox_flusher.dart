import 'dart:async';

import 'package:grupus/core/database/app_database.dart';
import 'package:grupus/shared/utils/logs.dart';

import '../services/websocket_services.dart';

class ChatOutboxFlusher {
  ChatOutboxFlusher({
    required SyncOutboxDao outboxDao,
    required ChatWebSocketService webSocket,
    required String roomId,
  }) : _outboxDao = outboxDao,
       _webSocket = webSocket,
       _roomId = roomId {
    _webSocket.onConnectionStateChanged(_handleConnectionStateChanged);
    _webSocket.onError(_handleSocketError);
    unawaited(flushPendingIfConnected());
  }

  final SyncOutboxDao _outboxDao;
  final ChatWebSocketService _webSocket;
  final String _roomId;
  bool _isFlushing = false;
  String? _lastFlushedMutationId;

  Future<void> flushPendingIfConnected() async {
    if (!_webSocket.isConnected || _isFlushing) {
      return;
    }

    _isFlushing = true;
    try {
      await _outboxDao.resetRetryingToPending(scopeId: _roomId);
      final pending = await _outboxDao.getPendingMessageCreates(
        scopeId: _roomId,
      );
      for (final mutation in pending) {
        if (!_webSocket.isConnected) {
          return;
        }

        try {
          final content = mutation.payloadJson['content'];
          final metadata = mutation.payloadJson['metadata'];
          if (content is! String || content.trim().isEmpty) {
            await _outboxDao.markRetrying(
              clientMutationId: mutation.clientMutationId,
              error: 'Outbox message payload is missing content',
            );
            continue;
          }

          final messageMetadata =
              metadata is Map<String, dynamic>
                  ? Map<String, dynamic>.from(metadata)
                  : <String, dynamic>{};

          _lastFlushedMutationId = mutation.clientMutationId;
          await _webSocket.sendMessage(content, metadata: messageMetadata);
          await _outboxDao.markSynced(mutation.clientMutationId);
          Timer(const Duration(seconds: 5), () {
            if (_lastFlushedMutationId == mutation.clientMutationId) {
              _lastFlushedMutationId = null;
            }
          });
          DevLogs.logInfo(
            '[ChatOutbox:$_roomId] flushed mutation=${mutation.clientMutationId}',
          );
        } catch (error) {
          await _outboxDao.markRetrying(
            clientMutationId: mutation.clientMutationId,
            error: error.toString(),
          );
          DevLogs.logWarning(
            '[ChatOutbox:$_roomId] flush failed mutation=${mutation.clientMutationId}: $error',
          );
          return;
        }
      }
    } finally {
      _isFlushing = false;
    }
  }

  void dispose() {
    _webSocket.offError(_handleSocketError);
    _webSocket.offConnectionStateChanged(_handleConnectionStateChanged);
  }

  void _handleConnectionStateChanged(WebSocketConnectionState state) {
    if (state == WebSocketConnectionState.connected) {
      flushPendingIfConnected();
    }
  }

  void _handleSocketError(String error) {
    final mutationId = _lastFlushedMutationId;
    if (mutationId == null) {
      return;
    }

    unawaited(
      _outboxDao.markRetrying(clientMutationId: mutationId, error: error),
    );
    DevLogs.logWarning(
      '[ChatOutbox:$_roomId] server rejected mutation=$mutationId: $error',
    );
    _lastFlushedMutationId = null;
  }
}
