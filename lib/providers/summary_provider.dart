import 'package:flutter/foundation.dart';
import '../services/database_service.dart';
import '../utils/date_helpers.dart';

class SummaryProvider extends ChangeNotifier {
  Map<String, dynamic>? _summary;
  bool _loading = false;
  String? _error;

  Map<String, dynamic>? get summary => _summary;
  bool get loading => _loading;
  String? get error => _error;

  int get caloriesConsumed => _summary?['calories']?['consumed'] ?? 0;
  int get caloriesGoal => _summary?['calories']?['goal'] ?? 2000;
  int get caloriesRemaining => caloriesGoal - caloriesConsumed;

  int get proteinConsumed => _summary?['protein']?['consumed'] ?? 0;
  int get proteinGoal => _summary?['protein']?['goal'] ?? 150;

  int get carbsConsumed => _summary?['carbs']?['consumed'] ?? 0;
  int get carbsGoal => _summary?['carbs']?['goal'] ?? 250;

  int get fatConsumed => _summary?['fat']?['consumed'] ?? 0;
  int get fatGoal => _summary?['fat']?['goal'] ?? 65;

  int get waterConsumed => _summary?['water']?['consumed'] ?? 0;
  int get waterGoal => _summary?['water']?['goal'] ?? 8;

  int get mealsCount => _summary?['meals_count'] ?? 0;

  /// Inject data for unit testing without Hive.
  void setTestData({
    required int caloriesConsumed,
    required int caloriesGoal,
    required int proteinConsumed,
    required int proteinGoal,
    required int carbsConsumed,
    required int carbsGoal,
    required int fatConsumed,
    required int fatGoal,
  }) {
    _summary = {
      'calories': {'consumed': caloriesConsumed, 'goal': caloriesGoal},
      'protein': {'consumed': proteinConsumed, 'goal': proteinGoal},
      'carbs': {'consumed': carbsConsumed, 'goal': carbsGoal},
      'fat': {'consumed': fatConsumed, 'goal': fatGoal},
      'water': {'consumed': 0, 'goal': 8},
      'meals_count': 0,
    };
  }

  String _dateString(DateTime d) => formatDateKey(d);

  Future<void> load({String? date}) async {
    _error = null;
    _loading = true;
    notifyListeners();
    try {
      final targetDate = date ?? _dateString(DateTime.now());

      // Read goals from profile box
      final goalsRaw = DatabaseService.profileBox.get('goals');
      final goals = goalsRaw != null
          ? Map<String, dynamic>.from(goalsRaw as Map)
          : <String, dynamic>{};

      // Sum nutrition from meals for the target date
      int totalCalories = 0;
      int totalProtein = 0;
      int totalCarbs = 0;
      int totalFat = 0;
      int mealCount = 0;

      for (final raw in DatabaseService.mealsBox.values) {
        final meal = raw as Map;
        if (meal['date'] != targetDate) continue;
        mealCount++;
        final items = (meal['items'] as List?) ?? [];
        for (final item in items) {
          totalCalories += ((item as Map)['calories'] as num?)?.toInt() ?? 0;
          totalProtein += (item['protein'] as num?)?.toInt() ?? 0;
          totalCarbs += (item['carbs'] as num?)?.toInt() ?? 0;
          totalFat += (item['fat'] as num?)?.toInt() ?? 0;
        }
      }

      // Read water for the target date
      final waterRaw = DatabaseService.waterBox.get(targetDate);
      final waterConsumed = waterRaw != null
          ? ((waterRaw as Map)['glasses_consumed'] as num?)?.toInt() ?? 0
          : 0;

      _summary = {
        'calories': {
          'consumed': totalCalories,
          'goal': goals['calorie_goal'] ?? 2000,
        },
        'protein': {
          'consumed': totalProtein,
          'goal': goals['protein_goal'] ?? 150,
        },
        'carbs': {
          'consumed': totalCarbs,
          'goal': goals['carbs_goal'] ?? 250,
        },
        'fat': {
          'consumed': totalFat,
          'goal': goals['fat_goal'] ?? 65,
        },
        'water': {
          'consumed': waterConsumed,
          'goal': goals['water_goal'] ?? 8,
        },
        'meals_count': mealCount,
      };
    } catch (e) {
      _error = 'Could not load daily summary';
    }
    _loading = false;
    notifyListeners();
  }
}
