import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:grupus/features/auth/services/register_services.dart';
import 'package:grupus/features/auth/state/registration_provider.dart';
import 'package:grupus/shared/components/custom_filled_btn.dart';
import 'package:grupus/shared/components/custom_snackbar.dart';
import 'package:grupus/shared/components/custom_textfield.dart';
import 'package:grupus/shared/constants/app_constants.dart';
import 'package:grupus/shared/utils/logs.dart';

class ProfileCreateScreen extends ConsumerStatefulWidget {
  const ProfileCreateScreen({super.key});

  @override
  ConsumerState<ProfileCreateScreen> createState() =>
      _ProfileCreateScreenState();
}

class _ProfileCreateScreenState extends ConsumerState<ProfileCreateScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  String profilePictureUrl =
      ""; // This will hold the URL of the uploaded profile picture

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(CupertinoIcons.chevron_left),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              try {
                bool register = await _register();

                if (register) {
                  context.pushNamed("workspaces");
                }
              } catch (e) {
                CustomSnackbar(
                  message: "An error occurred $e",
                  color: Theme.of(context).colorScheme.error,
                ).showSnackBar(context);
                DevLogs.logError("Error during profile creation: $e");
              }
            },
            child: const Text("Skip"),
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.paddingMedium,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Create your profile",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const Gap(AppConstants.gapMedium),
              Text(
                "Create your profile by providing your first and last name. You can always do this later.",
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),

              const Gap(AppConstants.gapLarge),
              profileForm(),
            ],
          ),
        ),
      ),
    );
  }

  Widget profileForm() {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: Theme.of(context).dividerColor,
          child: const Icon(
            CupertinoIcons.person,
            size: 50,
            color: Colors.white,
          ),
        ),
        const Gap(AppConstants.gapMedium),
        Row(
          children: [
            Expanded(
              child: CustomTextfield(
                controller: firstNameController,
                labelText: "First Name",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your first name';
                  }
                  return null;
                },
              ),
            ),
            const Gap(AppConstants.gapMedium),

            Expanded(
              child: CustomTextfield(
                controller: lastNameController,
                labelText: "Last Name",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your last name';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
        const Gap(AppConstants.gapMedium),
        CustomTextfield(
          labelText: "Bio",
          hintText: "Tell us about yourself",
          maxLines: 2,
          maxLength: 100,
        ),
        const Gap(AppConstants.gapMedium),
        CustomFilledButton(btnLabel: "Continue", onTap: _submit),
      ],
    );
  }

  void _submit() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        ref
            .read(registrationProvider.notifier)
            .updatePersonalInfo(
              bio: bioController.text.trim(),
              firstName: firstNameController.text.trim(),
              lastName: lastNameController.text.trim(),
              profilePicture: profilePictureUrl.trim(),
              notificationSettings: "",
              preferredLanguage: "en",
            );

        bool register = await _register();

        if (register) {
          context.pushNamed("workspaces");
        }
      } catch (e) {
        CustomSnackbar(
          message: "An error occurred $e",
          color: Theme.of(context).colorScheme.error,
        ).showSnackBar(context);
        DevLogs.logError("Error during profile creation: $e");
      }
    }
  }

  Future<bool> _register() async {
    try {
      final registrationData = ref.read(registrationProvider);
      var registerService = RegisterServices();

      bool response = await registerService.registerUser(registrationData);

      if (!response) {
        CustomSnackbar(
          message: "Registration failed. Please try again.",
          color: Theme.of(context).colorScheme.error,
        ).showSnackBar(context);
        return false;
      }
      return true;
    } catch (e) {
      CustomSnackbar(
        message: "An error occurred during registration: $e",
        color: Theme.of(context).colorScheme.error,
      ).showSnackBar(context);
      DevLogs.logError("Error during registration: $e");
    }
    return false;
  }
}
