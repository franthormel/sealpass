import 'package:flutter/material.dart';

const kSwatchPrimary = Color(0xFF262626);
const kSwatchSecondary = Color(0xFFF4F4F4);

const kSwatchWhite = Colors.white;
const kSwatchGreyDark = Color(0xFF7B7B7B);

const kSwatchTextLink = Color(0xFF1A1B41);
const kSwatchSuccess = Color(0xFF50C468);
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
    scaffoldBackgroundColor: kSwatchWhite,
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      actionTextColor: kSwatchSuccess,
    ),
    textTheme: _textTheme(base),
  );
}

TextTheme _textTheme(ThemeData base) {
  //Rules
  //1. Never touch subtitle1
  //2. We're using bodyText1 as 'link' text
  return base.textTheme.copyWith(
    headline4: TextStyle(
      color: kSwatchPrimary,
      fontFamily: kFontTitle,
    ),
    headline6: TextStyle(
      color: kSwatchPrimary,
      fontWeight: FontWeight.normal,
    ),
    bodyText1: TextStyle(
      fontSize: base.textTheme.bodyText2.fontSize,
      color: kSwatchTextLink,
    ),
    bodyText2: TextStyle(
      color: kSwatchGreyDark,
    ),
  );
}
