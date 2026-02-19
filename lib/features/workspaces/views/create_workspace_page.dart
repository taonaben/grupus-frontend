import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:grupus/shared/components/custom_filled_btn.dart';
import 'package:grupus/shared/components/custom_textfield.dart';
import 'package:grupus/shared/constants/app_constants.dart';

class CreateWorkspacePage extends StatelessWidget {
  const CreateWorkspacePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Create Space",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        leading: IconButton(
          icon: const Icon(CupertinoIcons.xmark),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.paddingLarge,
          ),
          child: Column(
            children: [
              _buildWorkspaceForm(),
              _getWorkspaceTypeOptions(),
              _buildWorkspaceTypeForm(),
              CustomFilledButton(btnLabel: "Create", onTap: () {}),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWorkspaceForm() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomTextfield(labelText: "Space Name (required)"),
        const Gap(AppConstants.gapMedium),
        CustomTextfield(labelText: "Description"),
        const Gap(AppConstants.gapMedium),
      ],
    );
  }

  Widget _getWorkspaceTypeOptions() {
    return Column(mainAxisSize: MainAxisSize.min, children: []);
  }

  Widget _buildWorkspaceTypeForm() {
    return Column(mainAxisSize: MainAxisSize.min, children: []);
  }
}
