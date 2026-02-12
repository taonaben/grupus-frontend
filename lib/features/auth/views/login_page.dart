import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:grupus/features/auth/services/auth_services.dart';
import 'package:grupus/shared/components/custom_filled_btn.dart';
import 'package:grupus/shared/components/custom_outlined_btn.dart';
import 'package:grupus/shared/components/custom_snackbar.dart';
import 'package:grupus/shared/components/custom_textfield.dart';
import 'package:grupus/shared/components/index.dart';
import 'package:grupus/shared/constants/app_constants.dart';
import 'package:grupus/shared/utils/logs.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool is_loading = false;

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Grupus", style: Theme.of(context).textTheme.headlineMedium),
              const Gap(AppConstants.gapSmall),
              Text(
                "Welcome!",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              // const Gap(8),
              // Text(
              //   "Please login to your account",
              //   style: Theme.of(context).textTheme.bodyMedium,
              // ),
              const Gap(AppConstants.gapXLarge  ),
              loginForm(),
              alternativeLoginOptions(),
              const Gap(AppConstants.gapXLarge),

              RichText(
                text: TextSpan(
                  text: "Don't have an account? ",
                  style: Theme.of(context).textTheme.bodyMedium,
                  children: [
                    TextSpan(
                      text: "Register",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      recognizer:
                          TapGestureRecognizer()
                            ..onTap = () {
                              context.go("/register");
                            },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget loginForm() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomTextfield(
            labelText: 'Username',
            controller: usernameController,
            validator:
                (p0) =>
                    p0 == null || p0.isEmpty
                        ? "Username cannot be empty"
                        : null,
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
          const Gap(AppConstants.gapLarge),
          is_loading
              ? const CircularProgressIndicator()
              : CustomFilledButton(btnLabel: "Login", onTap: _submit),
        ],
      ),
    );
  }

  Widget alternativeLoginOptions() {
    return Column(
      children: [
        const Gap(AppConstants.gapMedium),
        Text("Or login with", style: Theme.of(context).textTheme.bodyMedium),
        const Gap(AppConstants.gapMedium),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: CustomOutlinedButton(btnLabel: "Google", onTap: () {}),
            ),
            const Gap(AppConstants.gapMedium),
            Expanded(
              child: CustomOutlinedButton(btnLabel: "Apple", onTap: () {}),
            ),
          ],
        ),
      ],
    );
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        is_loading = true;
      });

      final AuthServices authServices = AuthServices();

      authServices.login(usernameController.text, passwordController.text).then(
        (success) {
          setState(() {
            is_loading = false;
          });

          if (success) {
            context.go("/home");
          } else {
            CustomSnackbar(
              message: "Failed to login",
              color: Theme.of(context).colorScheme.error,
            ).showSnackBar(context);
          }
        },
      );
    }
  }
}
