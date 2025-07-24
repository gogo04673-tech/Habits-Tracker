import 'package:flutter/material.dart';

Color mainColor = const Color(0xFF111C22);

// * Light mode is here
ThemeData lightMode = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white,

  // * text theme is here
  textTheme: const TextTheme(
    bodyLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    bodyMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
  ),

  // * ColorScheme is here
  colorScheme: const ColorScheme.light(
    tertiary: Colors.white,
    primary: Color(0xFF111C22),
    secondaryContainer: Colors.white,
    onPrimaryContainer: Colors.blue,
  ),
  appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
);

// * Dark mode is here
ThemeData darkMode = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: mainColor,

  // * appbar is here
  appBarTheme: AppBarTheme(backgroundColor: mainColor),

  // * Text theme is here
  textTheme: const TextTheme(
    bodyLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    bodyMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    bodySmall: TextStyle(fontWeight: FontWeight.bold),
  ),

  // * ColorScheme is here
  colorScheme: ColorScheme.dark(
    tertiary: const Color(0xFF1a2a32),
    primary: Colors.white,
    secondaryContainer: mainColor,
    // ignore: deprecated_member_use
    onPrimaryContainer: Colors.white.withOpacity(0.15),
  ),
);
