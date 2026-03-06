import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:grupus/features/auth/services/auth_services.dart';
import 'package:grupus/features/profile/utils/logout.dart';
import 'package:grupus/features/users/state/user_provider.dart';
import 'package:grupus/shared/components/custom_filled_btn.dart';
import 'package:grupus/shared/components/custom_progress_indicator.dart';
import 'package:grupus/shared/constants/app_constants.dart';
import 'package:grupus/shared/utils/logs.dart';
import 'package:grupus/shared/utils/shared_prefs.dart';

class ProfileTab extends ConsumerStatefulWidget {
  const ProfileTab({super.key});

  @override
  ConsumerState<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends ConsumerState<ProfileTab> {
  bool isLoading = false;

  // var userAsyncValue = currentUserProvider;

  @override
  Widget build(BuildContext context) {
    return ref
        .watch(currentUserProvider)
        .when(
          data:
              (user) => Scaffold(
                appBar: AppBar(title: const Text("Profile")),
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        radius: 50,
                        child: Icon(Icons.person, size: 50),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        user?.email ?? 'No email',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 32),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'Hello, ${user?.username ?? 'Guest'}!',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ),
                      isLoading
                          ? const CustomProgressIndicator()
                          : CustomFilledButton(
                            btnLabel: "Logout",
                            onTap: handleLogout,
                          ),
                    ],
                  ),
                ),
              ),
          loading: () => const Center(child: CustomProgressIndicator()),
          error: (error, stack) {
            DevLogs.logError("Error loading user data: $error");
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    CupertinoIcons.exclamationmark_triangle,
                    size: 50,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  const Gap(AppConstants.gapLarge),
                  Text(
                    "Failed to load user data.",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            );
          },
        );
  }

  Future<void> handleLogout() async {
    setState(() => isLoading = true);

    try {
      await Logout().performLogout(context);
    } catch (e) {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }
}
