import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grupus/features/auth/api/auth_api.dart';
import 'package:grupus/features/auth/services/auth_services.dart';
import 'package:grupus/shared/components/custom_filled_btn.dart';
import 'package:grupus/shared/utils/logs.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomFilledButton(
              btnLabel: "logout",
              onTap: () {
                var authServices = AuthServices();
                authServices
                    .logout()
                    .then((success) {
                      if (success) {
                        DevLogs.logSuccess("Logout successful");
                        context.go("/login");
                      } else {
                        DevLogs.logError("Logout failed");
                      }
                    })
                    .catchError((error) {
                      DevLogs.logError("Logout error: $error");
                    });
              },
            ),
          ],
        ),
      ),
    );
  }
}
