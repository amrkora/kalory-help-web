import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import '../services/database_service.dart';
import '../utils/date_helpers.dart';

const _uuid = Uuid();

class MealsProvider extends ChangeNotifier {
  List<dynamic> _meals = [];
  bool _loading = false;
  String? _error;

  List<dynamic> get meals => _meals;
  bool get loading => _loading;
  String? get error => _error;

  Future<void> loadByDate({String? date}) async {
    _error = null;
    _loading = true;
    notifyListeners();
    try {
      final targetDate = date ?? todayKey();
      final box = DatabaseService.mealsBox;
      _meals = box.values
          .where((m) => m['date'] == targetDate)
          .map((m) {
            final meal = Map<String, dynamic>.from(m as Map);
            meal['items'] = (m['items'] as List?)
                    ?.map((item) => Map<String, dynamic>.from(item as Map))
                    .toList() ??
                [];
            return meal;
          })
          .toList();
    } catch (e) {
      _error = 'Could not load meals';
      _meals = [];
    }
    _loading = false;
    notifyListeners();
  }

  Future<void> createMeal(Map<String, dynamic> data) async {
    final id = _uuid.v4();
    final meal = {
      'id': id,
      'date': data['date'] ?? todayKey(),
      'meal_type': data['mealType'] ?? data['meal_type'] ?? 'Snack',
      'time': data['time'] ?? '12:00',
      'items': <Map<String, dynamic>>[],
    };
    await DatabaseService.mealsBox.put(id, meal);
    await loadByDate(date: meal['date'] as String);
  }

  Future<void> deleteMeal(String id) async {
    await DatabaseService.mealsBox.delete(id);
    await loadByDate();
  }

  Future<void> addFoodItem(String mealId, Map<String, dynamic> data) async {
    final box = DatabaseService.mealsBox;
    final raw = box.get(mealId);
    if (raw == null) return;

    final meal = Map<String, dynamic>.from(raw as Map);
    final items = (meal['items'] as List?)
            ?.map((item) => Map<String, dynamic>.from(item as Map))
            .toList() ??
        [];

    final item = Map<String, dynamic>.from(data);
    item['id'] = _uuid.v4();
    items.add(item);
    meal['items'] = items;

    await box.put(mealId, meal);
    await loadByDate(date: meal['date'] as String);
  }

  Future<void> removeFoodItem(String mealId, String itemId) async {
    final box = DatabaseService.mealsBox;
    final raw = box.get(mealId);
    if (raw == null) return;

    final meal = Map<String, dynamic>.from(raw as Map);
    final items = (meal['items'] as List?)
            ?.map((item) => Map<String, dynamic>.from(item as Map))
            .toList() ??
        [];

    items.removeWhere((item) => item['id'] == itemId);
    meal['items'] = items;

    await box.put(mealId, meal);
    await loadByDate(date: meal['date'] as String);
  }
}
