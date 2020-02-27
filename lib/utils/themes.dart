import 'package:flutter/material.dart';

class Themes {
  Themes();

  static const Color primary = Colors.blue;

  static final _dark = ThemeData(
    primarySwatch: MaterialColor(
      Colors.black.value,
      const <int, Color>{
        50: Colors.black12,
        100: Colors.black26,
        200: Colors.black38,
        300: Colors.black45,
        400: Colors.black54,
        500: Colors.black87,
        600: Colors.black87,
        700: Colors.black87,
        800: Colors.black87,
        900: Colors.black87,
      },
    ),
    backgroundColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
  );

  static final _light = ThemeData(
    primarySwatch: MaterialColor(
      Colors.white.value,
      const <int, Color>{
        50: Colors.white10,
        100: Colors.white12,
        200: Colors.white24,
        300: Colors.white30,
        400: Colors.white54,
        500: Colors.white70,
        600: Colors.white70,
        700: Colors.white70,
        800: Colors.white70,
        900: Colors.white70,
      },
    ),
    backgroundColor: Colors.black,
    scaffoldBackgroundColor: Colors.black,
  );

  static ThemeData getTheme(ThemeMode themeMode) {
    ThemeData themeData = ThemeData();
    switch (themeMode) {
      case ThemeMode.system:
        // TODO: Handle this case.
        break;
      case ThemeMode.light:
        themeData = _light.copyWith(
          primaryColor: primary,
        );
        break;
      case ThemeMode.dark:
        themeData = _dark.copyWith(
          primaryColor: primary,
        );
        break;
    }
    return themeData;
  }
}
