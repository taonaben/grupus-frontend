import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:grupus/shared/components/custom_filled_btn.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:grupus/shared/constants/app_constants.dart';
import 'package:grupus/shared/utils/logs.dart';

class VerifyEmailScreen extends StatefulWidget {
  final String email;

  const VerifyEmailScreen({super.key, required this.email});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  String enteredOTP = '';
  bool isLoading = false;

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
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: AppConstants.paddingMedium,),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Enter your OTP',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gap(AppConstants.gapMedium),
              Text(
                'Please enter the 6-digit OTP sent to ${widget.email}',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const Gap(AppConstants.gapXLarge),
              OtpTextField(
                numberOfFields: 6,
                borderColor: Theme.of(context).dividerColor,
                focusedBorderColor: Theme.of(context).colorScheme.primary,
                showCursor: true,
                borderRadius: BorderRadius.circular(
                  AppConstants.borderRadiusMedium,
                ),
                contentPadding: EdgeInsets.all(AppConstants.paddingSmall),
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                textStyle: TextStyle(
                  fontSize: AppConstants.fontSizeLarge,
                  fontWeight: FontWeight.bold,
                ),

                showFieldAsBox: true,
                borderWidth: 1,
                onCodeChanged: (String code) {},
                onSubmit: (String verificationCode) {
                  setState(() {
                    enteredOTP = verificationCode;
                  });

                  DevLogs.logInfo("Submitted OTP: $verificationCode");
                },
              ),
              const Gap(AppConstants.gapMedium),

              RichText(
                text: TextSpan(
                  text: "Didn't receive the OTP? ",
                  style: Theme.of(context).textTheme.bodyMedium,
                  children: [
                    TextSpan(
                      text: "Resend",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      recognizer: TapGestureRecognizer()..onTap = () {},
                    ),
                  ],
                ),
              ),

              const Gap(AppConstants.gapXLarge),
              isLoading
                  ? const CircularProgressIndicator()
                  : CustomFilledButton(btnLabel: 'Verify', onTap: _submit),
              const Gap(AppConstants.gapXLarge),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: "By continuing, you're indicating that you accept our ",
                  style: Theme.of(context).textTheme.bodySmall,

                  children: [
                    TextSpan(
                      text: "Terms of Use",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      recognizer: TapGestureRecognizer()..onTap = () {},
                    ),
                    TextSpan(
                      text: " and ",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    TextSpan(
                      text: "Privacy Policy",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      recognizer: TapGestureRecognizer()..onTap = () {},
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

  void _submit() {
    if (enteredOTP.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter the complete OTP")),
      );
      return;
    }

    context.pushNamed("register-identity");
  }
}
