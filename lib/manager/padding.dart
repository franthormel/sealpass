import 'package:flutter/material.dart';

class PaddingManager {
  /// Returns [EdgeInsets] for account screens
  static EdgeInsets account(Size size) {
    final horizontal = size.width * .05;
    return EdgeInsets.only(
      top: size.height * .04,
      right: horizontal,
      left: horizontal,
    );
  }

  /// Returns [EdgeInsets] for [DrawerHeader]
  static EdgeInsets drawerHeader(Size size) {
    return EdgeInsets.symmetric(
      vertical: size.height * .01,
    );
  }

  /// Returns [EdgeInsets] for [Home] and [Search] screen
  static EdgeInsets homeSearch(Size size) {
    final horizontal = size.width * .01;
    return EdgeInsets.only(
      top: size.height * .02,
      left: horizontal,
      right: horizontal,
    );
  }

  /// Returns [EdgeInsets] for [Security] screen
  static EdgeInsets security(Size size) {
    return EdgeInsets.symmetric(
      horizontal: size.width * .05,
      vertical: size.height * .02,
    );
  }
}
