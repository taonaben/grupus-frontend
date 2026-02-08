import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grupus/shared/theme/app_theme.dart';

final themeProvider = ChangeNotifierProvider<ThemeProvider>(
  (ref) => ThemeProvider(),
);

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  late ThemeData _lightTheme;
  late ThemeData _darkTheme;

  ThemeProvider() {
    _lightTheme = AppTheme.lightTheme;
    _darkTheme = AppTheme.darkTheme;
    _initializeSystemTheme();
  }

  void _initializeSystemTheme() {
    final brightness = WidgetsBinding.instance.window.platformBrightness;
    if (brightness == Brightness.dark) {
      _themeMode = ThemeMode.dark;
    } else {
      _themeMode = ThemeMode.light;
    }
  }

  ThemeMode get themeMode => _themeMode;

  ThemeData get lightTheme => _lightTheme;

  ThemeData get darkTheme => _darkTheme;

  ThemeData get currentTheme {
    switch (_themeMode) {
      case ThemeMode.dark:
        return _darkTheme;
      case ThemeMode.light:
        return _lightTheme;
      case ThemeMode.system:
        final brightness = WidgetsBinding.instance.window.platformBrightness;
        return brightness == Brightness.dark ? _darkTheme : _lightTheme;
    }
  }

  Brightness get currentBrightness => currentTheme.brightness;

  bool get isDarkMode => _themeMode == ThemeMode.dark;

  bool get isLightMode => _themeMode == ThemeMode.light;

  /// Toggle between light and dark mode
  void toggleTheme() {
    if (_themeMode == ThemeMode.dark) {
      setLightMode();
    } else {
      setDarkMode();
    }
  }

  /// Set theme to light mode
  void setLightMode() {
    _themeMode = ThemeMode.light;
    _updateSystemUiOverlay();
    notifyListeners();
  }

  /// Set theme to dark mode
  void setDarkMode() {
    _themeMode = ThemeMode.dark;
    _updateSystemUiOverlay();
    notifyListeners();
  }

  /// Set theme to follow system settings
  void setSystemMode() {
    _themeMode = ThemeMode.system;
    _updateSystemUiOverlay();
    notifyListeners();
  }

  /// Update system UI overlay colors based on current theme
  void _updateSystemUiOverlay() {
    final isDark =
        _themeMode == ThemeMode.dark ||
        (_themeMode == ThemeMode.system &&
            WidgetsBinding.instance.window.platformBrightness ==
                Brightness.dark);

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        systemNavigationBarColor:
            isDark ? const Color(0xFF121212) : const Color(0xFFFAFAFA),
        systemNavigationBarIconBrightness:
            isDark ? Brightness.light : Brightness.dark,
      ),
    );
  }
}
