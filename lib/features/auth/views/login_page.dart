import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:grupus/features/auth/services/auth_services.dart';
import 'package:grupus/shared/components/custom_filled_btn.dart';
import 'package:grupus/shared/components/custom_snackbar.dart';
import 'package:grupus/shared/components/custom_textfield.dart';
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
          child: LoginForm(),
        ),
      ),
    );
  }

  Widget LoginForm() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomTextfield(
            labelText: 'username',
            controller: usernameController,
            validator:
                (p0) =>
                    p0 == null || p0.isEmpty
                        ? "Username cannot be empty"
                        : null,
          ),
          const Gap(16),
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
          const Gap(24),
          is_loading
              ? const CircularProgressIndicator()
              : CustomFilledButton(btnLabel: "Verify", onTap: _submit),
        ],
      ),
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
