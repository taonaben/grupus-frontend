import 'package:flutter/material.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:grupus/shared/constants/app_constants.dart';

class ChatMessageBar extends StatelessWidget {
  final Function(String) onSend;
  const ChatMessageBar({super.key, required this.onSend});

  @override
  Widget build(BuildContext context) {
    return MessageBar(
      onSend: onSend,
      actions: [
        IconButton(
          icon: const Icon(Icons.attach_file),
          onPressed: () {
            // Handle attach file action
          },
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppConstants.paddingSmall),
          child: InkWell(
            child: Icon(
              Icons.camera_alt,
              color: Theme.of(context).colorScheme.primary,
              // size: 24,
            ),
            onTap: () {},
          ),
        ),
      ],
    );
  }
}
