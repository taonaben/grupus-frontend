import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grupus/features/users/state/user_provider.dart';
import 'package:grupus/shared/components/chat/chat_message_bubble.dart';
import 'package:grupus/shared/components/chat/message_bar.dart';
import 'package:grupus/shared/components/chat/typing_indicator.dart';
import 'package:grupus/shared/components/custom_snackbar.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import '../extensions/chat_extensions.dart';
import '../models/message_model.dart';
import '../services/websocket_services.dart';
import '../state/chat_provider.dart';

final logger = Logger();

/// Configuration for ChatScreen
class ChatScreenConfig {
  final String roomId;
  final String roomName;
  final String baseUrl; // e.g., 'ws://localhost:8000'
  final String token; // JWT token for authentication

  ChatScreenConfig({
    required this.roomId,
    required this.roomName,
    required this.baseUrl,
    required this.token,
  });
}

/// Main chat screen widget
class ChatScreen extends ConsumerStatefulWidget {
  final ChatScreenConfig config;

  const ChatScreen({super.key, required this.config});

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  late final ScrollController _scrollController;
  late final TextEditingController _messageController;
  late final ChatWebSocketService _webSocketService;
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _messageController = TextEditingController();

    // Initialize WebSocket service
    _webSocketService = ChatWebSocketService(
      baseUrl: widget.config.baseUrl,
      token: widget.config.token,
    );

    // Register the service with the chat provider system
    initializeChatWebSocket(_webSocketService);

    // Connect to room
    _webSocketService.connect(widget.config.roomId);
  }

  @override
  void dispose() {
    // Clear the service reference from the provider system
    disposeChatWebSocket();

    _webSocketService.dispose();
    _scrollController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  /// Handle message sending
  void _handleSendMessage(String message) {
    if (message.trim().isEmpty) return;

    try {
      final userFromProvider = ref.read(currentUserProvider).valueOrNull;
      if (userFromProvider == null) {
        CustomSnackbar(
          message: "User not authenticated",
          color: Theme.of(context).colorScheme.error,
        ).showSnackBar(context);
        return;
      }

      final localMessage = Message(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        content: message.trim(),
        messageType: MessageType.text,
        sender: User(
          id: userFromProvider.id ?? '',
          username: userFromProvider.username,
        ),
        channelId: widget.config.roomId,
        createdAt: DateTime.now(),
      );

      // Add to local state immediately for better UX
      ref.read(chatMessagesProvider.notifier).addLocalMessage(localMessage);

      // Send actual message
      _webSocketService.sendMessage(message.trim());
      _messageController.clear();
      _setTyping(false);

      // Scroll to latest message
      _scrollToBottom();
    } catch (e) {
      logger.e('Error sending message: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to send message: $e')));
    }
  }

  /// Handle typing indicator
  void _setTyping(bool isTyping) {
    if (_isTyping == isTyping) return;
    _isTyping = isTyping;

    try {
      _webSocketService.broadcastTyping(isTyping);
    } catch (e) {
      logger.e('Error setting typing: $e');
    }
  }

  /// Scroll to bottom of message list
  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final chatState = ref.watch(chatStateProvider);
    final messages = chatState.messages;
    final isConnected = chatState.isConnected;
    final connectionState = chatState.connectionState;
    final error = chatState.error;
    final typingUsers = chatState.typingUsersList;

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.config.roomName),
            Text(
              _buildConnectionStatusText(connectionState),
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: _getConnectionStatusColor(connectionState),
              ),
            ),
          ],
        ),
        elevation: 1,
      ),
      body: Column(
        children: [
          // Error Banner
          if (error != null)
            Container(
              color: Colors.red.shade100,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Row(
                children: [
                  const Icon(Icons.error_outline, color: Colors.red),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      error,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed:
                        () => ref.read(chatErrorProvider.notifier).clearError(),
                  ),
                ],
              ),
            ),

          // Messages List
          Expanded(
            child:
                messages.isEmpty
                    ? _buildEmptyState(isConnected)
                    : ListView.builder(
                      controller: _scrollController,
                      itemCount:
                          messages.length + (typingUsers.isNotEmpty ? 1 : 0),
                      itemBuilder: (context, index) {
                        // Show typing indicator at the end if someone is typing
                        if (index == messages.length) {
                          return _buildTypingIndicator(typingUsers);
                        }

                        final message = messages[index];
                        return _buildMessageWidget(message);
                      },
                    ),
          ),

          // Date chip between message groups
          // (This could be enhanced to show date separators)

          // Message Input Bar
          if (isConnected)
            _buildMessageInputBar()
          else
            _buildDisconnectedInputBar(),
        ],
      ),
    );
  }

  /// Build message widget with type-specific rendering
  Widget _buildMessageWidget(Message message) {
    final isSentByMe =
        message.sender.username == 'Me'; // Adjust based on actual user

    return Column(
      children: [
        if (message.messageType == MessageType.reminder)
          _buildReminderMessage(message, isSentByMe)
        else if (message.messageType == MessageType.alert)
          _buildAlertMessage(message, isSentByMe)
        else
          _buildRegularMessage(message, isSentByMe),
      ],
    );
  }

  /// Build regular text message
  Widget _buildRegularMessage(Message message, bool isSentByMe) {
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

  /// Build reminder message with special styling
  Widget _buildReminderMessage(Message message, bool isSentByMe) {
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
          color: _getPriorityColor(priority).withOpacity(0.1),
          border: Border.all(color: _getPriorityColor(priority), width: 2),
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
                      color: _getPriorityColor(priority),
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
                      color: _getPriorityColor(priority),
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

  /// Build alert message with special styling
  Widget _buildAlertMessage(Message message, bool isSentByMe) {
    final alertLevel = message.alertLevel;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: _getAlertColor(alertLevel).withOpacity(0.1),
          border: Border(
            left: BorderSide(color: _getAlertColor(alertLevel), width: 4),
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
                  color: _getAlertColor(alertLevel),
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

  /// Build typing indicator widget
  Widget _buildTypingIndicator(List<String> typingUsers) {
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

  /// Build message input bar
  Widget _buildMessageInputBar() {
    return ChatMessageBar(onSend: _handleSendMessage);
  }

  /// Build disabled input bar when disconnected
  Widget _buildDisconnectedInputBar() {
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

  /// Build empty state
  Widget _buildEmptyState(bool isConnected) {
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

  /// Build connection status text
  String _buildConnectionStatusText(WebSocketConnectionState state) {
    return state.displayName;
  }

  /// Get color for connection status
  Color _getConnectionStatusColor(WebSocketConnectionState state) {
    switch (state) {
      case WebSocketConnectionState.connected:
        return Colors.green;
      case WebSocketConnectionState.connecting:
        return Colors.orange;
      case WebSocketConnectionState.disconnected:
      case WebSocketConnectionState.closed:
        return Colors.red;
      case WebSocketConnectionState.connectionFailed:
        return Colors.red;
    }
  }

  /// Get color for priority level
  Color _getPriorityColor(String priority) {
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

  /// Get color for alert level
  Color _getAlertColor(String alertLevel) {
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
