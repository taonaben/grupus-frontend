import 'package:flutter/material.dart';

class AppColors {
  // Light Mode Colors
  static const Color lightPrimary = Color(0xFF6200EE);
  static const Color lightPrimaryDark = Color(0xFF3700B3);
  static const Color lightSecondary = Color(0xFF03DAC6);
  static const Color lightSecondaryDark = Color(0xFF018786);
  static const Color lightBackground = Color(0xFFFAFAFA);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightError = Color(0xFFB00020);
  static const Color lightErrorDark = Color(0xFF8B0000);

  // Text Colors - Light Mode
  static const Color lightTextPrimary = Color(0xFF212121);
  static const Color lightTextSecondary = Color(0xFF757575);
  static const Color lightTextTertiary = Color(0xFFBDBDBD);
  static const Color lightTextHint = Color(0xFFE0E0E0);

  // Additional Light Colors
  static const Color lightBorder = Color(0xFFE0E0E0);
  static const Color lightDivider = Color(0xFFEEEEEE);
  static const Color lightSuccess = Color(0xFF4CAF50);
  static const Color lightWarning = Color(0xFFFFC107);
  static const Color lightInfo = Color(0xFF2196F3);

  // Dark Mode Colors
  static const Color darkPrimary = Color(0xFFBB86FC);
  static const Color darkPrimaryDark = Color(0xFF3700B3);
  static const Color darkSecondary = Color(0xFF03DAC6);
  static const Color darkSecondaryDark = Color(0xFF03DAC6);
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color darkError = Color(0xFFCF6679);
  static const Color darkErrorDark = Color(0xFFB1365F);

  // Text Colors - Dark Mode
  static const Color darkTextPrimary = Color(0xFFFFFFFF);
  static const Color darkTextSecondary = Color(0xFFB3B3B3);
  static const Color darkTextTertiary = Color(0xFF808080);
  static const Color darkTextHint = Color(0xFF616161);

  // Additional Dark Colors
  static const Color darkBorder = Color(0xFF424242);
  static const Color darkDivider = Color(0xFF212121);
  static const Color darkSuccess = Color(0xFF81C784);
  static const Color darkWarning = Color(0xFFFFD54F);
  static const Color darkInfo = Color(0xFF64B5F6);

  // Semantic Colors (used for both modes)
  static const Color transparent = Color(0x00000000);
  static const Color shadow = Color(0x1A000000);

  // Get colors based on brightness
  static Color getPrimary(Brightness brightness) =>
      brightness == Brightness.dark ? darkPrimary : lightPrimary;

  static Color getSecondary(Brightness brightness) =>
      brightness == Brightness.dark ? darkSecondary : lightSecondary;

  static Color getBackground(Brightness brightness) =>
      brightness == Brightness.dark ? darkBackground : lightBackground;

  static Color getSurface(Brightness brightness) =>
      brightness == Brightness.dark ? darkSurface : lightSurface;

  static Color getTextPrimary(Brightness brightness) =>
      brightness == Brightness.dark ? darkTextPrimary : lightTextPrimary;

  static Color getTextSecondary(Brightness brightness) =>
      brightness == Brightness.dark ? darkTextSecondary : lightTextSecondary;

  static Color getError(Brightness brightness) =>
      brightness == Brightness.dark ? darkError : lightError;

  static Color getBorder(Brightness brightness) =>
      brightness == Brightness.dark ? darkBorder : lightBorder;

  static Color getDivider(Brightness brightness) =>
      brightness == Brightness.dark ? darkDivider : lightDivider;
}
