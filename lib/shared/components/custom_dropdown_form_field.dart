import 'package:flutter/material.dart';
import 'package:grupus/shared/constants/app_constants.dart';

/// Styled dropdown that mirrors the look & feel of other Grupus form fields.
class CustomDropdownFormField extends StatelessWidget {
  const CustomDropdownFormField({
    super.key,
    required this.items,
    this.value,
    this.onChanged,
    this.validator,
    this.labelText,
    this.labelTextColor,
    this.hintText,
    this.helperText,
    this.prefixIcon,
    this.suffixIcon,
    this.isExpanded = true,
    this.enabled = true,
  });

  final List<DropdownMenuItem<String>> items;
  final String? value;
  final ValueChanged<String?>? onChanged;
  final FormFieldValidator<String>? validator;
  final String? labelText;
  final Color? labelTextColor;
  final String? hintText;
  final String? helperText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool isExpanded;
  final bool enabled;

  OutlineInputBorder _buildBorder(BuildContext context, Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppConstants.borderRadiusMedium),
      borderSide: BorderSide(color: color),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bodyMediumColor = theme.textTheme.bodyMedium?.color;
    final textColor = labelTextColor ?? bodyMediumColor;

    return Padding(
      padding: const EdgeInsets.only(top: AppConstants.paddingSmall),
      child: DropdownButtonFormField<String>(
        value: value,
        items: items,
        onChanged: enabled ? onChanged : null,
        validator: validator,
        isExpanded: isExpanded,
        icon: const Icon(Icons.keyboard_arrow_down_rounded),
        decoration: InputDecoration(
          hintText: hintText,
          label:
              labelText != null
                  ? Text(labelText!, style: TextStyle(color: textColor))
                  : null,
          hintStyle: TextStyle(
            color: bodyMediumColor?.withOpacity(0.6),
            fontSize: 12,
          ),
          helperText: helperText,
          helperMaxLines: 2,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 14,
          ),
          border: _buildBorder(context, theme.colorScheme.primary),
          enabledBorder: _buildBorder(context, theme.colorScheme.primary),
          focusedBorder: _buildBorder(context, theme.colorScheme.primary),
          errorBorder: _buildBorder(context, theme.colorScheme.error),
          focusedErrorBorder: _buildBorder(context, theme.colorScheme.error),
        ),
        dropdownColor: theme.colorScheme.surface,
      ),
    );
  }
}
