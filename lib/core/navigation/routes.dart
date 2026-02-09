import 'package:go_router/go_router.dart';
import 'package:grupus/features/auth/views/login_page.dart';
import 'package:grupus/features/home/home.dart';
import 'package:grupus/shared/components/theme_example_screen.dart';

GoRouter createRouter({required String initialLocation}) {
  return GoRouter(
    initialLocation: initialLocation,
    routes: [
      GoRoute(
        path: '/login',
        name: "login",
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/home',
        name: "home",
        builder: (context, state) => const Home(),
      ),
    ],
  );
}
