import 'package:flutter/material.dart';

import '../models/message_model.dart';
import 'chat_empty_state.dart';
import 'chat_message_item.dart';
import 'chat_typing_section.dart';

class ChatMessagesList extends StatelessWidget {
  final List<Message> messages;
  final List<String> typingUsers;
  final bool isConnected;
  final ScrollController scrollController;

  const ChatMessagesList({
    super.key,
    required this.messages,
    required this.typingUsers,
    required this.isConnected,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    if (messages.isEmpty) {
      return ChatEmptyState(isConnected: isConnected);
    }

    return ListView.builder(
      controller: scrollController,
      itemCount: messages.length + (typingUsers.isNotEmpty ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == messages.length) {
          return ChatTypingSection(typingUsers: typingUsers);
        }

        final message = messages[index];
        final isSentByMe = message.sender.username == 'Me';

        return ChatMessageItem(message: message, isSentByMe: isSentByMe);
      },
    );
  }
}
