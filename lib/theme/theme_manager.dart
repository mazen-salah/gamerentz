import 'package:flutter/material.dart';

class ThemeManager with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  get themeMode => _themeMode;
  toggleTheme(bool isDarkMode) {
    _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

ThemeManager themeManager = ThemeManager();

void toggleTheme(){
themeManager.toggleTheme(
              themeManager.themeMode == ThemeMode.dark ? false : true,
            );
}
