import 'package:flutter/material.dart';
import 'package:test/test.dart';
import 'package:sealpass/manager/size.dart';

void main() {
  const size = Size(100, 100);

  group('SizeManager', () {
    test('fingerprint should return expected value', () {
      final result = SizeManager.fingerprint(size).toInt();
      const expected = 7;

      expect(result, expected);
    });

    test('logo should return expected value', () {
      final result = SizeManager.logo(size);
      const expected = Size(26, 20);

      expect(result, expected);
    });

    test('profile should return expected value', () {
      final result = SizeManager.profile(size).toInt();
      const expected = 9;

      expect(result, expected);
    });
  });
}
