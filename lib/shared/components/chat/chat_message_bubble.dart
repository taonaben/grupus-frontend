import 'package:flutter/material.dart';
import 'package:chat_bubbles/chat_bubbles.dart';

class ChatMessageBubble extends StatelessWidget {
  final String message;
  final bool isSentByMe;
  final bool delivered;
  final bool seen;
  final bool sent;
  const ChatMessageBubble({
    super.key,
    required this.message,
    required this.isSentByMe,
    required this.delivered,
    required this.seen,
    required this.sent,
  });

  @override
  Widget build(BuildContext context) {
    return BubbleSpecialOne(
      text: message,
      color:
          isSentByMe
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.secondary,
      delivered: delivered,
      seen: seen,
      sent: sent,
      textStyle: TextStyle(
        color:
            isSentByMe
                ? Theme.of(context).colorScheme.onPrimary
                : Theme.of(context).colorScheme.onSecondary,
      ),
      isSender: isSentByMe,
    );
  }
}
