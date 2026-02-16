import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:grupus/features/auth/services/auth_services.dart';
import 'package:grupus/features/workspaces/state/workspaces.dart';
import 'package:grupus/shared/components/custom_filled_btn.dart';
import 'package:grupus/shared/utils/logs.dart';

class Workspaces extends ConsumerStatefulWidget {
  const Workspaces({super.key});

  @override
  ConsumerState<Workspaces> createState() => _WorkspacesState();
}

class _WorkspacesState extends ConsumerState<Workspaces> {
  @override
  Widget build(BuildContext context) {
    final allWorkspacesAsyncValue = ref.watch(allWorkspacesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Workspaces")),
      body: allWorkspacesAsyncValue.when(
        data: (workspaces) {
          if (workspaces.isEmpty) {
            return const Center(child: Text("No workspaces found"));
          }
          return ListView.builder(
            itemCount: workspaces.length,
            itemBuilder: (context, index) {
              final workspace = workspaces[index];
              return ListTile(
                title: Text(workspace.name),
                subtitle: Text(workspace.description ?? 'No description'),
                onTap: () {
                  // Navigate to workspace details
                  // context.push('/workspace/${workspace.id}');
                },
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) {
          DevLogs.logError('Error loading workspaces: $error');
          return const Center(child: Text("Failed to load workspaces"));
        },
      ),
    );
  }
}
