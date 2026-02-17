import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kalory_help/utils/theme_provider.dart';

void main() {
  group('ThemeProvider', () {
    test('themeMode is always system', () {
      final provider = ThemeProvider();
      expect(provider.themeMode, ThemeMode.system);
    });
  });
}
