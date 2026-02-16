import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grupus/features/auth/services/auth_services.dart';
import 'package:grupus/shared/components/custom_filled_btn.dart';
import 'package:grupus/shared/utils/logs.dart';

class Workspaces extends StatelessWidget {
  const Workspaces({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Workspaces")),
      body: Center(child: Text("Workspaces")),
    );
  }
}
