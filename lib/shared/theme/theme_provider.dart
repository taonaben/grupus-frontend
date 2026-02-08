import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = ThemeData.light();

  ThemeData get themeData => _themeData;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  ThemeMode get currentTheme =>
      _themeData.brightness == Brightness.dark
          ? ThemeMode.dark
          : ThemeMode.light;

  ThemeData get lightMode => ThemeData.light();

  ThemeData get darkMode => ThemeData.dark();

  ThemeData get systemMode =>
      WidgetsBinding.instance.window.platformBrightness == Brightness.dark
          ? darkMode
          : lightMode;

  void toggleTheme() {
    if (_themeData == lightMode) {
      themeData = darkMode;
    } else {
      themeData = lightMode;
    }
  }

  void setDarkMode() {
    themeData = darkMode;
  }

  void setLightMode() {
    themeData = lightMode;
  }

  void setSystemMode() {
    themeData = systemMode;
  }
}
