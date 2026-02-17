import 'package:uuid/uuid.dart';

const _uuid = Uuid();

String _daysAgo(int n) {
  final d = DateTime.now().subtract(Duration(days: n));
  return '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
}

String _today() => _daysAgo(0);

const Map<String, dynamic> seedProfile = {};

const Map<String, dynamic> seedGoals = {
  'calorie_goal': 2150,
  'protein_goal': 161,
  'carbs_goal': 241,
  'fat_goal': 72,
  'fiber_goal': 28,
  'water_goal': 8,
};

const Map<String, dynamic> seedPreferences = {
  'theme_mode': 'system',
  'units': 'metric',
};

Map<String, dynamic> buildSeedWater() {
  return {
    _today(): {
      'id': _uuid.v4(),
      'date': _today(),
      'glasses_consumed': 6,
      'goal': 8,
    },
  };
}

List<Map<String, dynamic>> buildSeedWeightEntries() {
  // Generate 90 days of weight data with a gradual downward trend
  final entries = <Map<String, dynamic>>[];
  const startWeight = 75.0;
  const endWeight = 71.4;
  const totalDays = 90;
  final rng = DateTime.now().millisecondsSinceEpoch;

  for (int i = totalDays - 1; i >= 0; i--) {
    // Skip some days randomly to look realistic (roughly every 3rd day)
    if (i > 7 && (i * 7 + rng) % 3 == 0) continue;

    final progress = 1.0 - (i / totalDays);
    final baseWeight = startWeight - (startWeight - endWeight) * progress;
    // Add small fluctuations
    final fluctuation = ((i * 13 + rng) % 5 - 2) * 0.1;
    final weight = double.parse((baseWeight + fluctuation).toStringAsFixed(1));

    entries.add({
      'id': _uuid.v4(),
      'date': _daysAgo(i),
      'weight': weight,
    });
  }
  return entries;
}

List<Map<String, dynamic>> buildSeedMeals() {
  final meals = <Map<String, dynamic>>[];

  // Today's meals
  final today = _today();

  // Breakfast
  final breakfastId = _uuid.v4();
  meals.add({
    'id': breakfastId,
    'date': today,
    'meal_type': 'Breakfast',
    'time': '08:00',
    'items': [
      {'id': _uuid.v4(), 'name': 'Oatmeal with Berries', 'calories': 210, 'protein': 7, 'carbs': 38, 'fat': 4},
      {'id': _uuid.v4(), 'name': 'Greek Yogurt', 'calories': 120, 'protein': 15, 'carbs': 8, 'fat': 3},
      {'id': _uuid.v4(), 'name': 'Black Coffee', 'calories': 5, 'protein': 0.3, 'carbs': 0, 'fat': 0},
      {'id': _uuid.v4(), 'name': 'Banana', 'calories': 49, 'protein': 0.5, 'carbs': 12, 'fat': 0.2},
    ],
  });

  // Snack
  final snackId = _uuid.v4();
  meals.add({
    'id': snackId,
    'date': today,
    'meal_type': 'Snack',
    'time': '10:30',
    'items': [
      {'id': _uuid.v4(), 'name': 'Apple', 'calories': 52, 'protein': 0.3, 'carbs': 14, 'fat': 0.2},
      {'id': _uuid.v4(), 'name': 'Almonds (10)', 'calories': 64, 'protein': 2.4, 'carbs': 2, 'fat': 5.5},
    ],
  });

  // Lunch
  final lunchId = _uuid.v4();
  meals.add({
    'id': lunchId,
    'date': today,
    'meal_type': 'Lunch',
    'time': '12:30',
    'items': [
      {'id': _uuid.v4(), 'name': 'Grilled Chicken Salad', 'calories': 320, 'protein': 35, 'carbs': 12, 'fat': 14},
      {'id': _uuid.v4(), 'name': 'Whole Wheat Roll', 'calories': 95, 'protein': 3, 'carbs': 18, 'fat': 1.5},
    ],
  });

  // Historical meals (past 90 days)
  final baseTotals = [1820, 2050, 1940, 2210, 1780, 2100, 1950, 2000, 1900, 2150];
  final historicalCalories = <Map<String, int>>[];
  for (int i = 1; i <= 90; i++) {
    historicalCalories.add({
      'daysBack': i,
      'total': baseTotals[i % baseTotals.length],
    });
  }

  for (final day in historicalCalories) {
    final date = _daysAgo(day['daysBack'] as int);
    final total = day['total'] as int;
    final bCal = (total * 0.3).round();
    final lCal = (total * 0.4).round();
    final dCal = total - bCal - lCal;

    meals.add({
      'id': _uuid.v4(),
      'date': date,
      'meal_type': 'Breakfast',
      'time': '08:00',
      'items': [
        {
          'id': _uuid.v4(),
          'name': 'Breakfast',
          'calories': bCal,
          'protein': (bCal * 0.15 / 4).round(),
          'carbs': (bCal * 0.5 / 4).round(),
          'fat': (bCal * 0.35 / 9).round(),
        },
      ],
    });

    meals.add({
      'id': _uuid.v4(),
      'date': date,
      'meal_type': 'Lunch',
      'time': '12:30',
      'items': [
        {
          'id': _uuid.v4(),
          'name': 'Lunch',
          'calories': lCal,
          'protein': (lCal * 0.2 / 4).round(),
          'carbs': (lCal * 0.45 / 4).round(),
          'fat': (lCal * 0.35 / 9).round(),
        },
      ],
    });

    meals.add({
      'id': _uuid.v4(),
      'date': date,
      'meal_type': 'Dinner',
      'time': '19:00',
      'items': [
        {
          'id': _uuid.v4(),
          'name': 'Dinner',
          'calories': dCal,
          'protein': (dCal * 0.25 / 4).round(),
          'carbs': (dCal * 0.4 / 4).round(),
          'fat': (dCal * 0.35 / 9).round(),
        },
      ],
    });
  }

  return meals;
}
