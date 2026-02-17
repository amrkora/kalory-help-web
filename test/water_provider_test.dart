import 'package:flutter_test/flutter_test.dart';
import 'package:kalory_help/providers/water_provider.dart';

void main() {
  group('WaterProvider', () {
    late WaterProvider provider;

    setUp(() {
      provider = WaterProvider();
    });

    group('initial state', () {
      test('water is null', () {
        expect(provider.water, isNull);
      });

      test('loading is false', () {
        expect(provider.loading, false);
      });

      test('id is null', () {
        expect(provider.id, isNull);
      });
    });

    group('default values when water is null', () {
      test('consumed defaults to 0', () {
        expect(provider.consumed, 0);
      });

      test('goal defaults to 8', () {
        expect(provider.goal, 8);
      });
    });

    group('setTestData', () {
      test('correctly sets consumed and goal', () {
        provider.setTestData(consumed: 5, goal: 10);

        expect(provider.water, isNotNull);
        expect(provider.consumed, 5);
        expect(provider.goal, 10);
      });

      test('works with zero values', () {
        provider.setTestData(consumed: 0, goal: 8);

        expect(provider.consumed, 0);
        expect(provider.goal, 8);
      });

      test('allows goal greater than default', () {
        provider.setTestData(consumed: 3, goal: 12);

        expect(provider.consumed, 3);
        expect(provider.goal, 12);
      });
    });
  });
}
