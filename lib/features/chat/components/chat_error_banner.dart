import 'package:flutter/material.dart';

class ChatErrorBanner extends StatelessWidget {
  final String error;
  final VoidCallback onClose;

  const ChatErrorBanner({
    super.key,
    required this.error,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red.shade100,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        children: [
          const Icon(Icons.error_outline, color: Colors.red),
          const SizedBox(width: 12),
          Expanded(
            child: Text(error, style: const TextStyle(color: Colors.red)),
          ),
          IconButton(icon: const Icon(Icons.close), onPressed: onClose),
        ],
      ),
    );
  }
}
