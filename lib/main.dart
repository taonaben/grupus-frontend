import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:grupus/core/navigation/routes.dart' show createRouter;
import 'package:grupus/features/auth/services/auth_services.dart';
import 'package:grupus/features/users/state/user_provider.dart';
import 'package:grupus/shared/theme/theme_provider.dart' show themeProvider;
import 'package:grupus/shared/utils/logs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await dotenv.load(fileName: '.env');
  } catch (e) {
    DevLogs.logWarning('Could not load .env file: $e');
  }

  final authServices = AuthServices();
  final bool loggedIn = await authServices.isLoggedIn();

  final router = createRouter(
    initialLocation: loggedIn ? '/workspaces' : '/login',
  );

  // Create a ProviderContainer to pre-fetch and cache user data
  final container = ProviderContainer();

  // Pre-fetch user data if logged in (caches it for later use)
  if (loggedIn) {
    try {
      await container.read(currentUserProvider.future);
    } catch (e) {
      print('Error pre-fetching user data: $e');
    }
  }

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: MyApp(router: router),
    ),
  );
}

class MyApp extends ConsumerWidget {
  final GoRouter router;

  const MyApp({super.key, required this.router});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeNotifier = ref.watch(themeProvider);

    return MaterialApp.router(
      title: 'Grupus',
      theme: themeNotifier.lightTheme,
      darkTheme: themeNotifier.darkTheme,
      themeMode: themeNotifier.themeMode,
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
