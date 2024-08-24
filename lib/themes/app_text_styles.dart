import 'package:flutter/material.dart';

class AppTextStyles {
  static const theme = TextTheme(
    headlineLarge: AppTextStyles.header1,
    headlineMedium: AppTextStyles.header2,
    headlineSmall: AppTextStyles.header3,
    bodySmall: AppTextStyles.body,
  );

  static const TextStyle header1 = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 30,
  );
  static const TextStyle header2 = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 24,
  );
  static const TextStyle header3 = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 18,
  );
  static const TextStyle header4 = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle body = TextStyle(
    fontFamily: 'Nunito',
    fontSize: 16,
  );
  static const TextStyle bodyEm = TextStyle(
    fontFamily: 'Nunito',
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
}

extension CustomTextTheme on TextTheme {
  TextStyle get headlineSmallEm => AppTextStyles.header4;
  TextStyle get bodySmallEm => AppTextStyles.bodyEm;
}
