import 'package:flutter/material.dart';

const kSwatchPrimary = Color(0xFF262626);
const kSwatchSecondary = Color(0xFFF4F4F4);

const kSwatchWhite = Colors.white;
const kSwatchGreyDark = Color(0xFF7B7B7B);

const kSwatchTextLink = Color(0xFF1A1B41);
const kSwatchError = Color(0xFFF71641);

const kFontTitle = "RobotoMono";

ThemeData themeData() {
  final base = ThemeData.light();

  return base.copyWith(
    primaryColor: kSwatchPrimary,
    accentColor: kSwatchWhite,
    appBarTheme: AppBarTheme(
      backwardsCompatibility: false,
      foregroundColor: kSwatchPrimary,
      backgroundColor: kSwatchSecondary,
    ),
    backgroundColor: kSwatchWhite,
    errorColor: kSwatchError,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: kSwatchPrimary,
      foregroundColor: kSwatchWhite,
    ),
    iconTheme: IconThemeData(
      color: kSwatchPrimary,
    ),
    scaffoldBackgroundColor: kSwatchWhite,
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      actionTextColor: kSwatchWhite,
    ),
    textTheme: _textTheme(base),
  );
}

TextTheme _textTheme(ThemeData base) {
  //TextField uses subtitle1 as default style so don't modify
  return base.textTheme.copyWith(
    headline4: TextStyle(
      color: kSwatchPrimary,
      fontFamily: kFontTitle,
    ),
    headline5: TextStyle(
      color: kSwatchWhite,
      fontFamily: kFontTitle,
    ),
    headline6: TextStyle(
      color: kSwatchPrimary,
      fontWeight: FontWeight.normal,
    ),
    bodyText2: TextStyle(
      color: kSwatchGreyDark,
    ),
  );
}
