import 'package:flutter/material.dart';

class SizeManager {
  static const _kLogoW = .26;
  static const _kLogoH = .20;

  static const _kIconFinger = .07;

  ///Returns the size for image logo
  static Size logo(Size size) {
    return Size(
      size.width * _kLogoW,
      size.height * _kLogoH,
    );
  }

  ///Returns the width for the fingerprint icon
  static double iconFinger(Size size) {
    return size.height * _kIconFinger;
  }
}
