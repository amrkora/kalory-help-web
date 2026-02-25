import 'package:flutter/foundation.dart';
import '../services/database_service.dart';
import '../utils/date_helpers.dart';

class ProgressProvider extends ChangeNotifier {
  List<dynamic> _calorieData = [];
  List<dynamic> _nutritionData = [];
  List<dynamic> _streaks = [];
  bool _loading = false;
  String? _error;

  List<dynamic> get calorieData => _calorieData;
  List<dynamic> get nutritionData => _nutritionData;
  List<dynamic> get streaks => _streaks;
  bool get loading => _loading;
  String? get error => _error;

  String periodParam(int index) {
    switch (index) {
      case 1:
        return 'month';
      case 2:
        return '3months';
      default:
        return 'week';
    }
  }

  String _dateString(DateTime d) => formatDateKey(d);

  int _periodDays(String period) {
    switch (period) {
      case 'month':
        return 30;
      case '3months':
        return 90;
      default:
        return 7;
    }
  }

  /// Pre-indexes meals by date to avoid O(n²) iteration.
  Map<String, List<Map>> _indexMealsByDate() {
    final index = <String, List<Map>>{};
    for (final raw in DatabaseService.mealsBox.values) {
      final meal = raw as Map;
      final date = meal['date'] as String?;
      if (date != null) {
        (index[date] ??= []).add(meal);
      }
    }
    return index;
  }

  Future<void> load({String period = 'week'}) async {
    _error = null;
    _loading = true;
    notifyListeners();
    try {
      final days = _periodDays(period);
      final now = DateTime.now();
      final mealIndex = _indexMealsByDate();

      // Calorie data
      _calorieData = _buildCalorieData(days, now, mealIndex);

      // Nutrition data
      _nutritionData = _buildNutritionData(days, now, mealIndex);

      // Streaks
      _streaks = _buildStreaks(now, mealIndex);
    } catch (e) {
      _error = 'Could not load progress data';
    }
    _loading = false;
    notifyListeners();
  }

  List<Map<String, dynamic>> _buildCalorieData(int days, DateTime now, Map<String, List<Map>> mealIndex) {
    final goalsRaw = DatabaseService.profileBox.get('goals');
    final calorieGoal = goalsRaw != null
        ? ((goalsRaw as Map)['calorie_goal'] as num?)?.toInt() ?? 2000
        : 2000;

    final result = <Map<String, dynamic>>[];
    for (int i = days - 1; i >= 0; i--) {
      final date = _dateString(now.subtract(Duration(days: i)));
      int total = 0;
      for (final meal in mealIndex[date] ?? []) {
        final items = (meal['items'] as List?) ?? [];
        for (final item in items) {
          total += ((item as Map)['calories'] as num?)?.toInt() ?? 0;
        }
      }
      result.add({
        'date': date,
        'total_calories': total,
        'goal': calorieGoal,
      });
    }
    return result;
  }

  List<Map<String, dynamic>> _buildNutritionData(int days, DateTime now, Map<String, List<Map>> mealIndex) {
    final result = <Map<String, dynamic>>[];
    for (int i = days - 1; i >= 0; i--) {
      final date = _dateString(now.subtract(Duration(days: i)));
      int protein = 0;
      int carbs = 0;
      int fat = 0;
      for (final meal in mealIndex[date] ?? []) {
        final items = (meal['items'] as List?) ?? [];
        for (final item in items) {
          protein += ((item as Map)['protein'] as num?)?.toInt() ?? 0;
          carbs += (item['carbs'] as num?)?.toInt() ?? 0;
          fat += (item['fat'] as num?)?.toInt() ?? 0;
        }
      }
      result.add({
        'date': date,
        'total_protein': protein,
        'total_carbs': carbs,
        'total_fat': fat,
      });
    }
    return result;
  }

  List<Map<String, dynamic>> _buildStreaks(DateTime now, Map<String, List<Map>> mealIndex) {
    // Compute streaks from historical data
    final waterGoal = (() {
      final goalsRaw = DatabaseService.profileBox.get('goals');
      return goalsRaw != null
          ? ((goalsRaw as Map)['water_goal'] as num?)?.toInt() ?? 8
          : 8;
    })();

    // Logging streak: consecutive days with at least one meal
    int loggingStreak = 0;
    for (int i = 0; i < 365; i++) {
      final date = _dateString(now.subtract(Duration(days: i)));
      if (mealIndex.containsKey(date)) {
        loggingStreak++;
      } else {
        break;
      }
    }

    // Water streak: consecutive days meeting water goal
    int waterStreak = 0;
    for (int i = 0; i < 365; i++) {
      final date = _dateString(now.subtract(Duration(days: i)));
      final raw = DatabaseService.waterBox.get(date);
      if (raw != null &&
          ((raw as Map)['glasses_consumed'] as num?)?.toInt() != null &&
          ((raw)['glasses_consumed'] as num).toInt() >= waterGoal) {
        waterStreak++;
      } else {
        break;
      }
    }

    return [
      {
        'streak_type': 'logging',
        'current_count': loggingStreak,
      },
      {
        'streak_type': 'water',
        'current_count': waterStreak,
      },
    ];
  }
}
