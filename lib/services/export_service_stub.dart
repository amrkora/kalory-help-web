import 'dart:convert';
import 'database_service.dart';

Map<String, dynamic> buildExportData() {
  final profile = DatabaseService.profileBox.get('profile');
  final goals = DatabaseService.profileBox.get('goals');

  final meals = <Map<String, dynamic>>[];
  for (final key in DatabaseService.mealsBox.keys) {
    final val = DatabaseService.mealsBox.get(key);
    if (val != null) {
      meals.add(Map<String, dynamic>.from(val as Map));
    }
  }

  final water = <Map<String, dynamic>>[];
  for (final key in DatabaseService.waterBox.keys) {
    final val = DatabaseService.waterBox.get(key);
    if (val != null) {
      water.add(Map<String, dynamic>.from(val as Map));
    }
  }

  final weight = <Map<String, dynamic>>[];
  for (final key in DatabaseService.weightBox.keys) {
    final val = DatabaseService.weightBox.get(key);
    if (val != null) {
      weight.add(Map<String, dynamic>.from(val as Map));
    }
  }

  return {
    'exported_at': DateTime.now().toIso8601String(),
    'profile':
        profile != null ? Map<String, dynamic>.from(profile as Map) : {},
    'goals': goals != null ? Map<String, dynamic>.from(goals as Map) : {},
    'meals': meals,
    'water': water,
    'weight': weight,
  };
}

String buildExportJson() {
  return const JsonEncoder.withIndent('  ').convert(buildExportData());
}

Future<bool> exportData() async => false;
