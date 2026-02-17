import 'package:flutter_test/flutter_test.dart';
import 'package:kalory_help/providers/meals_provider.dart';

void main() {
  group('MealsProvider', () {
    late MealsProvider provider;

    setUp(() {
      provider = MealsProvider();
    });

    group('initial state', () {
      test('meals is empty', () {
        expect(provider.meals, isEmpty);
      });

      test('loading is false', () {
        expect(provider.loading, false);
      });
    });
  });
}
