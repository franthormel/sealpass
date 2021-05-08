import 'package:flutter/material.dart';

class PaddingManager {
  static const _kSecurityVertical = .02;
  static const _kSecurityHorizontal = .05;

  static const _kHomeVertical = .02;
  static const _kHomeHorizontal = .01;

  ///Returns padding for [Security] screen
  static EdgeInsets security(Size size) {
    return EdgeInsets.symmetric(
      horizontal: size.width * _kSecurityHorizontal,
      vertical: size.height * _kSecurityVertical,
    );
  }

  ///Returns padding for [Home] screen
  static EdgeInsets home(Size size) {
    final horizontal = size.width * _kHomeHorizontal;
    return EdgeInsets.only(
      top: size.height * _kHomeVertical,
      left: horizontal,
      right: horizontal,
    );
  }
}
