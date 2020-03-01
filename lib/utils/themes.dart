import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'dark.dart';
import 'light.dart';

class Themes {
  Themes();

  static const Color primaryColor = Colors.blue;

  static ThemeData getTheme(ThemeMode themeMode) {
    ThemeData themeData = ThemeData();
    switch (themeMode) {
      case ThemeMode.system:
        // TODO: Handle this case.
        break;
      case ThemeMode.light:
        return light.copyWith(
          primaryColor: primaryColor,
          indicatorColor: primaryColor,
          textSelectionColor: primaryColor,
          accentColor: primaryColor,
          colorScheme: light.colorScheme.copyWith(
              secondary: primaryColor, secondaryVariant: primaryColor),
        );
      case ThemeMode.dark:
        return dark.copyWith(
          primaryColor: primaryColor,
          indicatorColor: primaryColor,
          textSelectionColor: primaryColor,
          accentColor: primaryColor,
          colorScheme: dark.colorScheme.copyWith(
              secondary: primaryColor, secondaryVariant: primaryColor),
        );
    }
    return themeData;
  }

  static DatePickerTheme getDateThemPickerTheme(BuildContext context) {
    return DatePickerTheme(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        doneStyle: Theme.of(context)
            .textTheme
            .caption
            .copyWith(color: Theme.of(context).primaryColor),
        cancelStyle: Theme.of(context).textTheme.caption,
        itemStyle: Theme.of(context).textTheme.caption);
  }
}
