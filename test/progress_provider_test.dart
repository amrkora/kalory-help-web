import 'package:flutter_test/flutter_test.dart';
import 'package:kalory_help/providers/progress_provider.dart';

void main() {
  group('ProgressProvider', () {
    late ProgressProvider provider;

    setUp(() {
      provider = ProgressProvider();
    });

    group('initial state', () {
      test('loading is false', () {
        expect(provider.loading, false);
      });

      test('weightData is null', () {
        expect(provider.weightData, isNull);
      });

      test('calorieData is empty', () {
        expect(provider.calorieData, isEmpty);
      });

      test('nutritionData is empty', () {
        expect(provider.nutritionData, isEmpty);
      });

      test('streaks is empty', () {
        expect(provider.streaks, isEmpty);
      });

      test('weightEntries is empty', () {
        expect(provider.weightEntries, isEmpty);
      });

      test('weightStats is null', () {
        expect(provider.weightStats, isNull);
      });
    });

    group('getter defaults', () {
      test('currentWeight is null', () {
        expect(provider.currentWeight, isNull);
      });

      test('weightChange is null', () {
        expect(provider.weightChange, isNull);
      });

      test('bmi is null', () {
        expect(provider.bmi, isNull);
      });
    });

    group('periodParam', () {
      test('index 0 returns week', () {
        expect(provider.periodParam(0), 'week');
      });

      test('index 1 returns month', () {
        expect(provider.periodParam(1), 'month');
      });

      test('index 2 returns 3months', () {
        expect(provider.periodParam(2), '3months');
      });

      test('unknown index defaults to week', () {
        expect(provider.periodParam(99), 'week');
        expect(provider.periodParam(-1), 'week');
      });
    });
  });
}
