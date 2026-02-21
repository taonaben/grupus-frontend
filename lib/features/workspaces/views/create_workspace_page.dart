import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:grupus/features/workspaces/components/workspace_type_metadata_fields.dart';
import 'package:grupus/features/workspaces/state/workspace_types_provider.dart';
import 'package:grupus/shared/components/custom_dropdown_form_field.dart';
import 'package:grupus/shared/components/custom_filled_btn.dart';
import 'package:grupus/shared/components/custom_progress_indicator.dart';
import 'package:grupus/shared/components/custom_textfield.dart';
import 'package:grupus/shared/constants/app_constants.dart';
import 'package:grupus/shared/utils/logs.dart';
import 'package:grupus/shared/utils/string_methods.dart';

class CreateWorkspacePage extends ConsumerStatefulWidget {
  const CreateWorkspacePage({super.key});

  @override
  ConsumerState<CreateWorkspacePage> createState() =>
      _CreateWorkspacePageState();
}

class _CreateWorkspacePageState extends ConsumerState<CreateWorkspacePage> {
  String? selectedType;
  Map<String, dynamic>? selectedTypeData;
  Map<String, dynamic> metadataPayload = {};

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

      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.paddingLarge,
            ),
            child: Column(
              children: [
                _buildWorkspaceForm(),
                _getWorkspaceTypeOptions(),
                const Gap(AppConstants.gapMedium),
                _buildWorkspaceTypeForm(),
                CustomFilledButton(btnLabel: "Create", onTap: () {}),
              ],
            ),
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
    final workspaceTypesAsyncValue = ref.watch(allWorkspaceTypesProvider);

    return workspaceTypesAsyncValue.when(
      data: (types) {
        if (types.isEmpty) {
          return const Text("No workspace types available");
        }

        return CustomDropdownFormField(
          labelText: 'Select Space Type',
          value: selectedType,
          items:
              types
                  .map(
                    (type) => DropdownMenuItem(
                      value: type['name'] as String,
                      child: Text(capitalize(type['name'] as String)),
                    ),
                  )
                  .toList(),
          onChanged: (value) {
            setState(() {
              selectedType = value;
              if (value == null) {
                selectedTypeData = null;
                metadataPayload = {};
                return;
              }

              final matchedType = types.firstWhere(
                (type) => type['name'] == value,
                orElse: () => <String, dynamic>{},
              );

              selectedTypeData = matchedType.isEmpty ? null : matchedType;
              metadataPayload = {};
            });
          },
        );
      },
      loading: () => const CustomProgressIndicator(),
      error: (e, st) {
        DevLogs.logError('Error loading workspace types: $e');
        return const Text("Failed to load workspace types");
      },
    );
  }

  Widget _buildWorkspaceTypeForm() {
    if (selectedTypeData == null || selectedType == null) {
      return const SizedBox.shrink();
    }

    return WorkspaceTypeMetadataFields(
      workspaceType: selectedTypeData!,
      initialMetadata: metadataPayload,
      onMetadataChanged: (metadata) {
        setState(() => metadataPayload = metadata);
      },
    );
  }
}
