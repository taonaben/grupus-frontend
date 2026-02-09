import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grupus/features/auth/services/auth_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _tryAutoLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Icon(
          Icons.calculate,
          size: 100,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  _tryAutoLogin() async {
    final authServices = AuthServices();

    try {
      bool isLoggedIn = await authServices.isLoggedIn();

      if (isLoggedIn) {
        context.go('/home');
      } else {
        context.go('/login');
      }
    } catch (e) {
      print("Error during auto-login: $e");
    }
  }
}
