class NutritionCalculator {
  NutritionCalculator._();

  static int ageRangeToMidpoint(String ageRange) {
    switch (ageRange) {
      case '18-25':
        return 22;
      case '26-35':
        return 30;
      case '36-45':
        return 40;
      case '46-55':
        return 50;
      case '56-65':
        return 60;
      case '65+':
        return 70;
      default:
        return 30;
    }
  }

  /// Mifflin-St Jeor BMR (1990)
  static double calculateBMR(
      double weightKg, double heightCm, int age, String gender) {
    final base = (10 * weightKg) + (6.25 * heightCm) - (5 * age);
    return gender == 'male' ? base + 5 : base - 161;
  }

  static double activityMultiplier(String activityLevel) {
    switch (activityLevel) {
      case 'sedentary':
        return 1.2;
      case 'light':
        return 1.375;
      case 'moderate':
        return 1.55;
      case 'active':
        return 1.725;
      case 'very_active':
        return 1.9;
      default:
        return 1.55;
    }
  }

  static int calculateTDEE(
      double weightKg, double heightCm, int age, String gender,
      String activityLevel) {
    final bmr = calculateBMR(weightKg, heightCm, age, gender);
    return (bmr * activityMultiplier(activityLevel)).round();
  }

  static Map<String, double> dietMacroRatios(String? dietType) {
    switch (dietType) {
      case 'vegetarian':
        return {'protein': 0.25, 'carbs': 0.50, 'fat': 0.25};
      case 'vegan':
        return {'protein': 0.20, 'carbs': 0.55, 'fat': 0.25};
      case 'pescatarian':
      case 'omnivore':
      default:
        return {'protein': 0.30, 'carbs': 0.45, 'fat': 0.25};
    }
  }

  static Map<String, int> calculateMacros(int calorieGoal, {String? dietType}) {
    final ratios = dietMacroRatios(dietType);
    return {
      'protein': (calorieGoal * ratios['protein']! / 4).round(),
      'carbs': (calorieGoal * ratios['carbs']! / 4).round(),
      'fat': (calorieGoal * ratios['fat']! / 9).round(),
      'fiber': 28,
    };
  }

  /// Returns a complete goals map ready for ProfileProvider.updateGoals()
  static Map<String, int> calculateAllGoals(
      double weightKg, double heightCm, String ageRange, String gender,
      String activityLevel, {String? dietType}) {
    final age = ageRangeToMidpoint(ageRange);
    final tdee = calculateTDEE(weightKg, heightCm, age, gender, activityLevel);
    final macros = calculateMacros(tdee, dietType: dietType);
    return {
      'calorie_goal': tdee,
      'protein_goal': macros['protein']!,
      'carbs_goal': macros['carbs']!,
      'fat_goal': macros['fat']!,
      'fiber_goal': macros['fiber']!,
      'water_goal': 8,
    };
  }
}
