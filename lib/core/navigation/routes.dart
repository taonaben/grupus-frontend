import 'package:go_router/go_router.dart';
import 'package:grupus/features/home/home.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',

  routes: [
    GoRoute(path: '/', name: "home", builder: (context, state) => const Home()),
  ],
);
