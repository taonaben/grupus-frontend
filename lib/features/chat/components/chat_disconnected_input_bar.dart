import 'package:flutter/material.dart';

class ChatDisconnectedInputBar extends StatelessWidget {
  const ChatDisconnectedInputBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade200,
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          const Expanded(
            child: TextField(
              enabled: false,
              decoration: InputDecoration(
                hintText: 'Reconnecting...',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(icon: const Icon(Icons.send), onPressed: null),
        ],
      ),
    );
  }
}
