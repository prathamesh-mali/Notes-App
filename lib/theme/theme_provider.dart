import "package:flutter/material.dart";
import "package:notes_app/theme/theme.dart";

class ThemeProvider with ChangeNotifier {
  ThemeData _themedata = lightMode;

  ThemeData get themedata => _themedata;

  bool get isDarkMode => _themedata == darkMode;

  set themedata(ThemeData themedata) {
    _themedata = themedata;
    notifyListeners();
  }

  void toogleTheme() {
    if (_themedata == lightMode) {
      _themedata = darkMode;
    } else {
      _themedata = lightMode;
    }
    notifyListeners();
  }
}
