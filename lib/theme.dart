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
  final textTheme = _textTheme(base);

  return base.copyWith(
    primaryColor: kSwatchPrimary,
    accentColor: kSwatchWhite,
    backgroundColor: kSwatchWhite,
    scaffoldBackgroundColor: kSwatchWhite,
    textTheme: textTheme,
  );
}

TextTheme _textTheme(ThemeData base) {
  return base.textTheme
      .copyWith(
        headline4: TextStyle(
          color: kSwatchPrimary,
          fontFamily: kFontTitle,
        ),
      )
      .apply(
        bodyColor: kSwatchPrimary,
        displayColor: kSwatchPrimary,
      );
}
