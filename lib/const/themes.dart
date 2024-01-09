import 'package:flutter/material.dart';

abstract class LightThemeColors {
  static Color get background => const Color(0xFFFFFFFF);
  static Color get textPrimaryColor => const Color(0xFF000000);
  static Color get highEmphasisOnAccent => const Color(0xFFE8CBA6);
  static Color get highEmphasisOnAccentLight => const Color(0xFFFFE7C9);
  static Color get primaryColor => Color(0xff34313B);

}

abstract class DarkThemeColors {
  static Color get background => const Color(0xFF000000);
  static Color get textPrimaryColor => const Color(0xFFE1E1E1);
  static Color get highEmphasisOnAccent => const Color(0xFFC7482A);
  static Color get primaryColor =>Colors.red;
}



class ThemedColor {
  final Color light;
  final Color dark;

  const ThemedColor({
    required this.light,
    required this.dark,
  })  : assert(light != null),
        assert(dark != null);

  Color getColor(BuildContext context) {
    switch (Theme.of(context).brightness) {
      case Brightness.light:
        return light;
      case Brightness.dark:
        return dark;
    }
    throw UnsupportedError('${Theme.of(context).brightness} is not supported');
  }
}


abstract class AppColors {

  static Color background(BuildContext context) => ThemedColor(
    light: LightThemeColors.background,
    dark: DarkThemeColors.background,
  ).getColor(context);

  static Color textPrimaryColor(BuildContext context) => ThemedColor(
    light: LightThemeColors.textPrimaryColor,
    dark: DarkThemeColors.textPrimaryColor,
  ).getColor(context);

  static Color primaryColor(BuildContext context) => ThemedColor(
    light: LightThemeColors.primaryColor,
    dark: DarkThemeColors.primaryColor,
  ).getColor(context);

  static Color highEmphasisOnAccent(BuildContext context) => ThemedColor(
    light: LightThemeColors.highEmphasisOnAccent,
    dark: DarkThemeColors.highEmphasisOnAccent,
  ).getColor(context);
}


final Map<ThemeMode, ThemeData> appThemes = {
  ThemeMode.light: ThemeData(
    hintColor: LightThemeColors.highEmphasisOnAccent,
    primarySwatch:LightThemeColors.primaryColor as MaterialColor?,
    primaryColor: LightThemeColors.primaryColor,
    scaffoldBackgroundColor: LightThemeColors.background,
    brightness: Brightness.light,

  ),
  ThemeMode.dark: ThemeData(
    hintColor: DarkThemeColors.highEmphasisOnAccent,
    primarySwatch:DarkThemeColors.primaryColor as MaterialColor?,
    primaryColor: DarkThemeColors.primaryColor,
    scaffoldBackgroundColor: DarkThemeColors.background,
    brightness: Brightness.dark,
  )
};

