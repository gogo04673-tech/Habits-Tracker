import 'package:flutter/material.dart';

Color mainColor = const Color(0xFF111C22);

// * Light mode is here
ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    primary: const Color(0xFF111C22),
    secondaryContainer: Colors.white,
    onPrimaryContainer: Colors.blue,
  ),
  appBarTheme: AppBarTheme(backgroundColor: Colors.white),
);

// * Dark mode is here
ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: mainColor,
  appBarTheme: AppBarTheme(backgroundColor: mainColor),

  colorScheme: ColorScheme.dark(
    primary: Colors.white,
    secondaryContainer: mainColor,
    onPrimaryContainer: Colors.white.withOpacity(0.15),
    secondary: Colors.white54,
  ),
);
