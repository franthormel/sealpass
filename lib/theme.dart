import 'package:flutter/material.dart';

const kSwatchPrimary = Color(0xFF262626);
const kSwatchSecondary = Color(0xFFF4F4F4);
const kSwatchGreyDark = Color(0xFF7B7B7B);
const kSwatchTextLink = Color(0xFF1A1B41);
const kSwatchError = Color(0xFFF71641);

ThemeData themeData() {
  final base = ThemeData.light();

  return base.copyWith(
    primaryColor: kSwatchPrimary,
    colorScheme: base.colorScheme.copyWith(
      secondary: Colors.white,
    ),
    appBarTheme: const AppBarTheme(
      foregroundColor: kSwatchPrimary,
      backgroundColor: kSwatchSecondary,
    ),
    backgroundColor: Colors.white,
    errorColor: kSwatchError,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: kSwatchPrimary,
      foregroundColor: Colors.white,
    ),
    iconTheme: const IconThemeData(
      color: kSwatchPrimary,
    ),
    scaffoldBackgroundColor: Colors.white,
    snackBarTheme: const SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      actionTextColor: Colors.white,
    ),
    textTheme: _textTheme(base),
  );
}

TextTheme _textTheme(ThemeData base) {
  const fontFamily = "RobotoMono";

  return base.textTheme.copyWith(
    headline4: const TextStyle(
      color: kSwatchPrimary,
      fontFamily: fontFamily,
    ),
    headline5: const TextStyle(
      color: Colors.white,
      fontFamily: fontFamily,
    ),
    headline6: const TextStyle(
      color: kSwatchPrimary,
      fontWeight: FontWeight.normal,
    ),
    bodyText2: const TextStyle(
      color: kSwatchGreyDark,
    ),
  );
}
