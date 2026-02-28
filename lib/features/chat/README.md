# 💬 Grupus WebSocket Chat System

A complete, production-ready real-time chat implementation for Flutter using WebSocket connections with your Django Channels backend.

## 🎯 Features

### Messaging
- ✅ Real-time text messages
- ✅ Reminder messages with due dates and priorities
- ✅ Alert/notification messages with severity levels
- ✅ Message metadata support for extensibility

### Real-Time Interactions
- ✅ Typing indicators
- ✅ User presence notifications (join/leave)
- ✅ Connection state tracking
- ✅ Automatic reconnection with exponential backoff

### UI/UX
- ✅ Beautiful message bubbles with delivery status
- ✅ Type-specific message rendering
- ✅ Smooth animations
- ✅ Connection status indicator
- ✅ Error handling with user-friendly messages
- ✅ Auto-scroll to latest message
- ✅ Empty state handling

### Code Quality
- ✅ Modular architecture
- ✅ Riverpod state management
- ✅ Type-safe throughout
- ✅ Comprehensive error handling
- ✅ Well-documented and extensible
- ✅ Production-ready code

## 📁 Project Structure

```
lib/features/chat/
├── api/                          # REST API utilities (placeholder)
├── components/                   # Reusable chat components
├── config/                       # Configuration setup
├── documentation/                # Backend documentation
├── extensions/                   # Helper extensions
├── models/                       # Data models & serialization
├── services/                     # WebSocket service
├── state/                        # State management (Riverpod)
├── utils/                        # Utility functions
├── views/                        # Chat UI screens
├── IMPLEMENTATION_GUIDE.md       # Detailed technical documentation
├── QUICK_START.dart              # Code examples
├── SETUP_SUMMARY.md              # Setup instructions
└── README.md                     # This file
```

## 🚀 Quick Start

### 1. Setup JSON Serialization

```bash
cd your-project-root
dart run build_runner build --delete-conflicting-outputs
```

### 2. Initialize Riverpod

In your `main.dart`:

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

### 3. Use ChatScreen

```dart
import 'package:grupus/features/chat/views/chat_screen.dart';

ChatScreen(
  config: ChatScreenConfig(
    roomId: 'your-room-uuid',
    roomName: 'General Chat',
    baseUrl: 'ws://your-server:8000',
    token: 'your-jwt-token',
  ),
)
```

## 📖 Documentation

- **[SETUP_SUMMARY.md](SETUP_SUMMARY.md)** - Start here! Step-by-step setup guide
- **[IMPLEMENTATION_GUIDE.md](IMPLEMENTATION_GUIDE.md)** - Detailed technical documentation
- **[QUICK_START.dart](QUICK_START.dart)** - Code examples and patterns

## 🏗️ Architecture

### Layered Design

```
┌─────────────────────────────────────────┐
│      UI Layer (ChatScreen)              │
│   - Message display                     │
│   - User input                          │
│   - Connection status                   │
└──────────────────┬──────────────────────┘
                   │
┌──────────────────▼──────────────────────┐
│   State Layer (Riverpod Providers)      │
│   - chatMessagesProvider                │
│   - chatTypingUsersProvider             │
│   - chatConnectionStateProvider         │
│   - chatErrorProvider                   │
└──────────────────┬──────────────────────┘
                   │
┌──────────────────▼──────────────────────┐
│  Service Layer (WebSocketService)       │
│   - Connection management               │
│   - Auto-reconnection                   │
│   - Event broadcasting                  │
└──────────────────┬──────────────────────┘
                   │
┌──────────────────▼──────────────────────┐
│    Models & Extensions                  │
│   - Message, User, Events               │
│   - Helper utilities                    │
└─────────────────────────────────────────┘
```

### Data Flow

```
Frontend                          Backend
  │
  ├─ User sends message ────────────────┐
  │                                     │
  ├─ Optimistic update (local)          │ Save to DB
  │                                     │
  ├─ Send via WebSocket ───────────────┤
  │                                     │
  ├─ Broadcast to room ◄───────────────┤
  │                                     │
  └─ Receive & update UI               │
```

## 🎮 Usage Examples

### Sending Messages

```dart
final notifier = ref.read(chatMessagesProvider.notifier);

// Text message
await notifier.sendMessage('Hello!');

// Reminder with due date
await notifier.sendReminder(
  'Review proposal',
  dueDate: DateTime.now().add(Duration(days: 1)),
  priority: 'high',
);

// Alert
await notifier.sendAlert(
  'System maintenance notice',
  alertLevel: 'warning',
);
```

### Watching State

```dart
// Full chat state
final chatState = ref.watch(chatStateProvider);

// Individual states
final messages = ref.watch(chatMessagesProvider);
final connectionState = ref.watch(chatConnectionStateProvider);
final typingUsers = ref.watch(chatTypingUsersProvider);
final error = ref.watch(chatErrorProvider);

// With selectors (more efficient)
final messageCount = ref.watch(
  chatMessagesProvider.select((msgs) => msgs.length),
);
```

### Message Utilities

```dart
final messages = ref.watch(chatMessagesProvider);

// Filter by type
final reminders = messages.reminders;
final alerts = messages.alerts;
final textMessages = messages.regularMessages;

// Group by date
final byDate = messages.groupByDate();

// Search
final results = messages.search('keyword');

// Sort
final newest = messages.sortedByNewest;
final oldest = messages.sortedByOldest;

// Get overdue reminders
final overdue = ChatUtils.getOverdueReminders(messages);

// Get upcoming reminders (next 7 days)
final upcoming = ChatUtils.getUpcomingReminders(messages);

// Statistics
final stats = ChatUtils.getStatistics(messages);
```

### Chat Utils (Advanced)

```dart
// Using extension on WidgetRef
class MyScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stats = ref.getChatStats();
    final overdue = ref.getOverdueReminders();
    final metrics = ref.getMetrics();
    
    return Column(
      children: [
        Text('Messages: ${stats.totalMessages}'),
        Text('Reminders: ${stats.totalReminders}'),
        Text('Overdue: ${overdue.length}'),
        Text('Avg/day: ${metrics.averageMessagesPerDay.toStringAsFixed(1)}'),
      ],
    );
  }
}
```

## 🔐 Authentication

The chat system uses JWT tokens for authentication. Update your configuration in [config/chat_config.dart](config/chat_config.dart):

```dart
const String WEBSOCKET_BASE_URL = 'ws://your-server:8000';
const String JWT_TOKEN = 'your-jwt-token';
```

Or integrate with your auth provider:

```dart
ChatScreen(
  config: ChatScreenConfig(
    roomId: roomId,
    roomName: roomName,
    baseUrl: 'ws://your-server:8000',
    token: ref.read(jwtTokenProvider), // From your auth
  ),
)
```

## ⚠️ Important: Current User Setup

Replace the hardcoded user in `views/chat_screen.dart` (line ~70):

```dart
// ❌ Remove this
sender: User(
  id: 'current_user_id',
  username: 'Me',
),

// ✅ Replace with your auth
sender: User(
  id: ref.read(currentUserProvider).id,
  username: ref.read(currentUserProvider).name,
),
```

## 🧪 Testing

### Local Setup

1. Start your Django backend:
   ```bash
   daphne -b 0.0.0.0 -p 8000 main.asgi:application
   ```

2. Create a test JWT token

3. Create/get a room UUID

4. Run Flutter app with ChatScreen:
   ```dart
   ChatScreen(
     config: ChatScreenConfig(
       roomId: '550e8400-e29b-41d4-a716-446655440000',
       roomName: 'Test Room',
       baseUrl: 'ws://localhost:8000',
       token: 'eyJ0eXAiOiJKV1QiLCJhbGc...',
     ),
   )
   ```

### Multi-Device Testing

Open the app on two devices/emulators to test real-time messaging and presence notifications.

## 🔄 Connection States

```
disconnected ──→ connecting ──→ connected
                      ↓
                connection_failed ──→ reconnecting ──→ connected
                                           ↑
                                           (exponential backoff)
                      
                      closed ──→ reconnecting
```

## 📊 Message Types

### Text Message
```json
{
  "type": "message",
  "message_type": "text",
  "content": "Hello everyone!",
  "metadata": {}
}
```

### Reminder Message
```json
{
  "type": "message",
  "message_type": "reminder",
  "content": "Review proposal",
  "metadata": {
    "due_date": "2026-03-01T10:00:00Z",
    "priority": "high",
    "tags": ["important"]
  }
}
```

### Alert Message
```json
{
  "type": "message",
  "message_type": "alert",
  "content": "System maintenance",
  "metadata": {
    "alert_level": "warning"
  }
}
```

## 🛠️ Troubleshooting

### Build Issues
```bash
# Clean and rebuild
flutter clean
rm -rf .dart_tool/
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```

### Connection Issues
- ✅ Verify WebSocket URL format (ws:// not http://)
- ✅ Check JWT token is valid
- ✅ Ensure backend is running
- ✅ Check firewall/network settings
- ✅ View logs: `flutter logs`

### Messages Not Appearing
- ✅ Check room UUID is correct
- ✅ Verify user has access to room
- ✅ Check backend logs for errors
- ✅ Ensure serialization was generated

### App Crashes
- ✅ Run `flutter pub get`
- ✅ Restart app (don't hot reload)
- ✅ Check console for errors

## 📚 Additional Resources

- Backend docs: [documentation/CHAT_SYSTEM_OVERVIEW.md](documentation/CHAT_SYSTEM_OVERVIEW.md)
- WebSocket API spec: [documentation/asyncapi.yaml](documentation/asyncapi.yaml)
- Django Channels: https://channels.readthedocs.io/
- Flutter Riverpod: https://riverpod.dev/
- JSON Serialization: https://pub.dev/packages/json_serializable

## 🚀 Next Steps

1. **Test locally** - Follow the testing guide
2. **Integrate auth** - Connect to your auth system
3. **Deploy** - Push to staging/production
4. **Enhance** - Add features like:
   - Message history loading
   - File uploads
   - Message reactions
   - Read receipts
   - Message search
   - Pinned messages

## 📄 License

This implementation is part of the Grupus project.

## 🤝 Support

For issues or questions:
1. Check [IMPLEMENTATION_GUIDE.md](IMPLEMENTATION_GUIDE.md)
2. Review the backend docs in [documentation/](documentation/)
3. Check the troubleshooting section above
4. Review logs in Flutter console

---

**Happy chatting!** 🎉
