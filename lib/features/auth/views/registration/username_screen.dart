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
import 'package:grupus/shared/constants/index.dart';
import 'package:grupus/shared/utils/logs.dart';

class UsernameScreen extends ConsumerStatefulWidget {
  const UsernameScreen({super.key});

  @override
  ConsumerState<UsernameScreen> createState() => _UsernameScreenState();
}

class _UsernameScreenState extends ConsumerState<UsernameScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController usernameController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
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
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Grupus", style: Theme.of(context).textTheme.headlineMedium),
            const Gap(AppConstants.gapSmall),
            Text(
              "Create username",
              style: Theme.of(context).textTheme.headlineLarge,
            ),

            const Gap(AppConstants.gapLarge),
            identityForm(),
          ],
        ),
      ),
    );
  }

  Widget identityForm() {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.paddingMedium,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Pick a username for your new account. You can always change it later.",
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
            const Gap(AppConstants.gapMedium),
            CustomTextfield(
              controller: usernameController,
              labelText: "Username",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your username';
                }
                return null;
              },
              suffixIcon: const Icon(
                CupertinoIcons.check_mark_circled_solid,
                color: Colors.green,
              ),
            ),
            const Gap(AppConstants.gapLarge),
            CustomFilledButton(btnLabel: "Continue", onTap: _submit),
          ],
        ),
      ),
    );
  }

  void _submit() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        ref.read(registrationProvider.notifier)
          ..updateUsername(usernameController.text.trim())
          ..nextStep();

        bool register = await _register();

        if (register) {
          context.pushNamed("workspaces");
        }
      } catch (e) {
        CustomSnackbar(
          message: "An error occurred $e",
          color: Theme.of(context).colorScheme.error,
        ).showSnackBar(context);
        DevLogs.logError("Error during username submission: $e");
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
