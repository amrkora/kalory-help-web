import 'package:flutter_test/flutter_test.dart';
import 'package:kalory_help/providers/summary_provider.dart';

void main() {
  group('SummaryProvider', () {
    late SummaryProvider provider;

    setUp(() {
      provider = SummaryProvider();
    });

    group('initial state', () {
      test('summary is null', () {
        expect(provider.summary, isNull);
      });

      test('loading is false', () {
        expect(provider.loading, false);
      });
    });

    group('default values when summary is null', () {
      test('caloriesConsumed defaults to 0', () {
        expect(provider.caloriesConsumed, 0);
      });

      test('caloriesGoal defaults to 2000', () {
        expect(provider.caloriesGoal, 2000);
      });

      test('proteinConsumed defaults to 0', () {
        expect(provider.proteinConsumed, 0);
      });

      test('proteinGoal defaults to 150', () {
        expect(provider.proteinGoal, 150);
      });

      test('carbsConsumed defaults to 0', () {
        expect(provider.carbsConsumed, 0);
      });

      test('carbsGoal defaults to 250', () {
        expect(provider.carbsGoal, 250);
      });

      test('fatConsumed defaults to 0', () {
        expect(provider.fatConsumed, 0);
      });

      test('fatGoal defaults to 65', () {
        expect(provider.fatGoal, 65);
      });

      test('waterConsumed defaults to 0', () {
        expect(provider.waterConsumed, 0);
      });

      test('waterGoal defaults to 8', () {
        expect(provider.waterGoal, 8);
      });

      test('mealsCount defaults to 0', () {
        expect(provider.mealsCount, 0);
      });
    });

    group('caloriesRemaining', () {
      test('equals goal minus consumed when null', () {
        expect(provider.caloriesRemaining, 2000);
      });

      test('calculates correctly after setTestData', () {
        provider.setTestData(
          caloriesConsumed: 800,
          caloriesGoal: 2000,
          proteinConsumed: 50,
          proteinGoal: 150,
          carbsConsumed: 100,
          carbsGoal: 250,
          fatConsumed: 30,
          fatGoal: 65,
        );
        expect(provider.caloriesRemaining, 1200);
      });

      test('can be negative when over goal', () {
        provider.setTestData(
          caloriesConsumed: 2500,
          caloriesGoal: 2000,
          proteinConsumed: 0,
          proteinGoal: 150,
          carbsConsumed: 0,
          carbsGoal: 250,
          fatConsumed: 0,
          fatGoal: 65,
        );
        expect(provider.caloriesRemaining, -500);
      });
    });

    group('setTestData', () {
      test('populates summary map', () {
        provider.setTestData(
          caloriesConsumed: 1500,
          caloriesGoal: 2200,
          proteinConsumed: 120,
          proteinGoal: 160,
          carbsConsumed: 200,
          carbsGoal: 300,
          fatConsumed: 50,
          fatGoal: 70,
        );

        expect(provider.summary, isNotNull);
        expect(provider.caloriesConsumed, 1500);
        expect(provider.caloriesGoal, 2200);
        expect(provider.proteinConsumed, 120);
        expect(provider.proteinGoal, 160);
        expect(provider.carbsConsumed, 200);
        expect(provider.carbsGoal, 300);
        expect(provider.fatConsumed, 50);
        expect(provider.fatGoal, 70);
      });

      test('sets water to defaults', () {
        provider.setTestData(
          caloriesConsumed: 0,
          caloriesGoal: 2000,
          proteinConsumed: 0,
          proteinGoal: 150,
          carbsConsumed: 0,
          carbsGoal: 250,
          fatConsumed: 0,
          fatGoal: 65,
        );
        expect(provider.waterConsumed, 0);
        expect(provider.waterGoal, 8);
      });

      test('sets mealsCount to 0', () {
        provider.setTestData(
          caloriesConsumed: 0,
          caloriesGoal: 2000,
          proteinConsumed: 0,
          proteinGoal: 150,
          carbsConsumed: 0,
          carbsGoal: 250,
          fatConsumed: 0,
          fatGoal: 65,
        );
        expect(provider.mealsCount, 0);
      });
    });
  });
}
