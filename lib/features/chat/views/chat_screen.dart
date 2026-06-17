import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grupus/features/users/state/user_provider.dart';
import 'package:grupus/shared/components/chat/message_bar.dart';
import 'package:grupus/shared/components/custom_snackbar.dart';
import 'package:grupus/shared/utils/logs.dart';
import 'package:logger/logger.dart';
import 'package:uuid/uuid.dart';

import '../components/chat_disconnected_input_bar.dart';
import '../components/chat_error_banner.dart';
import '../components/chat_header.dart';
import '../components/chat_messages_list.dart';
import '../models/message_metadata_keys.dart';
import '../models/message_model.dart';
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
  static const Duration _typingTimeout = Duration(seconds: 2);

  late final ScrollController _scrollController;
  late final ChatRoomScope _roomScope;
  Timer? _scrollTimer;
  Timer? _typingTimer;
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    DevLogs.logInfo(
      '[ChatScreen:${widget.config.roomId}] initState roomName=${widget.config.roomName}',
    );
    _scrollController = ScrollController();
    _roomScope = ChatRoomScope(
      roomId: widget.config.roomId,
      baseUrl: widget.config.baseUrl,
      token: widget.config.token,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      DevLogs.logInfo(
        '[ChatScreen:${widget.config.roomId}] postFrame connect callback mounted=$mounted',
      );
      if (!mounted) {
        return;
      }
      ref
          .read(chatConnectionStateProvider(_roomScope).notifier)
          .connectToRoom(widget.config.roomId);
    });
  }

  @override
  void dispose() {
    DevLogs.logInfo('[ChatScreen:${widget.config.roomId}] dispose start');
    _scrollTimer?.cancel();
    DevLogs.logInfo('[ChatScreen:${widget.config.roomId}] scroll timer cancelled');
    _typingTimer?.cancel();
    _setTyping(false);
    _scrollController.dispose();
    DevLogs.logInfo('[ChatScreen:${widget.config.roomId}] scroll controller disposed');
    super.dispose();
    DevLogs.logInfo('[ChatScreen:${widget.config.roomId}] dispose complete');
  }

  /// Handle message sending
  void _handleSendMessage(String message) {
    if (message.trim().isEmpty) return;

    try {
      DevLogs.logInfo(
        '[ChatScreen:${widget.config.roomId}] send message requested length=${message.trim().length}',
      );
      final userFromProvider = ref.read(currentUserProvider).valueOrNull;
      if (userFromProvider == null) {
        CustomSnackbar(
          message: "User not authenticated",
          color: Theme.of(context).colorScheme.error,
        ).showSnackBar(context);
        return;
      }

      final clientMessageId = Uuid().v4();
      final metadata = <String, dynamic>{
        MessageMetadataKeys.clientMessageId: clientMessageId,
      };

      final localMessage = Message(
        id: clientMessageId,
        content: message.trim(),
        messageType: MessageType.text,
        sender: User(
          id: userFromProvider.id ?? '',
          username: userFromProvider.username,
        ),
        channelId: widget.config.roomId,
        createdAt: DateTime.now(),
        metadata: metadata,
      );

      // Add to local state immediately for better UX
      ref
          .read(chatMessagesProvider(_roomScope).notifier)
          .addLocalMessage(localMessage);

      // Send actual message
      ref
          .read(chatMessagesProvider(_roomScope).notifier)
          .sendMessage(message.trim(), metadata: metadata);
      _typingTimer?.cancel();
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
      ref
          .read(chatTypingUsersProvider(_roomScope).notifier)
          .setTyping(isTyping);
    } catch (e) {
      logger.e('Error setting typing: $e');
    }
  }

  void _handleMessageTextChanged(String text) {
    _typingTimer?.cancel();

    if (text.trim().isEmpty) {
      _setTyping(false);
      return;
    }

    _setTyping(true);
    _typingTimer = Timer(_typingTimeout, () {
      _setTyping(false);
    });
  }

  /// Scroll to bottom of message list
  void _scrollToBottom() {
    _scrollTimer?.cancel();
    DevLogs.logInfo('[ChatScreen:${widget.config.roomId}] schedule scroll to bottom');
    _scrollTimer = Timer(const Duration(milliseconds: 100), () {
      DevLogs.logInfo(
        '[ChatScreen:${widget.config.roomId}] scroll timer fired mounted=$mounted hasClients=${_scrollController.hasClients}',
      );
      if (mounted && _scrollController.hasClients) {
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
    final chatState = ref.watch(chatStateProvider(_roomScope));
    final isConnected = chatState.isConnected;
    final connectionState = chatState.connectionState;
    final error = chatState.error;

    return Scaffold(
      appBar: AppBar(
        title: ChatHeader(
          roomName: widget.config.roomName,
          connectionState: connectionState,
        ),
        elevation: 1,
      ),
      body: Column(
        children: [
          if (error != null)
            ChatErrorBanner(
              error: error,
              onClose:
                  () =>
                      ref
                          .read(chatErrorProvider(_roomScope).notifier)
                          .clearError(),
            ),
          Expanded(
            child: ChatMessagesList(
              messages: chatState.messages,
              typingUsers: chatState.typingUsersList,
              isConnected: isConnected,
              scrollController: _scrollController,
            ),
          ),
          if (isConnected)
            _buildMessageInputBar()
          else
            const ChatDisconnectedInputBar(),
        ],
      ),
    );
  }

  /// Build message input bar
  Widget _buildMessageInputBar() {
    return ChatMessageBar(
      onSend: _handleSendMessage,
      onTextChanged: _handleMessageTextChanged,
    );
  }
}
