import 'package:flutter_test/flutter_test.dart';
import 'package:kalory_help/data/seed_recipes.dart';

void main() {
  group('seedRecipes', () {
    test('list is not empty', () {
      expect(seedRecipes, isNotEmpty);
    });

    test('each recipe has required fields', () {
      for (final recipe in seedRecipes) {
        expect(recipe.containsKey('name'), true,
            reason: 'Missing name in $recipe');
        expect(recipe.containsKey('description'), true,
            reason: 'Missing description');
        expect(recipe.containsKey('calories'), true,
            reason: 'Missing calories in ${recipe['name']}');
        expect(recipe.containsKey('protein'), true,
            reason: 'Missing protein in ${recipe['name']}');
        expect(recipe.containsKey('carbs'), true,
            reason: 'Missing carbs in ${recipe['name']}');
        expect(recipe.containsKey('fat'), true,
            reason: 'Missing fat in ${recipe['name']}');
        expect(recipe.containsKey('category'), true,
            reason: 'Missing category in ${recipe['name']}');
        expect(recipe.containsKey('prep_time'), true,
            reason: 'Missing prep_time in ${recipe['name']}');
        expect(recipe.containsKey('difficulty'), true,
            reason: 'Missing difficulty in ${recipe['name']}');
        expect(recipe.containsKey('servings'), true,
            reason: 'Missing servings in ${recipe['name']}');
        expect(recipe.containsKey('steps'), true,
            reason: 'Missing steps in ${recipe['name']}');
      }
    });

    test('all nutritional values are positive', () {
      for (final recipe in seedRecipes) {
        final name = recipe['name'];
        expect(recipe['calories'] as int, greaterThan(0),
            reason: '$name: calories should be positive');
        expect(recipe['protein'] as int, greaterThanOrEqualTo(0),
            reason: '$name: protein should be non-negative');
        expect(recipe['carbs'] as int, greaterThanOrEqualTo(0),
            reason: '$name: carbs should be non-negative');
        expect(recipe['fat'] as int, greaterThanOrEqualTo(0),
            reason: '$name: fat should be non-negative');
      }
    });

    test('categories are valid strings', () {
      const validCategories = {
        'Breakfast',
        'Lunch',
        'Dinner',
        'Snack',
        'Dessert',
      };
      for (final recipe in seedRecipes) {
        expect(validCategories.contains(recipe['category']), true,
            reason:
                '${recipe['name']} has invalid category: ${recipe['category']}');
      }
    });

    test('featured recipes exist', () {
      final featured =
          seedRecipes.where((r) => r['featured'] == 1).toList();
      expect(featured, isNotEmpty, reason: 'Should have at least one featured recipe');
    });

    test('each recipe has non-empty steps', () {
      for (final recipe in seedRecipes) {
        final steps = recipe['steps'] as List;
        expect(steps, isNotEmpty,
            reason: '${recipe['name']} should have at least one step');
      }
    });

    test('each recipe name is a non-empty string', () {
      for (final recipe in seedRecipes) {
        expect(recipe['name'], isA<String>());
        expect((recipe['name'] as String).isNotEmpty, true);
      }
    });

    test('prep_time is positive for all recipes', () {
      for (final recipe in seedRecipes) {
        expect(recipe['prep_time'] as int, greaterThan(0),
            reason: '${recipe['name']}: prep_time should be positive');
      }
    });

    test('servings is positive for all recipes', () {
      for (final recipe in seedRecipes) {
        expect(recipe['servings'] as int, greaterThan(0),
            reason: '${recipe['name']}: servings should be positive');
      }
    });
  });
}
