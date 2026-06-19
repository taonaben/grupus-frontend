import 'package:grupus/core/database/app_database.dart';

import '../models/message_model.dart' as chat;
import 'chat_message_mapper.dart';

class ChatMessagesRepository {
  ChatMessagesRepository({
    required ChatMessagesDao dao,
    ChatMessageMapper mapper = const ChatMessageMapper(),
  }) : _dao = dao,
       _mapper = mapper;

  final ChatMessagesDao _dao;
  final ChatMessageMapper _mapper;

  Stream<List<chat.Message>> watchMessages(String channelId) {
    return _dao.watchByChannel(channelId).map(
      (rows) => rows.map(_mapper.rowToMessage).toList(growable: false),
    );
  }

  Future<void> insertLocalMessage(chat.Message message) {
    return _dao.insertLocalMessage(_mapper.localMessageToCompanion(message));
  }

  Future<void> upsertServerMessage(chat.Message message) {
    return _dao.upsertServerMessage(_mapper.serverMessageToCompanion(message));
  }
}
