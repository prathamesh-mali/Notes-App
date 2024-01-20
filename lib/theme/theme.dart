import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  // appBarTheme:
  //     const AppBarTheme(backgroundColor: Color.fromARGB(149, 104, 58, 183)),
  colorScheme: ColorScheme.light(
    background: Colors.white,
    primary: Colors.grey.shade400,
    secondary: Colors.grey.shade600,
    inversePrimary: Colors.grey.shade800,
  ),
);

//dark theme
ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  // appBarTheme:
  //     const AppBarTheme(backgroundColor: Color.fromARGB(192, 104, 58, 183)),
  colorScheme: ColorScheme.dark(
    background: Colors.grey.shade900,
    primary: Colors.grey.shade800,
    secondary: Colors.grey.shade700,
    inversePrimary: Colors.grey.shade300,
  ),
);
