import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kalory_help/theme/app_theme.dart';

void main() {
  group('AppColors', () {
    test('primary is correct hex value', () {
      expect(AppColors.primary, const Color(0xFF4BA3C7));
    });

    test('secondary is correct hex value', () {
      expect(AppColors.secondary, const Color(0xFFE8833A));
    });

    test('accent is correct hex value', () {
      expect(AppColors.accent, const Color(0xFFE85D75));
    });

    test('success is correct hex value', () {
      expect(AppColors.success, const Color(0xFF5AAF6E));
    });

    test('warning is correct hex value', () {
      expect(AppColors.warning, const Color(0xFFF5C342));
    });

    test('error is correct hex value', () {
      expect(AppColors.error, const Color(0xFFE05252));
    });

    test('primaryLight is correct hex value', () {
      expect(AppColors.primaryLight, const Color(0xFF7BC8E2));
    });

    test('primaryDark is correct hex value', () {
      expect(AppColors.primaryDark, const Color(0xFF2E7D9E));
    });
  });

  group('Breakpoints', () {
    test('mobile is 600', () {
      expect(Breakpoints.mobile, 600);
    });

    test('tablet is 900', () {
      expect(Breakpoints.tablet, 900);
    });

    test('desktop is 1200', () {
      expect(Breakpoints.desktop, 1200);
    });

    test('wide is 1536', () {
      expect(Breakpoints.wide, 1536);
    });
  });
}
