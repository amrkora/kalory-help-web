import 'package:flutter_test/flutter_test.dart';
import 'package:kalory_help/data/seed_data.dart';

void main() {
  group('Seed Data', () {
    group('seedProfile', () {
      test('contains required fields', () {
        expect(seedProfile.containsKey('height'), true);
        expect(seedProfile.containsKey('weight'), true);
        expect(seedProfile.containsKey('age'), true);
        expect(seedProfile.containsKey('gender'), true);
        expect(seedProfile.containsKey('activity_level'), true);
      });

      test('has valid gender value', () {
        expect(['male', 'female'], contains(seedProfile['gender']));
      });

      test('has positive numeric values', () {
        expect(seedProfile['height'] as int, greaterThan(0));
        expect(seedProfile['weight'] as double, greaterThan(0));
        expect(seedProfile['age'] as int, greaterThan(0));
      });
    });

    group('seedGoals', () {
      test('contains required fields', () {
        expect(seedGoals.containsKey('calorie_goal'), true);
        expect(seedGoals.containsKey('protein_goal'), true);
        expect(seedGoals.containsKey('carbs_goal'), true);
        expect(seedGoals.containsKey('fat_goal'), true);
        expect(seedGoals.containsKey('fiber_goal'), true);
        expect(seedGoals.containsKey('water_goal'), true);
      });

      test('all values are positive', () {
        for (final entry in seedGoals.entries) {
          expect(entry.value as int, greaterThan(0),
              reason: '${entry.key} should be positive');
        }
      });

      test('fiber goal is 28g FDA daily value', () {
        expect(seedGoals['fiber_goal'], 28);
      });

      test('water goal is 8 glasses', () {
        expect(seedGoals['water_goal'], 8);
      });
    });

    group('seedPreferences', () {
      test('contains theme_mode', () {
        expect(seedPreferences.containsKey('theme_mode'), true);
      });

      test('contains units', () {
        expect(seedPreferences['units'], 'metric');
      });
    });

    group('buildSeedMeals', () {
      test('returns non-empty list', () {
        final meals = buildSeedMeals();
        expect(meals, isNotEmpty);
      });

      test('each meal has required fields', () {
        final meals = buildSeedMeals();
        for (final meal in meals) {
          expect(meal.containsKey('id'), true);
          expect(meal.containsKey('date'), true);
          expect(meal.containsKey('meal_type'), true);
          expect(meal.containsKey('items'), true);
          expect(meal['items'], isA<List>());
        }
      });

      test('includes today\'s meals', () {
        final meals = buildSeedMeals();
        final now = DateTime.now();
        final today =
            '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
        final todayMeals = meals.where((m) => m['date'] == today);
        expect(todayMeals, isNotEmpty);
      });
    });

    group('buildSeedWater', () {
      test('returns map with today\'s entry', () {
        final water = buildSeedWater();
        expect(water, isNotEmpty);
        expect(water.values.first, isA<Map>());
      });

      test('water entry has required fields', () {
        final water = buildSeedWater();
        final entry = water.values.first as Map;
        expect(entry.containsKey('id'), true);
        expect(entry.containsKey('date'), true);
        expect(entry.containsKey('glasses_consumed'), true);
        expect(entry.containsKey('goal'), true);
      });
    });

    group('buildSeedWeightEntries', () {
      test('returns 7 days of weight entries', () {
        final weights = buildSeedWeightEntries();
        expect(weights.length, 7);
      });

      test('each entry has required fields', () {
        final weights = buildSeedWeightEntries();
        for (final w in weights) {
          expect(w.containsKey('id'), true);
          expect(w.containsKey('date'), true);
          expect(w.containsKey('weight'), true);
          expect(w['weight'] as double, greaterThan(0));
        }
      });

      test('weights are in descending order (newest last)', () {
        final weights = buildSeedWeightEntries();
        // Last entry should be today (most recent)
        final now = DateTime.now();
        final today =
            '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
        expect(weights.last['date'], today);
      });
    });
  });
}
