import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:grupus/features/auth/services/otp_services.dart';
import 'package:grupus/features/auth/state/registration_provider.dart';
import 'package:grupus/shared/components/custom_filled_btn.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:grupus/shared/components/custom_snackbar.dart';
import 'package:grupus/shared/constants/app_constants.dart';
import 'package:grupus/shared/utils/logs.dart';

class VerifyEmailScreen extends ConsumerStatefulWidget {
  final String email;

  const VerifyEmailScreen({super.key, required this.email});

  @override
  ConsumerState<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends ConsumerState<VerifyEmailScreen> {
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
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.paddingMedium,
          ),
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

  void _submit() async {
    if (enteredOTP.length < 6) {
      CustomSnackbar(
        message: "Enter a valid OTP",
        color: Theme.of(context).colorScheme.error,
      ).showSnackBar(context);
      return;
    }

    try {
      String email = ref.read(registrationProvider).email;

      //Verify OTP first
      var otpService = OtpServices();
      bool response = await otpService.verifyOTP(email, int.parse(enteredOTP));

      if (!response) {
        CustomSnackbar(
          message: "Invalid OTP. Please try again.",
          color: Theme.of(context).colorScheme.error,
        ).showSnackBar(context);
        return;
      }

      ref.read(registrationProvider.notifier)
        ..updateOTP(int.parse(enteredOTP))
        ..nextStep();

      context.pushNamed("create-username");
    } catch (e) {
      CustomSnackbar(
        message: "An error occurred $e",
        color: Theme.of(context).colorScheme.error,
      ).showSnackBar(context);
      DevLogs.logError("Error during OTP submission: $e");
    }
  }
}
