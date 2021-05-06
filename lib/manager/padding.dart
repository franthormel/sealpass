import 'package:flutter/material.dart';

class PaddingManager {
  static const _kSecurityV = .02;
  static const _kSecurityH = .05;

  static EdgeInsets security(Size parent) {
    return EdgeInsets.symmetric(
      horizontal: parent.width * _kSecurityH,
      vertical: parent.height * _kSecurityV,
    );
  }
}
