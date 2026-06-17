import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grupus/features/users/state/user_provider.dart';

import '../models/message_model.dart';
import 'chat_empty_state.dart';
import 'chat_message_item.dart';
import 'chat_typing_section.dart';

class ChatMessagesList extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    if (messages.isEmpty) {
      return ChatEmptyState(isConnected: isConnected);
    }

    final currentUserId = ref.watch(currentUserProvider).valueOrNull?.id;

    return ListView.builder(
      controller: scrollController,
      itemCount: messages.length + (typingUsers.isNotEmpty ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == messages.length) {
          return ChatTypingSection(typingUsers: typingUsers);
        }

        final message = messages[index];
        final isSentByMe =
            currentUserId != null &&
            currentUserId.isNotEmpty &&
            message.sender.id == currentUserId;

        return ChatMessageItem(message: message, isSentByMe: isSentByMe);
      },
    );
  }
}
