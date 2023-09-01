import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ThemeType { light, dark }

class ThemeManager with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;

  ThemeManager() {
    loadTheme();
  }

  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeType = prefs.getString('theme') ?? 'system';
    _themeMode = _convertStringToThemeMode(themeType);
    notifyListeners();
  }

  Future<void> saveTheme(ThemeType themeType) async {
    final prefs = await SharedPreferences.getInstance();
    final themeString = _convertThemeModeToString(themeType);
    await prefs.setString('theme', themeString);
  }

  Future<void> toggleTheme(bool isDarkMode) async {
    _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    await saveTheme(
        _themeMode == ThemeMode.dark ? ThemeType.dark : ThemeType.light);
    notifyListeners();
  }

  ThemeMode _convertStringToThemeMode(String themeString) {
    switch (themeString) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  String _convertThemeModeToString(ThemeType themeType) {
    switch (themeType) {
      case ThemeType.light:
        return 'light';
      case ThemeType.dark:
        return 'dark';
      default:
        return 'system';
    }
  }
}
