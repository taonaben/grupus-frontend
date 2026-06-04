import 'package:flutter/material.dart';
import 'package:grupus/shared/components/chat/typing_indicator.dart';

class ChatTypingSection extends StatelessWidget {
  final List<String> typingUsers;

  const ChatTypingSection({super.key, required this.typingUsers});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${typingUsers.join(', ')} ${typingUsers.length == 1 ? 'is' : 'are'} typing...',
            style: Theme.of(
              context,
            ).textTheme.labelSmall?.copyWith(fontStyle: FontStyle.italic),
          ),
          const SizedBox(height: 4),
          const TypingIndicator(),
        ],
      ),
    );
  }
}
