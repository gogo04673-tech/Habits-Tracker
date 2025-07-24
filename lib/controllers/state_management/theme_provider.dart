import 'package:flutter/material.dart';
import 'package:habit_track/controllers/models/theme.dart';

class ThemeProvider with ChangeNotifier {
  // variable private isDark here
  bool _isDark = false;

  bool get isDark => _isDark;

  // * change theme
  void changeTheme(value) {
    _isDark = value;
    toggleTheme();
    notifyListeners();
  }

  // ! New code is here
  ThemeData _themeData = darkMode;

  ThemeData get themeData => _themeData;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeData == darkMode) {
      _themeData = lightMode;
    } else {
      _themeData = darkMode;
    }
  }
}
