# WebSocket Chat Implementation Guide

## Overview

This is a complete, production-ready WebSocket chat implementation for Flutter using your backend's Django Channels API. The implementation is **modular, robust, and efficient**.

## Architecture

```
┌─────────────────────────────────────────────┐
│         Chat Screen (UI Layer)              │
├─────────────────────────────────────────────┤
│      Riverpod Providers (State Layer)       │
│  - chatMessagesProvider                     │
│  - chatTypingUsersProvider                  │
│  - chatConnectionStateProvider              │
│  - chatErrorProvider                        │
├─────────────────────────────────────────────┤
│   ChatWebSocketService (Service Layer)      │
│  - Connection Management                    │
│  - Automatic Reconnection                   │
│  - Event Broadcasting                       │
├─────────────────────────────────────────────┤
│    Message Models & Extensions              │
│  - Message, User, WebSocketEvent            │
│  - Helper extensions for formatting         │
└─────────────────────────────────────────────┘
```

## Components

### 1. **Message Models** (`message_model.dart`)

Defines all data structures:

- `Message` - Chat message with type-specific metadata
- `User` - Sender/receiver information
- `WebSocketEvent` - Server events
- `TypingEvent` - Typing indicator
- `UserPresence` - User join/leave events
- `MessageType` enum - text, reminder, alert, notification

### 2. **WebSocket Service** (`websocket_services.dart`)

Core service managing WebSocket connections:

**Key Features:**
- ✅ JWT token authentication
- ✅ Automatic reconnection with exponential backoff
- ✅ Event broadcasting pattern (callbacks)
- ✅ Type-safe message handling
- ✅ Proper resource cleanup
- ✅ Comprehensive logging

**Methods:**
```dart
// Connection
await service.connect(roomId)
service.disconnect()

// Sending messages
await service.sendMessage(content)
await service.sendReminder(content, dueDate, priority)
await service.sendAlert(content, alertLevel)
await service.broadcastTyping(isTyping)

// Listening for events
service.onMessage((message) { })
service.onTyping((userId, isTyping) { })
service.onPresence((presence) { })
service.onError((error) { })
service.onConnectionStateChanged((state) { })
```

### 3. **Chat Provider** (`chat_provider.dart`)

Riverpod state management:

**State Notifiers:**
- `chatMessagesProvider` - List of messages
- `chatTypingUsersProvider` - Typing indicators
- `chatRoomUsersProvider` - Users in the room
- `chatConnectionStateProvider` - Connection status
- `chatErrorProvider` - Error messages

**Composite Provider:**
- `chatStateProvider` - Access all state at once

### 4. **Chat Extensions** (`chat_extensions.dart`)

Helpful utilities:

- **Message Extensions**: Format timestamps, get priority/alert level, check if overdue
- **MessageType Extensions**: Get display names, icons
- **MessageList Extensions**: Group by date, filter, search
- **ConnectionState Extensions**: Display names, status checks

### 5. **Chat Screen** (`chat_screen.dart`)

Complete UI implementation:

**Features:**
- Real-time message display
- Type-specific message rendering (text, reminder, alert)
- Typing indicators with animation
- User presence notifications
- Connection status display
- Error handling & recovery
- Auto-scrolling to latest message
- Empty state handling

**Configuration:**
```dart
final config = ChatScreenConfig(
  roomId: 'uuid-of-room',
  roomName: 'Room Name',
  baseUrl: 'ws://localhost:8000',
  token: 'jwt_token_here',
);

ChatScreen(config: config)
```

## Setup Steps

### Step 1: Setup JSON Serialization

Run this command in your project root:

```bash
dart run build_runner build --delete-conflicting-outputs
```

This generates the `.g.dart` files needed for JSON serialization.

### Step 2: Initialize Riverpod in main.dart

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}
```

### Step 3: Configure WebSocket Service

Edit `lib/features/chat/config/chat_config.dart`:

```dart
const String WEBSOCKET_BASE_URL = 'ws://your-server:8000';
const String JWT_TOKEN = 'your_jwt_token'; // Get from auth provider
```

### Step 4: Use ChatScreen

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grupus/features/chat/views/chat_screen.dart';

class ChatPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ChatScreen(
      config: ChatScreenConfig(
        roomId: 'the-room-uuid',
        roomName: 'General Chat',
        baseUrl: 'ws://localhost:8000',
        token: ref.read(authTokenProvider), // from your auth
      ),
    );
  }
}
```

## Advanced Usage

### Sending Different Message Types

```dart
final messagesNotifier = ref.read(chatMessagesProvider.notifier);

// Text message
await messagesNotifier.sendMessage('Hello!');

// Reminder
await messagesNotifier.sendReminder(
  'Complete the project',
  dueDate: DateTime.now().add(Duration(days: 1)),
  priority: 'high',
);

// Alert
await messagesNotifier.sendAlert(
  'System maintenance in 30 minutes',
  alertLevel: 'warning',
);
```

### Handling Connection State

```dart
final connectionState = ref.watch(chatConnectionStateProvider);

if (connectionState == WebSocketConnectionState.connected) {
  print('Connected!');
} else if (connectionState == WebSocketConnectionState.connecting) {
  print('Connecting...');
}
```

### Accessing Chat State

```dart
final chatState = ref.watch(chatStateProvider);

// All state in one place
print('Messages: ${chatState.messages.length}');
print('Typing users: ${chatState.typingUsersList}');
print('Is connected: ${chatState.isConnected}');
print('Has error: ${chatState.hasError}');
```

### Custom Message Filtering

```dart
final messages = ref.watch(chatMessagesProvider);

// Using extensions
final reminders = messages.reminders;
final alerts = messages.alerts;
final searchResults = messages.search('keyword');
```

## Code Quality & Robustness

### Error Handling
✅ Try-catch blocks throughout  
✅ User-friendly error messages  
✅ Automatic error clearing after 5 seconds  
✅ Error banner in UI  

### Performance
✅ Efficient list updates with `.copyWith()`  
✅ No unnecessary rebuilds (using Riverpod selectors)  
✅ Proper resource cleanup in `dispose()`  
✅ Optimized JSON serialization  

### Reliability
✅ Automatic reconnection with exponential backoff  
✅ JWT token validation  
✅ Connection state tracking  
✅ Message persistence (via backend)  
✅ Graceful degradation when disconnected  

### Code Organization
✅ Separation of concerns (service, state, UI)  
✅ Clear naming and documentation  
✅ Reusable, composable providers  
✅ Type-safe throughout  
✅ Extension methods for cleanliness  

## Testing

You can test the chat by:

1. Starting your Django backend with Daphne
2. Creating a test JWT token
3. Getting a room UUID from your backend
4. Loading the ChatScreen with the correct config

Example test configuration:

```dart
ChatScreen(
  config: ChatScreenConfig(
    roomId: '550e8400-e29b-41d4-a716-446655440000',
    roomName: 'Test Room',
    baseUrl: 'ws://localhost:8000',
    token: 'eyJ0eXAiOiJKV1QiLCJhbGc...', // Valid JWT token
  ),
)
```

## Logging

The implementation uses the `logger` package. To see detailed logs, check the console when running:

```bash
flutter run
```

## Known Limitations & Notes

1. **Current User ID**: The chat screen currently uses a hardcoded `'current_user_id'` and `'Me'` for the current user. Replace these with actual values from your auth provider.

2. **Message History**: Currently shows only messages received after connection. To load history, you would need to:
   - Fetch messages from your REST API before opening the chat
   - Or extend the backend to send history on connect

3. **Typing Timeout**: Typing indicators don't auto-clear. The backend should handle timeout logic or you can add a local timeout in `ChatTypingNotifier`.

4. **Read Receipts**: The UI shows delivery/seen indicators but doesn't track them. Add this feature via the WebSocket API if needed.

## Troubleshooting

### "Not connected to chat"
- Check WebSocket URL is correct
- Verify JWT token is valid
- Ensure backend is running with Daphne
- Check browser console for errors (if in web)

### Messages not arriving
- Verify room UUID is correct
- Check backend logs for consumer errors
- Ensure user has access to the room

### Typing indicators not working
- This is a broadcast-only feature (no persistence)
- Normal operation is expected

### Build errors after changes
- Run: `dart run build_runner build --delete-conflicting-outputs`
- Delete `.dart_tool` folder and run `flutter pub get`

## Next Steps

1. Integrate with your authentication system
2. Add message file uploads
3. Implement message editing/deletion
4. Add message reactions (emoji)
5. Add read receipts
6. Implement message search
7. Add pinned messages support

Enjoy your robust, modular WebSocket chat! 🚀
