// **IMPORTANT**: Before running the app, generate JSON serialization code by running:
// ```
// dart run build_runner build --delete-conflicting-outputs
// ```

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grupus/features/chat/services/websocket_services.dart';
import 'package:grupus/shared/constants/app_constants.dart';

// Uses .env / --dart-define / fallback from AppConstants
final String WEBSOCKET_BASE_URL = AppConstants.wsBaseUrl;
const String JWT_TOKEN =
    'your_jwt_token_here'; // Replace with actual token from your auth provider

/// Initialize the ChatWebSocketService with your configuration
final chatWebSocketProvider = Provider<ChatWebSocketService>((ref) {
  return ChatWebSocketService(baseUrl: WEBSOCKET_BASE_URL, token: JWT_TOKEN);
});

/// Usage Example in your main.dart or wherever you initialize Riverpod:
/// ```dart
/// void main() {
///   runApp(
///     const ProviderScope(
///       child: MyApp(),
///     ),
///   );
/// }
/// ```
///
/// Then in your screen:
/// ```dart
/// final Screen extends ConsumerWidget {
///   @override
///   Widget build(BuildContext context, WidgetRef ref) {
///     return ChatScreen(
///       config: ChatScreenConfig(
///         roomId: 'your-room-uuid-here',
///         roomName: 'Room Name',
///         baseUrl: WEBSOCKET_BASE_URL,
///         token: JWT_TOKEN,
///       ),
///     );
///   }
/// }
/// ```
