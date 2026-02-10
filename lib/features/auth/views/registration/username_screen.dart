import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:grupus/shared/components/custom_filled_btn.dart';
import 'package:grupus/shared/constants/index.dart';

class UsernameScreen extends StatefulWidget {
  const UsernameScreen({super.key});

  @override
  State<UsernameScreen> createState() => _UsernameScreenState();
}

class _UsernameScreenState extends State<UsernameScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
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
            // Row(
            //   children: [
            //     Expanded(
            //       child: TextFormField(
            //         controller: firstNameController,
            //         decoration: const InputDecoration(labelText: "First Name"),
            //         validator: (value) {
            //           if (value == null || value.isEmpty) {
            //             return 'Please enter your first name';
            //           }
            //           return null;
            //         },
            //       ),
            //     ),
            //     const Gap(AppConstants.gapMedium),

            //     Expanded(
            //       child: TextFormField(
            //         controller: lastNameController,
            //         decoration: const InputDecoration(labelText: "Last Name"),
            //         validator: (value) {
            //           if (value == null || value.isEmpty) {
            //             return 'Please enter your last name';
            //           }
            //           return null;
            //         },
            //       ),
            //     ),
            //   ],
            // ),
            // const Gap(AppConstants.gapMedium),
            Text(
              "Pick a username for your new account. You can always change it later.",
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
            const Gap(AppConstants.gapMedium),
            TextFormField(
              controller: usernameController,
              decoration: const InputDecoration(labelText: "Username"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your username';
                }
                return null;
              },
            ),
            const Gap(AppConstants.gapLarge),
            CustomFilledButton(btnLabel: "Continue", onTap: () {}),
          ],
        ),
      ),
    );
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {}
  }
}
