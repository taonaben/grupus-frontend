// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:grupus/main.dart';
import 'package:grupus/core/navigation/routes.dart' show createRouter;

void main() {
  testWidgets('Shows LoginPage when initial route is /login', (
    WidgetTester tester,
  ) async {
    final router = createRouter(initialLocation: '/login');

    await tester.pumpWidget(ProviderScope(child: MyApp(router: router)));
    await tester.pumpAndSettle();

    expect(find.text('Login Page'), findsOneWidget);
  });

  testWidgets('Shows Home when initial route is /home', (
    WidgetTester tester,
  ) async {
    final router = createRouter(initialLocation: '/home');

    await tester.pumpWidget(ProviderScope(child: MyApp(router: router)));
    await tester.pumpAndSettle();

    expect(find.text('Welcome to the Home Page!'), findsOneWidget);
  });
}
