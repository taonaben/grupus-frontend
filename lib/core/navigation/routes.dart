import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grupus/features/auth/views/login_page.dart';
import 'package:grupus/core/navigation/home.dart';
import 'package:grupus/features/auth/views/registration/profile_create_screen.dart';
import 'package:grupus/features/auth/views/registration/username_screen.dart';
import 'package:grupus/features/auth/views/registration/registration_page.dart';
import 'package:grupus/features/auth/views/registration/verify_email_screen.dart';
import 'package:grupus/features/groups/views/groups_page.dart';
import 'package:grupus/features/resources/views/resources_page.dart';
import 'package:grupus/features/workspaces/workspaces.dart';
import 'package:grupus/features/profile/profile_tab.dart';
import 'nav_bar_model.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

/// Define all your nav items here for easy management
final List<NavBarItem> navBarItems = [
  NavBarItem(
    label: 'Spaces',
    route: '/workspaces',
    outlineIcon: FluentIcons.building_24_regular,
    filledIcon: FluentIcons.building_24_filled,
  ),
  NavBarItem(
    label: 'Groups',
    route: '/groups',
    outlineIcon: FluentIcons.people_24_regular,
    filledIcon: FluentIcons.people_24_filled,
  ),
  NavBarItem(
    label: 'Files',
    route: '/resources',
    outlineIcon: FluentIcons.book_open_24_regular,
    filledIcon: FluentIcons.book_open_24_filled,
  ),

  NavBarItem(
    label: 'You',
    route: '/profile',
    outlineIcon: FluentIcons.person_24_regular,
    filledIcon: FluentIcons.person_24_filled,
  ),
];

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
        path: '/register',
        name: "register",
        builder: (context, state) => const RegistrationPage(),
      ),
      GoRoute(
        path: "/verify-email",
        name: "verify-email",
        builder: (context, state) {
          final String email = state.extra as String? ?? '';
          return VerifyEmailScreen(email: email);
        },
      ),
      GoRoute(
        path: '/register/username',
        name: "create-username",
        builder: (context, state) => const UsernameScreen(),
      ),
      GoRoute(
        path: '/register/create-profile',
        name: "create-profile",
        builder: (context, state) => const ProfileCreateScreen(),
      ),

      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return Home(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/workspaces',
                name: 'workspaces',
                builder: (context, state) => const Workspaces(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/groups',
                name: 'groups',
                builder: (context, state) => const GroupsPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/resources',
                name: 'resources',
                builder: (context, state) => const ResourcesPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                name: 'profile',
                builder: (context, state) => const ProfileTab(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
