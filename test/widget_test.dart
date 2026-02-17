import 'package:flutter_test/flutter_test.dart';

import 'package:kalory_help/utils/nutrition_calculator.dart';

void main() {
  test('NutritionCalculator basic sanity check', () {
    final goals = NutritionCalculator.calculateAllGoals(
        80, 180, '26-35', 'male', 'moderate');
    expect(goals['calorie_goal'], 2759);
    expect(goals['water_goal'], 8);
    expect(goals['fiber_goal'], 28);
  });
}
