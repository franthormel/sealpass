import 'package:flutter/material.dart';

class SizeManager {
  static const _kLogoW = .26;
  static const _kLogoH = .20;

  static const _kIconFingerW = .13;
  static const _kIconFingerH = .07;

  ///Returns the size for image logo
  static Size logo(Size size) {
    return Size(
      size.width * _kLogoW,
      size.height * _kLogoH,
    );
  }

  ///Returns the size for the fingerprint icon
  static double iconFinger(Size size) {
    //LESS accurate
    //return size.width * _kIconFingerW;
    //MORE accurate
    return size.height * _kIconFingerH;
  }
}
