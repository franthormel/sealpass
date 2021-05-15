import 'package:flutter/material.dart';

class PaddingManager {
  static const _kSecurityVertical = .02;
  static const _kSecurityHorizontal = .05;

  static const _kHomeVertical = .02;
  static const _kHomeHorizontal = .01;

  static const _kAccountAddVertical = .04;
  static const _kAccountAddHorizontal = .05;

  static const _kDrawerHeaderVertical = .01;

  ///Returns [EdgeInsets] for [AccountAdd] and [AccountView] screen
  static EdgeInsets account(Size size) {
    final horizontal = size.width * _kAccountAddHorizontal;
    return EdgeInsets.only(
      top: size.height * _kAccountAddVertical,
      right: horizontal,
      left: horizontal,
    );
  }

  ///Returns [EdgeInsets] for [DrawerHeader]
  static EdgeInsets header(Size size) {
    return EdgeInsets.symmetric(
      vertical: size.height * _kDrawerHeaderVertical,
    );
  }

  ///Returns [EdgeInsets] for [Home] and [Search] screen
  static EdgeInsets home(Size size) {
    final horizontal = size.width * _kHomeHorizontal;
    return EdgeInsets.only(
      top: size.height * _kHomeVertical,
      left: horizontal,
      right: horizontal,
    );
  }

  ///Returns [EdgeInsets] for [Security] screen
  static EdgeInsets security(Size size) {
    return EdgeInsets.symmetric(
      horizontal: size.width * _kSecurityHorizontal,
      vertical: size.height * _kSecurityVertical,
    );
  }
}
