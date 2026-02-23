import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:grupus/features/workspaces/components/workspace_type_metadata_fields.dart';
import 'package:grupus/features/workspaces/models/workspace_create_model.dart';
import 'package:grupus/features/workspaces/services/workspace_create_services.dart';
import 'package:grupus/features/workspaces/state/workspace_types_provider.dart';
import 'package:grupus/features/workspaces/state/workspaces_provider.dart';
import 'package:grupus/shared/components/custom_dropdown_form_field.dart';
import 'package:grupus/shared/components/custom_filled_btn.dart';
import 'package:grupus/shared/components/custom_progress_indicator.dart';
import 'package:grupus/shared/components/custom_snackbar.dart';
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
  final _formKey = GlobalKey<FormState>();
  String? selectedType;
  String? selectedTypeId;
  Map<String, dynamic>? selectedTypeData;
  Map<String, dynamic> metadataPayload = {};

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

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
        actions: [
          ElevatedButton(
            onPressed: _isSubmitting ? null : _submit,
            child:
                _isSubmitting
                    ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                    : const Text("Create"),
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.paddingLarge,
            ),
            child: Column(
              children: [
                Form(key: _formKey, child: _buildWorkspaceForm()),
                _getWorkspaceTypeOptions(),
                const Gap(AppConstants.gapMedium),
                _buildWorkspaceTypeForm(),
                // CustomFilledButton(btnLabel: "Create", onTap: () {}),
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
        CustomTextfield(
          labelText: "Name*",
          controller: nameController,
          validator:
              (value) =>
                  (value == null || value.trim().isEmpty)
                      ? "Name is required"
                      : null,
        ),
        const Gap(AppConstants.gapMedium),
        CustomTextfield(
          labelText: "Description",
          controller: descriptionController,
          maxLines: 3,
        ),
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

              selectedTypeId = matchedType['id'] as String?;

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

  void _submit() async {
    if (_isSubmitting) return;

    final formValid = _formKey.currentState?.validate() ?? false;
    if (!formValid) {
      return;
    }

    if (selectedTypeId == null) {
      if (mounted) {
        CustomSnackbar(
          message: "Please select a space type",
          color: Theme.of(context).colorScheme.error,
        ).showSnackBar(context);
      }
      return;
    }

    FocusScope.of(context).unfocus();

    final isPublic = metadataPayload['is_public'] as bool?;
    final requireApproval = metadataPayload['requires_approval'] as bool?;
    final maxMembers = metadataPayload['max_members'] as int?;
    final guidelines = metadataPayload['content_guidelines'] as String?;

    // Filter out null values from metadata
    final filteredMetadata = Map<String, dynamic>.from(metadataPayload)
      ..removeWhere((key, value) => value == null);

    final workspace = WorkspaceCreateModel(
      name: nameController.text.trim(),
      description:
          descriptionController.text.trim().isEmpty
              ? null
              : descriptionController.text.trim(),
      workspace_type: selectedTypeId!,
      metadata: filteredMetadata.isEmpty ? {} : filteredMetadata,
      is_public: true,
      requires_approval: true,
      // max_members: maxMembers,
      // content_guidelines: guidelines,
    );

    DevLogs.logInfo("Creating workspace with data: ${workspace.toJson()}");

    try {
      setState(() => _isSubmitting = true);
      final createWorkspaceService = WorkspaceCreateServices();
      final response = await createWorkspaceService.createWorkspace(workspace);

      if (!mounted) return;

      if (response.success) {
        CustomSnackbar(
          message: response.message ?? "Workspace created successfully",
          color: Theme.of(context).colorScheme.primary,
        ).showSnackBar(context);
        ref.refresh(allWorkspacesProvider);
        Navigator.pop(context, true);
      } else {
        CustomSnackbar(
          message: response.message ?? "Failed to create workspace",
          color: Theme.of(context).colorScheme.error,
        ).showSnackBar(context);
      }
    } catch (e) {
      DevLogs.logError("Error creating workspace: $e");
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }
}
