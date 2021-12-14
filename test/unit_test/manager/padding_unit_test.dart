import 'package:flutter/material.dart';
import 'package:test/test.dart';
import 'package:sealpass/manager/padding.dart';

void main() {
  const size = Size(100, 100);

  group('PaddingManager', () {
    test('account should return expected EdgeInsets', () {
      final result = PaddingManager.account(size);
      const expected = EdgeInsets.only(top: 4, right: 5, left: 5);

      expect(result, expected);
    });

    test('drawerHeader should return expected EdgeInsets', () {
      final result = PaddingManager.drawerHeader(size);
      const expected = EdgeInsets.symmetric(vertical: 1);

      expect(result, expected);
    });

    test('homeSearch should return expected EdgeInsets', () {
      final result = PaddingManager.homeSearch(size);
      const expected = EdgeInsets.only(
        top: 2,
        left: 1,
        right: 1,
      );

      expect(result, expected);
    });

    test('security should return expected EdgeInsets', () {
      final result = PaddingManager.security(size);
      const expected = EdgeInsets.symmetric(horizontal: 5, vertical: 2);

      expect(result, expected);
    });
  });
}
