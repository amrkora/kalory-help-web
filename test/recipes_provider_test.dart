import 'package:flutter_test/flutter_test.dart';
import 'package:kalory_help/providers/recipes_provider.dart';

void main() {
  group('RecipesProvider', () {
    late RecipesProvider provider;

    setUp(() {
      provider = RecipesProvider();
    });

    group('initial state', () {
      test('recipes is empty', () {
        expect(provider.recipes, isEmpty);
      });

      test('featured is empty', () {
        expect(provider.featured, isEmpty);
      });

      test('loading is false', () {
        expect(provider.loading, false);
      });
    });
  });
}
