import 'package:flutter_test/flutter_test.dart';
import 'package:kalory_help/utils/nutrition_calculator.dart';

void main() {
  group('NutritionCalculator', () {
    group('ageRangeToMidpoint', () {
      test('returns correct midpoint for each range', () {
        expect(NutritionCalculator.ageRangeToMidpoint('18-25'), 22);
        expect(NutritionCalculator.ageRangeToMidpoint('26-35'), 30);
        expect(NutritionCalculator.ageRangeToMidpoint('36-45'), 40);
        expect(NutritionCalculator.ageRangeToMidpoint('46-55'), 50);
        expect(NutritionCalculator.ageRangeToMidpoint('56-65'), 60);
        expect(NutritionCalculator.ageRangeToMidpoint('65+'), 70);
      });

      test('returns 30 for unknown range', () {
        expect(NutritionCalculator.ageRangeToMidpoint('unknown'), 30);
      });
    });

    group('calculateBMR', () {
      test('male BMR: (10*weight) + (6.25*height) - (5*age) + 5', () {
        // Male, 80kg, 180cm, age 30
        // 10*80 + 6.25*180 - 5*30 + 5 = 800 + 1125 - 150 + 5 = 1780
        final bmr = NutritionCalculator.calculateBMR(80, 180, 30, 'male');
        expect(bmr, 1780.0);
      });

      test('female BMR: (10*weight) + (6.25*height) - (5*age) - 161', () {
        // Female, 60kg, 165cm, age 25
        // 10*60 + 6.25*165 - 5*25 - 161 = 600 + 1031.25 - 125 - 161 = 1345.25
        final bmr = NutritionCalculator.calculateBMR(60, 165, 25, 'female');
        expect(bmr, 1345.25);
      });

      test('male BMR is higher than female for same stats', () {
        final maleBMR = NutritionCalculator.calculateBMR(70, 170, 30, 'male');
        final femaleBMR =
            NutritionCalculator.calculateBMR(70, 170, 30, 'female');
        expect(maleBMR, greaterThan(femaleBMR));
        // Difference should be 5 - (-161) = 166
        expect(maleBMR - femaleBMR, 166);
      });

      test('BMR decreases with age', () {
        final young = NutritionCalculator.calculateBMR(70, 170, 20, 'male');
        final old = NutritionCalculator.calculateBMR(70, 170, 50, 'male');
        expect(young, greaterThan(old));
        // Difference: 5 * (50 - 20) = 150
        expect(young - old, 150);
      });

      test('BMR increases with weight', () {
        final light = NutritionCalculator.calculateBMR(50, 170, 30, 'male');
        final heavy = NutritionCalculator.calculateBMR(100, 170, 30, 'male');
        expect(heavy, greaterThan(light));
      });

      test('BMR increases with height', () {
        final short = NutritionCalculator.calculateBMR(70, 150, 30, 'male');
        final tall = NutritionCalculator.calculateBMR(70, 190, 30, 'male');
        expect(tall, greaterThan(short));
      });
    });

    group('activityMultiplier', () {
      test('returns correct multipliers', () {
        expect(NutritionCalculator.activityMultiplier('sedentary'), 1.2);
        expect(NutritionCalculator.activityMultiplier('light'), 1.375);
        expect(NutritionCalculator.activityMultiplier('moderate'), 1.55);
        expect(NutritionCalculator.activityMultiplier('active'), 1.725);
        expect(NutritionCalculator.activityMultiplier('very_active'), 1.9);
      });

      test('defaults to moderate (1.55) for unknown level', () {
        expect(NutritionCalculator.activityMultiplier('unknown'), 1.55);
      });

      test('multipliers are in ascending order', () {
        final levels = ['sedentary', 'light', 'moderate', 'active', 'very_active'];
        for (var i = 0; i < levels.length - 1; i++) {
          expect(
            NutritionCalculator.activityMultiplier(levels[i]),
            lessThan(NutritionCalculator.activityMultiplier(levels[i + 1])),
          );
        }
      });
    });

    group('calculateTDEE', () {
      test('TDEE = BMR * activity multiplier (rounded)', () {
        // Male, 80kg, 180cm, age 30, moderate
        // BMR = 1780, multiplier = 1.55, TDEE = 1780 * 1.55 = 2759
        final tdee = NutritionCalculator.calculateTDEE(
            80, 180, 30, 'male', 'moderate');
        expect(tdee, 2759);
      });

      test('sedentary TDEE is less than active TDEE', () {
        final sedentary = NutritionCalculator.calculateTDEE(
            70, 170, 30, 'male', 'sedentary');
        final active = NutritionCalculator.calculateTDEE(
            70, 170, 30, 'male', 'active');
        expect(sedentary, lessThan(active));
      });

      test('TDEE for female is less than male (same stats)', () {
        final male = NutritionCalculator.calculateTDEE(
            70, 170, 30, 'male', 'moderate');
        final female = NutritionCalculator.calculateTDEE(
            70, 170, 30, 'female', 'moderate');
        expect(female, lessThan(male));
      });
    });

    group('calculateMacros', () {
      test('protein is 30% of calories / 4 cal per gram', () {
        final macros = NutritionCalculator.calculateMacros(2000);
        // 2000 * 0.30 / 4 = 150
        expect(macros['protein'], 150);
      });

      test('carbs is 45% of calories / 4 cal per gram', () {
        final macros = NutritionCalculator.calculateMacros(2000);
        // 2000 * 0.45 / 4 = 225
        expect(macros['carbs'], 225);
      });

      test('fat is 25% of calories / 9 cal per gram', () {
        final macros = NutritionCalculator.calculateMacros(2000);
        // 2000 * 0.25 / 9 = 55.55 -> 56
        expect(macros['fat'], 56);
      });

      test('fiber is always 28g', () {
        final macros = NutritionCalculator.calculateMacros(2000);
        expect(macros['fiber'], 28);

        final macros2 = NutritionCalculator.calculateMacros(3000);
        expect(macros2['fiber'], 28);
      });

      test('macros scale with calorie goal', () {
        final low = NutritionCalculator.calculateMacros(1500);
        final high = NutritionCalculator.calculateMacros(3000);
        expect(high['protein']!, greaterThan(low['protein']!));
        expect(high['carbs']!, greaterThan(low['carbs']!));
        expect(high['fat']!, greaterThan(low['fat']!));
      });
    });

    group('calculateAllGoals', () {
      test('returns complete goals map', () {
        final goals = NutritionCalculator.calculateAllGoals(
            80, 180, '26-35', 'male', 'moderate');

        expect(goals.containsKey('calorie_goal'), true);
        expect(goals.containsKey('protein_goal'), true);
        expect(goals.containsKey('carbs_goal'), true);
        expect(goals.containsKey('fat_goal'), true);
        expect(goals.containsKey('fiber_goal'), true);
        expect(goals.containsKey('water_goal'), true);
      });

      test('water goal is always 8', () {
        final goals = NutritionCalculator.calculateAllGoals(
            80, 180, '26-35', 'male', 'moderate');
        expect(goals['water_goal'], 8);
      });

      test('fiber goal is always 28', () {
        final goals = NutritionCalculator.calculateAllGoals(
            80, 180, '26-35', 'male', 'moderate');
        expect(goals['fiber_goal'], 28);
      });

      test('verification: Male 80kg 180cm 26-35 moderate → TDEE 2759', () {
        final goals = NutritionCalculator.calculateAllGoals(
            80, 180, '26-35', 'male', 'moderate');
        expect(goals['calorie_goal'], 2759);
      });

      test('macros are derived from calorie goal', () {
        final goals = NutritionCalculator.calculateAllGoals(
            80, 180, '26-35', 'male', 'moderate');
        final cal = goals['calorie_goal']!;

        // Verify macros match calculateMacros(cal)
        final macros = NutritionCalculator.calculateMacros(cal);
        expect(goals['protein_goal'], macros['protein']);
        expect(goals['carbs_goal'], macros['carbs']);
        expect(goals['fat_goal'], macros['fat']);
      });

      test('all goals are positive integers', () {
        final goals = NutritionCalculator.calculateAllGoals(
            50, 150, '18-25', 'female', 'sedentary');
        for (final entry in goals.entries) {
          expect(entry.value, isPositive, reason: '${entry.key} should be positive');
          expect(entry.value, isA<int>());
        }
      });

      test('different inputs produce different results', () {
        final goals1 = NutritionCalculator.calculateAllGoals(
            60, 160, '18-25', 'female', 'sedentary');
        final goals2 = NutritionCalculator.calculateAllGoals(
            100, 190, '46-55', 'male', 'very_active');
        expect(goals2['calorie_goal']!, greaterThan(goals1['calorie_goal']!));
      });
    });
  });
}
