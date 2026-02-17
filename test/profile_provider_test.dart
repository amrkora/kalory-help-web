import 'package:flutter_test/flutter_test.dart';
import 'package:kalory_help/providers/profile_provider.dart';

void main() {
  group('ProfileProvider', () {
    late ProfileProvider provider;

    setUp(() {
      provider = ProfileProvider();
    });

    group('initial state', () {
      test('profile is null', () {
        expect(provider.profile, isNull);
      });

      test('goals is null', () {
        expect(provider.goals, isNull);
      });

      test('preferences is null', () {
        expect(provider.preferences, isNull);
      });

      test('loading is false', () {
        expect(provider.loading, false);
      });
    });

    group('default goal values when goals is null', () {
      test('calorieGoal defaults to 2000', () {
        expect(provider.calorieGoal, 2000);
      });

      test('proteinGoal defaults to 150', () {
        expect(provider.proteinGoal, 150);
      });

      test('carbsGoal defaults to 250', () {
        expect(provider.carbsGoal, 250);
      });

      test('fatGoal defaults to 65', () {
        expect(provider.fatGoal, 65);
      });

      test('fiberGoal defaults to 28', () {
        expect(provider.fiberGoal, 28);
      });

      test('waterGoal defaults to 8', () {
        expect(provider.waterGoal, 8);
      });
    });

    group('profile helpers return null when profile is null', () {
      test('height is null', () {
        expect(provider.height, isNull);
      });

      test('weight is null', () {
        expect(provider.weight, isNull);
      });

      test('age is null', () {
        expect(provider.age, isNull);
      });

      test('gender is null', () {
        expect(provider.gender, isNull);
      });

      test('activityLevel is null', () {
        expect(provider.activityLevel, isNull);
      });
    });
  });
}
