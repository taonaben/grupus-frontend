import 'package:flutter/material.dart';
import 'package:grupus/shared/theme/app_colors.dart';

extension ThemeExtension on BuildContext {
  /// Get current theme data
  ThemeData get theme => Theme.of(this);

  /// Get color scheme
  ColorScheme get colorScheme => theme.colorScheme;

  /// Get text theme
  TextTheme get textTheme => theme.textTheme;

  /// Check if dark mode is active
  bool get isDarkMode => theme.brightness == Brightness.dark;

  /// Check if light mode is active
  bool get isLightMode => theme.brightness == Brightness.light;

  /// Get primary color
  Color get primaryColor => colorScheme.primary;

  /// Get secondary color
  Color get secondaryColor => colorScheme.secondary;

  /// Get background color
  Color get backgroundColor => colorScheme.background;

  /// Get surface color
  Color get surfaceColor => colorScheme.surface;

  /// Get text primary color
  Color get textPrimary =>
      isDarkMode ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;

  /// Get text secondary color
  Color get textSecondary =>
      isDarkMode ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

  /// Get border color
  Color get borderColor =>
      isDarkMode ? AppColors.darkBorder : AppColors.lightBorder;

  /// Get divider color
  Color get dividerColor =>
      isDarkMode ? AppColors.darkDivider : AppColors.lightDivider;

  /// Get error color
  Color get errorColor => colorScheme.error;

  /// Get success color
  Color get successColor =>
      isDarkMode ? AppColors.darkSuccess : AppColors.lightSuccess;

  /// Get warning color
  Color get warningColor =>
      isDarkMode ? AppColors.darkWarning : AppColors.lightWarning;

  /// Get info color
  Color get infoColor => isDarkMode ? AppColors.darkInfo : AppColors.lightInfo;
}
