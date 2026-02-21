import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:grupus/shared/components/custom_textfield.dart';
import 'package:grupus/shared/constants/app_constants.dart';

class WorkspaceTypeMetadataFields extends StatefulWidget {
  const WorkspaceTypeMetadataFields({
    super.key,
    required this.workspaceType,
    required this.onMetadataChanged,
    this.initialMetadata = const {},
  });

  /// Raw workspace type definition containing schema/fields
  final Map<String, dynamic> workspaceType;

  /// Callback invoked whenever metadata changes
  final ValueChanged<Map<String, dynamic>> onMetadataChanged;

  /// Initial metadata values, useful when editing an existing workspace
  final Map<String, dynamic> initialMetadata;

  @override
  State<WorkspaceTypeMetadataFields> createState() =>
      _WorkspaceTypeMetadataFieldsState();
}

class _WorkspaceTypeMetadataFieldsState
    extends State<WorkspaceTypeMetadataFields> {
  final Map<String, TextEditingController> _controllers = {};
  final Map<String, dynamic> _metadata = {};
  Map<String, dynamic>? _fieldsSchema;

  @override
  void initState() {
    super.initState();
    _initializeSchemaAndControllers();
  }

  @override
  void didUpdateWidget(covariant WorkspaceTypeMetadataFields oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.workspaceType != widget.workspaceType) {
      _disposeControllers();
      _initializeSchemaAndControllers();
    }
  }

  @override
  void dispose() {
    _disposeControllers();
    super.dispose();
  }

  void _initializeSchemaAndControllers() {
    _fieldsSchema = widget.workspaceType['schema']?['fields']
        as Map<String, dynamic>?;
    if (_fieldsSchema == null) return;

    for (final entry in _fieldsSchema!.entries) {
      final fieldName = entry.key;
      final initialValue = widget.initialMetadata[fieldName]?.toString() ?? '';
      _metadata[fieldName] = widget.initialMetadata[fieldName];
      _controllers[fieldName] = TextEditingController(text: initialValue);
      _controllers[fieldName]!.addListener(() {
        _handleValueChange(fieldName, _controllers[fieldName]!.text);
      });
    }

    _notifyParent();
  }

  void _disposeControllers() {
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    _controllers.clear();
    _metadata.clear();
  }

  void _handleValueChange(String key, dynamic value) {
    _metadata[key] = value;
    _notifyParent();
  }

  void _notifyParent() {
    if (!mounted) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      widget.onMetadataChanged(Map<String, dynamic>.from(_metadata));
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_fieldsSchema == null || _fieldsSchema!.isEmpty) {
      return const SizedBox.shrink();
    }

    final fields = _fieldsSchema!.entries.map((entry) {
      final fieldName = entry.key;
      final fieldConfig = entry.value as Map<String, dynamic>? ?? {};
      final fieldType = fieldConfig['type'] as String? ?? 'string';
      final isRequired = fieldConfig['required'] as bool? ?? false;
      return Padding(
        padding: const EdgeInsets.only(bottom: AppConstants.paddingSmall),
        child: _buildField(
          context,
          fieldName,
          fieldType,
          isRequired,
          _controllers[fieldName]!,
        ),
      );
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: fields,
    );
  }

  Widget _buildField(
    BuildContext context,
    String fieldName,
    String type,
    bool isRequired,
    TextEditingController controller,
  ) {
    switch (type) {
      case 'date':
        return _DateField(
          fieldName: fieldName,
          controller: controller,
          isRequired: isRequired,
          onDateSelected: (value) => _handleValueChange(fieldName, value),
        );
      case 'number':
        return CustomTextfield(
          labelText: _label(fieldName, isRequired),
          controller: controller,
          keyboardType: TextInputType.number,
        );
      case 'string':
      case 'user':
      default:
        return CustomTextfield(
          labelText: _label(fieldName, isRequired),
          controller: controller,
        );
    }
  }

  String _label(String name, bool isRequired) =>
      _formatLabelText(name, isRequired);
}

class _DateField extends StatefulWidget {
  const _DateField({
    required this.fieldName,
    required this.controller,
    required this.isRequired,
    required this.onDateSelected,
  });

  final String fieldName;
  final TextEditingController controller;
  final bool isRequired;
  final ValueChanged<String> onDateSelected;

  @override
  State<_DateField> createState() => _DateFieldState();
}

class _DateFieldState extends State<_DateField> {
  final DateFormat _formatter = DateFormat('yyyy-MM-dd');

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year - 5),
      lastDate: DateTime(now.year + 5),
    );
    if (picked != null) {
      final formatted = _formatter.format(picked);
      widget.controller.text = formatted;
      widget.onDateSelected(formatted);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickDate,
      child: AbsorbPointer(
        child: CustomTextfield(
          labelText: _formatLabelText(widget.fieldName, widget.isRequired),
          controller: widget.controller,
          suffixIcon: const Icon(Icons.calendar_today_rounded, size: 18),
          readOnly: true,
        ),
      ),
    );
  }
}

String _formatLabelText(String raw, bool isRequired) {
  final sanitized = raw.replaceAll('_', ' ').trim();
  if (sanitized.isEmpty) {
    return isRequired ? '* Required' : '';
  }
  final capitalized =
      sanitized[0].toUpperCase() + sanitized.substring(1).toLowerCase();
  return isRequired ? '$capitalized *' : capitalized;
}