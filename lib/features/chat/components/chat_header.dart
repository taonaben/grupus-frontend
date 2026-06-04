import 'package:flutter/material.dart';

import '../extensions/chat_extensions.dart';
import '../services/websocket_services.dart';
import 'chat_visuals.dart';

class ChatHeader extends StatelessWidget {
  final String roomName;
  final WebSocketConnectionState connectionState;

  const ChatHeader({
    super.key,
    required this.roomName,
    required this.connectionState,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(roomName),
        Text(
          connectionState.displayName,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: ChatVisuals.connectionStatusColor(connectionState),
          ),
        ),
      ],
    );
  }
}
