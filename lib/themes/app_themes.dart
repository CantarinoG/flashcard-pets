import 'package:flashcard_pets/themes/app_colors.dart';
import 'package:flashcard_pets/themes/app_text_styles.dart';
import 'package:flutter/material.dart';

class AppThemes {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    fontFamily: 'Nunito',
    primaryColor: AppColors.primaryColorLight,
    disabledColor: AppColors.lightGrayColor,
    scaffoldBackgroundColor: AppColors.backgroundColorLight,
    splashColor: AppColors.secondaryColorLight,
    colorScheme:
        ColorScheme.fromSeed(seedColor: AppColors.primaryColorLight).copyWith(
      brightness: Brightness.light,
      primary: AppColors.primaryColorLight,
      error: AppColors.errorColorLight,
      secondary: AppColors.secondaryColorLight,
      surface: AppColors.backgroundColorLight,
    ),
    textTheme: AppTextStyles.theme,
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    fontFamily: 'Nunito',
    primaryColor: AppColors.primaryColorDark,
    disabledColor: AppColors.lightGrayColor,
    scaffoldBackgroundColor: AppColors.backgroundColorDark,
    splashColor: AppColors.secondaryColorDark,
    colorScheme:
        ColorScheme.fromSeed(seedColor: AppColors.primaryColorDark).copyWith(
      brightness: Brightness.dark,
      primary: AppColors.primaryColorDark,
      error: AppColors.errorColorDark,
      secondary: AppColors.secondaryColorDark,
      surface: AppColors.backgroundColorDark,
    ),
    textTheme: AppTextStyles.theme.apply(
      bodyColor: AppColors.whiteColor,
      displayColor: AppColors.whiteColor,
    ),
  );
}

/// Extension to add custom color properties to the [ColorScheme] class.
///
/// This extension is designed to simplify the use of custom colors across the application
/// by providing easy-to-access properties for different color states, such as text, warning,
/// success, and disabled colors. These properties automatically adapt based on the current
/// brightness (light or dark mode) to ensure that the color scheme remains consistent and
/// visually appealing in both themes.
extension CustomColorScheme on ColorScheme {
  Color get text => brightness == Brightness.light
      ? AppColors.blackColor
      : AppColors.whiteColor;
  Color get bright => brightness == Brightness.light
      ? AppColors.whiteColor
      : const Color.fromARGB(255, 53, 52, 52);
  Color get warning => brightness == Brightness.light
      ? AppColors.warningColorLight
      : AppColors.warningColorDark;
  Color get success => brightness == Brightness.light
      ? AppColors.successColorLight
      : AppColors.successColorDark;
  Color get disabled => AppColors.lightGrayColor;
  Color get star => AppColors.starColor;
  Color get starLighter => AppColors.starColorLighter;
}
