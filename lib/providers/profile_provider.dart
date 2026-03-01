import 'package:flutter/foundation.dart';
import '../services/database_service.dart';

class ProfileProvider extends ChangeNotifier {
  Map<String, dynamic>? _profile;
  Map<String, dynamic>? _goals;
  Map<String, dynamic>? _preferences;
  bool _loading = false;
  String? _error;

  Map<String, dynamic>? get profile => _profile;
  Map<String, dynamic>? get goals => _goals;
  Map<String, dynamic>? get preferences => _preferences;
  bool get loading => _loading;
  String? get error => _error;

  // Profile helpers
  double? get height => (_profile?['height'] as num?)?.toDouble();
  double? get weight => (_profile?['weight'] as num?)?.toDouble();
  int? get age => _profile?['age'] as int?;
  String? get gender => _profile?['gender'] as String?;
  String? get activityLevel => _profile?['activity_level'] as String?;
  String? get dietType => _profile?['diet_type'] as String?;
  bool get halalMode => _profile?['halal_mode'] as bool? ?? true;

  // Goals helpers
  int get calorieGoal => goals?['calorie_goal'] ?? 2000;
  int get proteinGoal => goals?['protein_goal'] ?? 150;
  int get carbsGoal => goals?['carbs_goal'] ?? 250;
  int get fatGoal => goals?['fat_goal'] ?? 65;
  int get fiberGoal => goals?['fiber_goal'] ?? 28;
  int get waterGoal => goals?['water_goal'] ?? 8;

  Future<void> load() async {
    _error = null;
    _loading = true;
    notifyListeners();
    try {
      final box = DatabaseService.profileBox;
      _profile = box.get('profile') != null
          ? Map<String, dynamic>.from(box.get('profile') as Map)
          : null;
      _goals = box.get('goals') != null
          ? Map<String, dynamic>.from(box.get('goals') as Map)
          : null;
      _preferences = box.get('preferences') != null
          ? Map<String, dynamic>.from(box.get('preferences') as Map)
          : null;
    } catch (e) {
      _error = 'Could not load profile';
    }
    _loading = false;
    notifyListeners();
  }

  Future<void> updateGoals(Map<String, dynamic> data) async {
    final current = Map<String, dynamic>.from(_goals ?? {});
    current.addAll(data);
    _goals = current;
    notifyListeners();
    await DatabaseService.profileBox.put('goals', current);
  }

  Future<void> updateProfile(Map<String, dynamic> data) async {
    final current = Map<String, dynamic>.from(_profile ?? {});
    current.addAll(data);
    _profile = current;
    notifyListeners();
    await DatabaseService.profileBox.put('profile', current);
  }

  Future<void> completeOnboarding() async {
    await DatabaseService.profileBox.put('onboarding_completed', true);
  }

  Future<void> updatePreferences(Map<String, dynamic> data) async {
    final current = Map<String, dynamic>.from(_preferences ?? {});
    current.addAll(data);
    _preferences = current;
    notifyListeners();
    await DatabaseService.profileBox.put('preferences', current);
  }
}
