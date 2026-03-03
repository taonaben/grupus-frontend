import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grupus/features/auth/services/auth_services.dart';
import 'package:grupus/shared/utils/logs.dart';

class Logout {
  Future<void> performLogout(BuildContext context) async {
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
  }
}
