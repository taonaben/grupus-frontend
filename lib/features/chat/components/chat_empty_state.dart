import 'package:flutter/material.dart';

class ChatEmptyState extends StatelessWidget {
  final bool isConnected;

  const ChatEmptyState({super.key, required this.isConnected});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.message, size: 64, color: Colors.grey.shade300),
          const SizedBox(height: 16),
          Text(
            isConnected
                ? 'No messages yet. Start the conversation!'
                : 'Not connected to chat',
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }
}
