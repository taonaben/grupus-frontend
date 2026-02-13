import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:grupus/features/auth/services/otp_services.dart';
import 'package:grupus/features/auth/state/registration_provider.dart';
import 'package:grupus/shared/components/custom_filled_btn.dart';
import 'package:grupus/shared/components/custom_progress_indicator.dart';
import 'package:grupus/shared/components/custom_snackbar.dart';
import 'package:grupus/shared/components/custom_textfield.dart';
import 'package:grupus/shared/constants/app_constants.dart';

class RegistrationPage extends ConsumerStatefulWidget {
  const RegistrationPage({super.key});

  @override
  ConsumerState<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends ConsumerState<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool is_loading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Grupus", style: Theme.of(context).textTheme.headlineMedium),
            const Gap(AppConstants.gapSmall),
            Text("Welcome!", style: Theme.of(context).textTheme.headlineLarge),

            const Gap(AppConstants.gapXLarge),
            registrationForm(),
            const Gap(AppConstants.gapXLarge),

            RichText(
              text: TextSpan(
                text: "Already have an account? ",
                style: Theme.of(context).textTheme.bodyMedium,
                children: [
                  TextSpan(
                    text: "Login",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    recognizer:
                        TapGestureRecognizer()
                          ..onTap = () {
                            context.go("/login");
                          },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget registrationForm() {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomTextfield(
              labelText: 'Email Address',
              controller: emailController,
              validator:
                  (p0) =>
                      p0 == null || p0.isEmpty ? "Email cannot be empty" : null,
            ),
            const Gap(AppConstants.gapMedium),
            CustomTextfield(
              labelText: 'Password',
              obscureText: true,
              controller: passwordController,
              validator:
                  (p0) =>
                      p0 == null || p0.isEmpty
                          ? "Password cannot be empty"
                          : null,
            ),
            const Gap(AppConstants.gapMedium),
            CustomTextfield(
              labelText: 'Confirm Password',
              obscureText: true,
              controller: confirmPasswordController,
              validator:
                  (p0) =>
                      p0 == null || p0.isEmpty
                          ? "Confirm Password cannot be empty"
                          : null,
            ),
            const Gap(AppConstants.gapLarge),
            is_loading
                ? const CustomProgressIndicator()
                : CustomFilledButton(btnLabel: "Register", onTap: _submit),
          ],
        ),
      ),
    );
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      if (passwordController.text != confirmPasswordController.text) {
        CustomSnackbar(
          message: "Passwords do not match",
          color: Theme.of(context).colorScheme.error,
        ).showSnackBar(context);
        return;
      }

      setState(() {
        is_loading = true;
      });

      try {
        var otpService = OtpServices();

        bool otpSent = await otpService.requestOTP(emailController.text.trim());

        if (!otpSent) {
          CustomSnackbar(
            message: "Failed to send OTP",
            color: Theme.of(context).colorScheme.error,
          ).showSnackBar(context);
          setState(() {
            is_loading = false;
          });
          return;
        }

        ref.read(registrationProvider.notifier)
          ..updateEmail(emailController.text.trim())
          ..updatePassword(confirmPasswordController.text.trim())
          ..nextStep();

        setState(() {
          is_loading = false;
        });

        context.pushNamed("verify-email", extra: emailController.text.trim());
      } catch (e) {
        CustomSnackbar(
          message: "An error occurred: $e",
          color: Theme.of(context).colorScheme.error,
        ).showSnackBar(context);
        setState(() {
          is_loading = false;
        });
        return;
      }
    }
  }
}
