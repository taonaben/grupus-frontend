import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:grupus/shared/components/custom_filled_btn.dart';
import 'package:grupus/shared/components/custom_textfield.dart';
import 'package:grupus/shared/constants/app_constants.dart';

class ProfileCreateScreen extends StatefulWidget {
  const ProfileCreateScreen({super.key});

  @override
  State<ProfileCreateScreen> createState() => _ProfileCreateScreenState();
}

class _ProfileCreateScreenState extends State<ProfileCreateScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
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
            onPressed: () {
              context.pushNamed("workspaces");
            },
            child: const Text("Skip"),
          ),
        ],
      ),
      body: Center(
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
    );
  }

  Widget profileForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.paddingMedium,
      ),
      child: Column(
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
      ),
    );
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      context.pushNamed("workspaces");
    }
  }
}
