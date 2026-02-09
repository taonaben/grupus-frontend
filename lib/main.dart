import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:grupus/core/navigation/routes.dart' show createRouter;
import 'package:grupus/features/auth/services/auth_services.dart';
import 'package:grupus/shared/theme/theme_provider.dart' show themeProvider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final authServices = AuthServices();
  final bool loggedIn = await authServices.isLoggedIn();

  final router = createRouter(
    initialLocation: loggedIn ? '/workspaces' : '/login',
  );

  runApp(ProviderScope(child: MyApp(router: router)));
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
