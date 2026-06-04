import 'package:intl/intl.dart';
import '../models/message_model.dart';
import '../services/websocket_services.dart';

/// Extensions for User model
extension UserExtension on User {
  /// Check if this is a system user (special user for system messages)
  bool get isSystemUser => username.toLowerCase() == 'system';
}

/// Extensions for Message model
extension MessageExtension on Message {
  /// Format the timestamp to a readable time string
  String get formattedTime {
    final now = DateTime.now();
    final difference = now.difference(createdAt);

    if (difference.inSeconds < 60) {
      return 'just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays == 1) {
      return 'yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return DateFormat('MMM d, yyyy').format(createdAt);
    }
  }

  /// Format the creation time to a full datetime string
  String get formattedDateTime {
    return DateFormat('MMM d, yyyy - h:mm a').format(createdAt);
  }

  /// Format the creation time to time only
  String get formattedTimeOnly {
    return DateFormat('h:mm a').format(createdAt);
  }

  /// Get the priority from metadata if it's a reminder
  String get priority {
    if (messageType == MessageType.reminder) {
      return metadata['priority'] as String? ?? 'medium';
    }
    return '';
  }

  /// Get the due date from metadata if it's a reminder
  DateTime? get dueDate {
    if (messageType == MessageType.reminder) {
      final dueDateStr = metadata['due_date'] as String?;
      if (dueDateStr != null) {
        return DateTime.tryParse(dueDateStr);
      }
    }
    return null;
  }

  /// Check if a reminder is overdue
  bool get isOverdue {
    if (messageType == MessageType.reminder) {
      final due = dueDate;
      if (due != null) {
        return due.isBefore(DateTime.now());
      }
    }
    return false;
  }

  /// Get the alert level from metadata if it's an alert
  String get alertLevel {
    if (messageType == MessageType.alert) {
      return metadata['alert_level'] as String? ?? 'info';
    }
    return '';
  }

  /// Get color representation for message type
  String get messageTypeDisplay {
    switch (messageType) {
      case MessageType.text:
        return 'Message';
      case MessageType.reminder:
        return '⏰ Reminder';
      case MessageType.alert:
        return '⚠️ Alert';
      case MessageType.notification:
        return '🔔 Notification';
      case MessageType.file:
        return '📎 File';
      case MessageType.mention:
        return '@ Mention';
      case MessageType.reaction:
        return '😀 Reaction';
    }
  }

  /// Check if this is a system message
  bool get isSystemMessage => sender.isSystemUser;

  /// Get preview of message content (first 100 chars)
  String get preview {
    if (content.length <= 100) {
      return content;
    }
    return '${content.substring(0, 100)}...';
  }
}

/// Extensions for MessageType enum
extension MessageTypeExtension on MessageType {
  /// Convert enum to string value
  String get value {
    switch (this) {
      case MessageType.text:
        return 'text';
      case MessageType.reminder:
        return 'reminder';
      case MessageType.alert:
        return 'alert';
      case MessageType.notification:
        return 'notification';
      case MessageType.file:
        return 'file';
      case MessageType.mention:
        return 'mention';
      case MessageType.reaction:
        return 'reaction';
    }
  }

  /// Get display name
  String get displayName {
    switch (this) {
      case MessageType.text:
        return 'Message';
      case MessageType.reminder:
        return 'Reminder';
      case MessageType.alert:
        return 'Alert';
      case MessageType.notification:
        return 'Notification';
      case MessageType.file:
        return 'File';
      case MessageType.mention:
        return 'Mention';
      case MessageType.reaction:
        return 'Reaction';
    }
  }

  /// Get icon string for display
  String get icon {
    switch (this) {
      case MessageType.text:
        return '💬';
      case MessageType.reminder:
        return '⏰';
      case MessageType.alert:
        return '⚠️';
      case MessageType.notification:
        return '🔔';
      case MessageType.file:
        return '📎';
      case MessageType.mention:
        return '@';
      case MessageType.reaction:
        return '😀';
    }
  }
}

/// Extensions for WebSocketConnectionState enum
extension WebSocketConnectionStateExtension on WebSocketConnectionState {
  /// Get human-readable name
  String get displayName {
    switch (this) {
      case WebSocketConnectionState.disconnected:
        return 'Disconnected';
      case WebSocketConnectionState.connecting:
        return 'Connecting...';
      case WebSocketConnectionState.connected:
        return 'Connected';
      case WebSocketConnectionState.connectionFailed:
        return 'Connection failed';
      case WebSocketConnectionState.closed:
        return 'Closed';
    }
  }

  /// Check if in a loading state
  bool get isLoading => this == WebSocketConnectionState.connecting;

  /// Check if in an error state
  bool get isError =>
      this == WebSocketConnectionState.connectionFailed ||
      this == WebSocketConnectionState.closed;
}

/// Extensions for List<Message>
extension MessageListExtension on List<Message> {
  /// Group messages by date
  Map<DateTime, List<Message>> groupByDate() {
    final grouped = <DateTime, List<Message>>{};
    for (final message in this) {
      final dateKey = DateTime(
        message.createdAt.year,
        message.createdAt.month,
        message.createdAt.day,
      );
      grouped.putIfAbsent(dateKey, () => []);
      grouped[dateKey]!.add(message);
    }
    return grouped;
  }

  /// Get messages for a specific date
  List<Message> getMessagesForDate(DateTime date) {
    return where(
      (msg) =>
          msg.createdAt.year == date.year &&
          msg.createdAt.month == date.month &&
          msg.createdAt.day == date.day,
    ).toList();
  }

  /// Search messages by content
  List<Message> search(String query) {
    return where(
      (msg) => msg.content.toLowerCase().contains(query.toLowerCase()),
    ).toList();
  }

  /// Get only reminders
  List<Message> get reminders =>
      where((msg) => msg.messageType == MessageType.reminder).toList();

  /// Get only alerts
  List<Message> get alerts =>
      where((msg) => msg.messageType == MessageType.alert).toList();

  /// Get only regular messages
  List<Message> get regularMessages =>
      where((msg) => msg.messageType == MessageType.text).toList();

  /// Sort by most recent first
  List<Message> get sortedByNewest {
    final sorted = [...this];
    sorted.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return sorted;
  }

  /// Sort by oldest first
  List<Message> get sortedByOldest {
    final sorted = [...this];
    sorted.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    return sorted;
  }
}
