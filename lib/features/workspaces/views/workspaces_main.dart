import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:grupus/features/auth/services/auth_services.dart';
import 'package:grupus/features/workspaces/components/workspace_card.dart';
import 'package:grupus/features/workspaces/state/workspaces_provider.dart';
import 'package:grupus/shared/components/custom_filled_btn.dart';
import 'package:grupus/shared/components/custom_progress_indicator.dart';
import 'package:grupus/shared/constants/app_constants.dart';
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
      appBar: AppBar(
        title: const Text("Spaces"),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      floatingActionButton: IconButton(
        icon: const Icon(CupertinoIcons.add, size: 20),
        style: IconButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.borderRadiusLarge),
            // side: BorderSide(color: Theme.of(context).primaryColor),
          ),
        ),
        onPressed:
            () => showBottomSheet(
              context: context,
              builder: (context) {
                return Container(
                  padding: const EdgeInsets.all(AppConstants.paddingLarge),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            child: const Text("Create Workspace"),
                            onTap: () {
                              context.pop();
                              context.pushNamed('create-workspace');
                            },
                          ),
                          const Gap(AppConstants.gapLarge),
                          GestureDetector(
                            child: const Text("Join Workspace"),
                            onTap: () {
                              context.pop();
                              // context.pushNamed('join-workspace');
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
      ),
      body: allWorkspacesAsyncValue.when(
        data: (workspaces) {
          if (workspaces.isEmpty) {
            return const Center(child: Text("No workspaces found"));
          }
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.paddingLarge,
            ),
            child: ListView.builder(
              itemCount: workspaces.length,
              itemBuilder: (context, index) {
                final workspace = workspaces[index];
                return WorkspaceCard(workspace: workspace);
              },
            ),
          );
        },
        loading: () => const Center(child: CustomProgressIndicator()),
        error: (error, stack) {
          DevLogs.logError('Error loading workspaces: $error');
          return const Center(child: Text("Failed to load workspaces"));
        },
      ),
    );
  }
}
