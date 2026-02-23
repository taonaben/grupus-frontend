import 'package:flutter/cupertino.dart';
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
  final Map<String, bool> _includedFields =
      {}; // Track which optional fields are included
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
    _fieldsSchema =
        widget.workspaceType['schema']?['fields'] as Map<String, dynamic>?;
    if (_fieldsSchema == null) return;

    for (final entry in _fieldsSchema!.entries) {
      final fieldName = entry.key;
      final fieldConfig = entry.value as Map<String, dynamic>? ?? {};
      final isRequired = fieldConfig['required'] as bool? ?? false;
      final initialValue = widget.initialMetadata[fieldName]?.toString() ?? '';

      // Track inclusion state: required fields are always included
      _includedFields[fieldName] =
          isRequired || widget.initialMetadata.containsKey(fieldName);

      _setMetadataValue(fieldName, widget.initialMetadata[fieldName]);
      _controllers[fieldName] = TextEditingController(text: initialValue);
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

  void _setMetadataValue(String key, dynamic value) {
    if (value == null || (value is String && value.trim().isEmpty)) {
      _metadata.remove(key);
      return;
    }
    _metadata[key] = value;
  }

  void _handleValueChange(String key, dynamic value) {
    if (!_includedFields[key]!) return; // Don't update if field is not included
    _setMetadataValue(key, value);
    _notifyParent();
  }

  void _toggleFieldInclusion(String fieldName) {
    setState(() {
      _includedFields[fieldName] = !_includedFields[fieldName]!;
      if (!_includedFields[fieldName]!) {
        // Remove from metadata if field is deselected
        _metadata.remove(fieldName);
        _controllers[fieldName]?.clear();
      }
    });
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

    final fields = <Widget>[];

    for (final entry in _fieldsSchema!.entries) {
      final fieldName = entry.key;
      final fieldConfig = entry.value as Map<String, dynamic>? ?? {};
      final fieldType = fieldConfig['type'] as String? ?? 'string';
      final isRequired = fieldConfig['required'] as bool? ?? false;
      final fieldIncluded = _includedFields[fieldName] ?? false;

      // Required fields are always shown
      if (isRequired) {
        fields.add(
          Padding(
            padding: const EdgeInsets.only(bottom: AppConstants.paddingSmall),
            child: _buildField(
              context,
              fieldName,
              fieldType,
              isRequired,
              _controllers[fieldName]!,
            ),
          ),
        );
      } else {
        // Optional fields have a checkbox toggle
        fields.add(
          Padding(
            padding: const EdgeInsets.only(bottom: AppConstants.paddingSmall),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  value: fieldIncluded,
                  onChanged: (value) => _toggleFieldInclusion(fieldName),
                  title: Text(
                    _formatLabelText(fieldName, false),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  subtitle: const Text('Optional'),
                ),
                if (fieldIncluded)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: _buildField(
                      context,
                      fieldName,
                      fieldType,
                      isRequired,
                      _controllers[fieldName]!,
                    ),
                  ),
              ],
            ),
          ),
        );
      }
    }

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
      case 'integer':
        return CustomTextfield(
          labelText: _label(fieldName, isRequired),
          controller: controller,
          keyboardType: TextInputType.number,
          onChanged: (value) {
            // Convert to number before updating metadata
            if (value.isEmpty) {
              _handleValueChange(fieldName, null);
            } else {
              final numValue = num.tryParse(value);
              if (numValue != null) {
                _handleValueChange(fieldName, numValue);
              }
            }
          },
          validator: (value) {
            if (isRequired && (value == null || value.isEmpty)) {
              return 'This field is required';
            }
            if (value != null && value.isNotEmpty) {
              final numValue = num.tryParse(value);
              if (numValue == null) {
                return 'Please enter a valid number';
              }
            }
            return null;
          },
        );
      case 'array':
        return _ArrayField(
          fieldName: fieldName,
          controller: controller,
          isRequired: isRequired,
          onArrayChanged: (value) => _handleValueChange(fieldName, value),
        );
      case 'boolean':
        return CheckboxListTile(
          title: Text(_label(fieldName, isRequired)),
          value: controller.text == 'true',
          onChanged: (value) {
            controller.text = value?.toString() ?? 'false';
            _handleValueChange(fieldName, value ?? false);
          },
          contentPadding: EdgeInsets.zero,
        );
      case 'string':
      case 'user':
      default:
        return CustomTextfield(
          labelText: _label(fieldName, isRequired),
          controller: controller,
          onChanged: (value) => _handleValueChange(fieldName, value),
          validator: (value) {
            if (isRequired && (value == null || value.isEmpty)) {
              return 'This field is required';
            }
            return null;
          },
        );
    }
  }

  String _label(String name, bool isRequired) =>
      _formatLabelText(name, isRequired);
}

class _ArrayField extends StatefulWidget {
  const _ArrayField({
    required this.fieldName,
    required this.controller,
    required this.isRequired,
    required this.onArrayChanged,
  });

  final String fieldName;
  final TextEditingController controller;
  final bool isRequired;
  final ValueChanged<List<String>> onArrayChanged;

  @override
  State<_ArrayField> createState() => _ArrayFieldState();
}

class _ArrayFieldState extends State<_ArrayField> {
  late List<TextEditingController> _itemControllers = [];

  @override
  void initState() {
    super.initState();
    _initializeArrayControllers();
  }

  void _initializeArrayControllers() {
    final currentValue = widget.controller.text;
    if (currentValue.isNotEmpty) {
      final items = currentValue.split(',').map((e) => e.trim()).toList();
      _itemControllers =
          items.map((item) => TextEditingController(text: item)).toList();
    } else {
      _itemControllers = [TextEditingController()];
    }
  }

  void _updateMainController() {
    final items =
        _itemControllers
            .map((c) => c.text.trim())
            .where((text) => text.isNotEmpty)
            .toList();
    widget.onArrayChanged(items);
  }

  void _addItem() {
    setState(() {
      _itemControllers.add(TextEditingController());
    });
  }

  void _removeItem(int index) {
    setState(() {
      _itemControllers[index].dispose();
      _itemControllers.removeAt(index);
      _updateMainController();
    });
  }

  @override
  void dispose() {
    for (final controller in _itemControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _formatLabelText(widget.fieldName, widget.isRequired),
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 8),
        ..._itemControllers.asMap().entries.map((entry) {
          final index = entry.key;
          final controller = entry.value;
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: CustomTextfield(
                    labelText: 'Item ${index + 1}',
                    controller: controller,
                    onChanged: (_) => _updateMainController(),
                  ),
                ),
                if (_itemControllers.length > 1)
                  IconButton(
                    icon: const Icon(CupertinoIcons.xmark_circle_fill),
                    onPressed: () => _removeItem(index),
                  ),
              ],
            ),
          );
        }).toList(),
        TextButton.icon(
          onPressed: _addItem,
          icon: const Icon(CupertinoIcons.plus_circle),
          label: const Text('Add item'),
        ),
      ],
    );
  }
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
          suffixIcon: const Icon(CupertinoIcons.calendar, size: 18),
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
