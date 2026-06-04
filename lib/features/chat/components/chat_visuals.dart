import 'package:flutter/material.dart';

import '../services/websocket_services.dart';

class ChatVisuals {
  static Color connectionStatusColor(WebSocketConnectionState state) {
    switch (state) {
      case WebSocketConnectionState.connected:
        return Colors.green;
      case WebSocketConnectionState.connecting:
        return Colors.orange;
      case WebSocketConnectionState.disconnected:
      case WebSocketConnectionState.closed:
      case WebSocketConnectionState.connectionFailed:
        return Colors.red;
    }
  }

  static Color priorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'high':
        return Colors.red;
      case 'medium':
        return Colors.orange;
      case 'low':
        return Colors.green;
      default:
        return Colors.blue;
    }
  }

  static Color alertColor(String alertLevel) {
    switch (alertLevel.toLowerCase()) {
      case 'critical':
      case 'error':
        return Colors.red;
      case 'warning':
        return Colors.orange;
      case 'info':
        return Colors.blue;
      case 'success':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
