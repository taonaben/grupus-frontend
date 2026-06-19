import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grupus/features/users/state/user_provider.dart';
import 'package:intl/intl.dart';
import '../models/message_model.dart';
import '../state/chat_provider.dart';
import '../extensions/chat_extensions.dart';

/// Utility class for common chat operations
class ChatUtils {
  /// Export current messages as a string (for sharing/debugging)
  static String exportMessages(List<Message> messages) {
    final buffer = StringBuffer();
    final dateFormat = DateFormat('h:mm a');
    for (final msg in messages) {
      buffer.writeln(
        '${msg.sender.username} (${dateFormat.format(msg.createdAt)}):',
      );
      buffer.writeln(msg.content);
      buffer.writeln('---');
    }
    return buffer.toString();
  }

  /// Get messages statistics
  static ChatStatistics getStatistics(List<Message> messages) {
    return ChatStatistics(
      totalMessages: messages.length,
      totalReminders: messages.reminders.length,
      totalAlerts: messages.alerts.length,
      totalTextMessages: messages.regularMessages.length,
      uniqueSenders: messages.map((m) => m.sender.id).toSet().length,
    );
  }

  /// Filter messages by date range
  static List<Message> filterByDateRange(
    List<Message> messages,
    DateTime startDate,
    DateTime endDate,
  ) {
    return messages
        .where(
          (msg) =>
              msg.createdAt.isAfter(startDate) &&
              msg.createdAt.isBefore(endDate),
        )
        .toList();
  }

  /// Get messages from a specific user
  static List<Message> getMessagesFromUser(
    List<Message> messages,
    String userId,
  ) {
    return messages.where((msg) => msg.sender.id == userId).toList();
  }

  /// Get overdue reminders
  static List<Message> getOverdueReminders(List<Message> messages) {
    return messages.reminders.where((msg) => msg.isOverdue).toList();
  }

  /// Get upcoming reminders (within next N days)
  static List<Message> getUpcomingReminders(
    List<Message> messages, {
    int daysAhead = 7,
  }) {
    final now = DateTime.now();
    final future = now.add(Duration(days: daysAhead));

    return messages.reminders.where((msg) {
      final due = msg.dueDate;
      if (due == null) return false;
      return due.isAfter(now) && due.isBefore(future);
    }).toList();
  }

  /// Calculate conversation metrics
  static ConversationMetrics getConversationMetrics(List<Message> messages) {
    if (messages.isEmpty) {
      return ConversationMetrics(
        averageMessagesPerDay: 0,
        mostActiveUser: 'N/A',
        messageFrequency: {},
      );
    }

    final userMessageCounts = <String, int>{};
    for (final msg in messages) {
      userMessageCounts[msg.sender.username] =
          (userMessageCounts[msg.sender.username] ?? 0) + 1;
    }

    final mostActiveUser =
        userMessageCounts.entries
            .reduce((a, b) => a.value > b.value ? a : b)
            .key;

    final dayRange =
        messages.last.createdAt.difference(messages.first.createdAt).inDays;
    final avgPerDay = messages.length / (dayRange + 1);

    return ConversationMetrics(
      averageMessagesPerDay: avgPerDay,
      mostActiveUser: mostActiveUser,
      messageFrequency: userMessageCounts,
    );
  }
}

/// Statistics about messages
class ChatStatistics {
  final int totalMessages;
  final int totalReminders;
  final int totalAlerts;
  final int totalTextMessages;
  final int uniqueSenders;

  ChatStatistics({
    required this.totalMessages,
    required this.totalReminders,
    required this.totalAlerts,
    required this.totalTextMessages,
    required this.uniqueSenders,
  });

  @override
  String toString() {
    return '''
ChatStatistics:
  Total Messages: $totalMessages
  Text Messages: $totalTextMessages
  Reminders: $totalReminders
  Alerts: $totalAlerts
  Unique Senders: $uniqueSenders
''';
  }
}

/// Conversation metrics
class ConversationMetrics {
  final double averageMessagesPerDay;
  final String mostActiveUser;
  final Map<String, int> messageFrequency;

  ConversationMetrics({
    required this.averageMessagesPerDay,
    required this.mostActiveUser,
    required this.messageFrequency,
  });

  @override
  String toString() {
    return '''
ConversationMetrics:
  Average Messages/Day: ${averageMessagesPerDay.toStringAsFixed(2)}
  Most Active User: $mostActiveUser
  Message Frequency: $messageFrequency
''';
  }
}

/// Extension on WidgetRef for easier chat access
extension ChatUtilsRef on WidgetRef {
  /// Get current chat statistics
  ChatStatistics getChatStats(ChatRoomScope scope) {
    final messages = watch(chatMessagesProvider(scope)).valueOrNull ?? const <Message>[];
    return ChatUtils.getStatistics(messages);
  }

  /// Send a text message easily
  Future<void> sendChatMessage(ChatRoomScope scope, String content) async {
    final currentUser = read(currentUserProvider).valueOrNull;
    if (currentUser == null) {
      throw StateError('User not authenticated');
    }

    await read(chatMessageSendServiceProvider).sendTextMessage(
      content: content,
      channelId: scope.roomId,
      senderId: currentUser.id ?? '',
      senderUsername: currentUser.username,
    );
    await read(chatOutboxFlusherProvider(scope)).flushPendingIfConnected();
  }

  /// Send a reminder easily
  Future<void> sendChatReminder(
    ChatRoomScope scope,
    String content, {
    required DateTime dueDate,
    String priority = 'medium',
  }) {
    return read(chatWebSocketServiceProvider(scope)).sendReminder(
      content,
      dueDate: dueDate,
      priority: priority,
    );
  }

  /// Get all overdue reminders
  List<Message> getOverdueReminders(ChatRoomScope scope) {
    final messages = watch(chatMessagesProvider(scope)).valueOrNull ?? const <Message>[];
    return ChatUtils.getOverdueReminders(messages);
  }

  /// Get upcoming reminders
  List<Message> getUpcomingReminders(ChatRoomScope scope, {int daysAhead = 7}) {
    final messages = watch(chatMessagesProvider(scope)).valueOrNull ?? const <Message>[];
    return ChatUtils.getUpcomingReminders(messages, daysAhead: daysAhead);
  }

  /// Get conversation metrics
  ConversationMetrics getMetrics(ChatRoomScope scope) {
    final messages = watch(chatMessagesProvider(scope)).valueOrNull ?? const <Message>[];
    return ChatUtils.getConversationMetrics(messages);
  }
}
