import 'package:flutter/material.dart';
import 'package:grupus/shared/components/chat/chat_message_bubble.dart';
import 'package:intl/intl.dart';

import '../extensions/chat_extensions.dart';
import '../models/message_model.dart';
import 'chat_visuals.dart';

class ChatMessageItem extends StatelessWidget {
  final Message message;
  final bool isSentByMe;

  const ChatMessageItem({
    super.key,
    required this.message,
    required this.isSentByMe,
  });

  @override
  Widget build(BuildContext context) {
    if (message.messageType == MessageType.reminder) {
      return _ReminderMessageItem(message: message, isSentByMe: isSentByMe);
    }

    if (message.messageType == MessageType.alert) {
      return _AlertMessageItem(message: message);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ChatMessageBubble(
        message: message.content,
        isSentByMe: isSentByMe,
        delivered: message.id.isNotEmpty,
        seen: message.id.isNotEmpty && !isSentByMe,
        sent: message.id.isNotEmpty,
      ),
    );
  }
}

class _ReminderMessageItem extends StatelessWidget {
  final Message message;
  final bool isSentByMe;

  const _ReminderMessageItem({required this.message, required this.isSentByMe});

  @override
  Widget build(BuildContext context) {
    final priority = message.priority;
    final dueDate = message.dueDate;
    final dueText =
        dueDate != null
            ? DateFormat('MMM d, h:mm a').format(dueDate)
            : 'No due date';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: ChatVisuals.priorityColor(priority).withValues(alpha: 0.1),
          border: Border.all(
            color: ChatVisuals.priorityColor(priority),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment:
              isSentByMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment:
                    isSentByMe
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                children: [
                  Text(
                    '⏰ Reminder from ${message.sender.username}',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: ChatVisuals.priorityColor(priority),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    message.content,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Due: $dueText',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  Text(
                    'Priority: ${priority.toUpperCase()}',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: ChatVisuals.priorityColor(priority),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AlertMessageItem extends StatelessWidget {
  final Message message;

  const _AlertMessageItem({required this.message});

  @override
  Widget build(BuildContext context) {
    final alertLevel = message.alertLevel;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: ChatVisuals.alertColor(alertLevel).withValues(alpha: 0.1),
          border: Border(
            left: BorderSide(
              color: ChatVisuals.alertColor(alertLevel),
              width: 4,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '⚠️ Alert - ${alertLevel.toUpperCase()}',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: ChatVisuals.alertColor(alertLevel),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                message.content,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
