/// # Quick Start Example
///
/// This file shows how to integrate the WebSocket chat into your app.
/// Copy this code pattern into your own screen.

/*

// 1. Set up your main.dart with ProviderScope
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

// 2. Create a screen that uses the ChatScreen
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grupus/features/chat/views/chat_screen.dart';

class ChatPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get JWT token from your auth provider
    // final token = ref.read(authTokenProvider);
    
    const mockToken = 'your-jwt-token-here';
    const mockRoomId = '550e8400-e29b-41d4-a716-446655440000';
    
    return ChatScreen(
      config: ChatScreenConfig(
        roomId: mockRoomId,
        roomName: 'General Discussion',
        baseUrl: 'ws://localhost:8000', // Your WebSocket server
        token: mockToken,
      ),
    );
  }
}

// 3. Integrate into your app routing (example with GoRouter)
GoRoute(
  path: '/chat/:roomId',
  builder: (context, state) {
    final roomId = state.pathParameters['roomId']!;
    return ChatPage(
      roomId: roomId,
      roomName: state.extra as String? ?? 'Chat',
    );
  ),
),

// 4. OPTIONAL: Advanced state access if you need it directly
class AdvancedChatUsage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the entire chat state
    final chatState = ref.watch(chatStateProvider);
    
    // Or watch individual providers
    final messages = ref.watch(chatMessagesProvider);
    final connectionState = ref.watch(chatConnectionStateProvider);
    final typingUsers = ref.watch(chatTypingUsersProvider);
    final error = ref.watch(chatErrorProvider);
    
    return Column(
      children: [
        Text('Messages: ${messages.length}'),
        Text('Status: ${connectionState.displayName}'),
        Text('Typing: ${typingUsers.entries.where((e) => e.value).map((e) => e.key).join(", ")}'),
        if (error != null) Text('Error: $error'),
      ],
    );
  }
}

// 5. OPTIONAL: Send different types of messages programmatically
class ChatActions extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messagesNotifier = ref.read(chatMessagesProvider.notifier);
    
    return Column(
      children: [
        ElevatedButton(
          onPressed: () async {
            await messagesNotifier.sendMessage('Hello everyone!');
          },
          child: const Text('Send Message'),
        ),
        ElevatedButton(
          onPressed: () async {
            await messagesNotifier.sendReminder(
              'Review project proposal',
              dueDate: DateTime.now().add(Duration(days: 1)),
              priority: 'high',
            );
          },
          child: const Text('Send Reminder'),
        ),
        ElevatedButton(
          onPressed: () async {
            await messagesNotifier.sendAlert(
              'Server maintenance scheduled for tonight at 2 AM',
              alertLevel: 'warning',
            );
          },
          child: const Text('Send Alert'),
        ),
      ],
    );
  }
}

// 6. OPTIONAL: Custom state selector for efficiency
class OptimizedChatDisplay extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Only rebuild when messages change, not other state
    final messages = ref.watch(
      chatMessagesProvider.select((msgs) => msgs.length),
    );
    
    // Only rebuild when connection changes
    final isConnected = ref.watch(
      chatConnectionStateProvider.select(
        (state) => state == WebSocketConnectionState.connected,
      ),
    );
    
    return Column(
      children: [
        Text('$messages messages'),
        Text(isConnected ? 'Connected' : 'Disconnected'),
      ],
    );
  }
}

// 7. Authentication Integration Pattern
// If you're using a provider for authentication:

/*
// In your auth provider file:
final jwtTokenProvider = Provider<String>((ref) {
  // Get token from storage, auth service, etc.
  return 'your-jwt-token';
});

// In your chat screen:
final token = ref.read(jwtTokenProvider);
ChatScreen(
  config: ChatScreenConfig(
    roomId: roomId,
    roomName: roomName,
    baseUrl: 'ws://localhost:8000',
    token: token,
  ),
);
*/

*/

// This file is just documentation. The actual implementation is in:
// - lib/features/chat/views/chat_screen.dart
// - lib/features/chat/state/chat_provider.dart
// - lib/features/chat/services/websocket_services.dart
