import 'package:flutter/material.dart';

class SizeManager {
  static const _kLogoW = .26;
  static const _kLogoH = .20;

  static const _kIconFinger = .07;

  static const _kProfilePicture = .09;

  ///Returns the size for security screen logo
  static Size logo(Size size) {
    return Size(
      size.width * _kLogoW,
      size.height * _kLogoH,
    );
  }

  ///Returns the [double] value for the fingerprint icon's height and width
  static double iconFinger(Size size) {
    return size.height * _kIconFinger;
  }

  ///Returns the [double] value for the profile picture's height an width
  static double profile(Size size) {
    return size.height * _kProfilePicture;
  }
}
