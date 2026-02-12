import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grupus/features/auth/services/auth_services.dart';
import 'package:grupus/shared/components/custom_filled_btn.dart';
import 'package:grupus/shared/utils/logs.dart';
import 'package:grupus/shared/utils/shared_prefs.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(radius: 50, child: Icon(Icons.person, size: 50)),
            const SizedBox(height: 20),
            const Text(
              'User Profile',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Profile tab content goes here',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[600]),
              ),
            ),
            CustomFilledButton(
              btnLabel: "Logout",
              onTap: () async {
                var authServices = AuthServices();
                await authServices
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
