import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grupus/shared/constants/app_constants.dart';

class CustomTextfield extends StatefulWidget {
  final String? hintText;
  final String? labelText;
  final Color? labelTextColor;
  final String? helperText;
  final int maxLines;
  final int? maxLength;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final FocusNode? focusNode;
  final FormFieldValidator<String>? validator;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final VoidCallback? onEditingComplete;
  final bool obscureText;
  final bool readOnly;
  final int minLines;

  const CustomTextfield({
    super.key,
    this.hintText,
    this.labelText,
    this.labelTextColor,
    this.helperText,
    this.maxLines = 1,
    this.minLines = 1,
    this.maxLength,
    this.keyboardType = TextInputType.text,
    this.controller,
    this.onChanged,
    this.focusNode,
    this.validator,
    this.suffixIcon,
    this.prefixIcon,
    this.onEditingComplete,
    this.obscureText = false,
    this.readOnly = false,
  });

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  late final TextInputFormatter? _numberFormatter;

  @override
  void initState() {
    super.initState();
    _numberFormatter =
        widget.keyboardType == TextInputType.number
            ? FilteringTextInputFormatter.allow(RegExp(r'[0-9\.]'))
            : null;
  }

  InputBorder _buildBorder(Color color) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(AppConstants.borderRadiusMedium),
    borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
  );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bodyMediumColor = theme.textTheme.bodyMedium?.color;
    final textColor = widget.labelTextColor ?? bodyMediumColor;

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: widget.controller,
            focusNode: widget.focusNode,
            keyboardType: widget.keyboardType,
            textInputAction: TextInputAction.next,
            maxLines: widget.obscureText ? 1 : widget.maxLines,
            minLines: widget.minLines,
            maxLength: widget.maxLength,
            obscureText: widget.obscureText,
            readOnly: widget.readOnly,
            onChanged: widget.onChanged,
            onEditingComplete: widget.onEditingComplete,
            validator: widget.validator,
            inputFormatters:
                _numberFormatter != null ? [_numberFormatter!] : null,
            style: TextStyle(color: textColor),
            decoration: InputDecoration(
              hintText: widget.hintText,
              label:
                  widget.labelText != null
                      ? Text(
                        widget.labelText!,
                        style: TextStyle(color: textColor),
                      )
                      : null,
              hintStyle: TextStyle(
                color: bodyMediumColor?.withOpacity(0.6),
                fontSize: 12,
              ),
              helperText: widget.helperText,
              helperMaxLines: 2,
              border: _buildBorder(theme.primaryColor),
              enabledBorder: _buildBorder(theme.primaryColor),
              focusedBorder: _buildBorder(theme.primaryColor),
              errorBorder: _buildBorder(theme.colorScheme.error),
              focusedErrorBorder: _buildBorder(theme.colorScheme.error),
              suffixIcon: widget.suffixIcon,
              prefixIcon: widget.prefixIcon,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
