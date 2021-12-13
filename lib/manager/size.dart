import 'package:flutter/material.dart';

class SizeManager {
  /// Returns the dimension for the fingerprint icon's height and width
  static double fingerprint(Size size) {
    return size.height * .07;
  }

  /// Returns the [Size] for the security screen logo
  static Size logo(Size size) {
    return Size(
      size.width * .26,
      size.height * .20,
    );
  }

  /// Returns the dimension for the profile picture's height and width
  static double profile(Size size) {
    return size.height * .09;
  }
}
