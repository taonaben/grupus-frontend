import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:grupus/shared/components/custom_filled_btn.dart';
import 'package:grupus/shared/components/custom_textfield.dart';
import 'package:grupus/shared/constants/app_constants.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
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
                ? const CircularProgressIndicator()
                : CustomFilledButton(btnLabel: "Register", onTap: _submit),
          ],
        ),
      ),
    );
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      if (passwordController.text != confirmPasswordController.text) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Passwords do not match")));
        return;
      }

      context.pushNamed("verify-email", extra: emailController.text.trim());
    }
  }
}
