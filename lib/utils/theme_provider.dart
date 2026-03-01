import 'package:flutter/material.dart';
import '../services/database_service.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeProvider() {
    if (DatabaseService.isInitialized) {
      _loadFromStorage();
    }
  }

  void loadFromDb() {
    _loadFromStorage();
    notifyListeners();
  }

  ThemeMode get themeMode => _themeMode;

  void _loadFromStorage() {
    final prefs = DatabaseService.profileBox.get('preferences');
    if (prefs != null) {
      final mode = (prefs as Map)['theme_mode'] as String?;
      if (mode == 'light') {
        _themeMode = ThemeMode.light;
      } else if (mode == 'dark') {
        _themeMode = ThemeMode.dark;
      }
    }
  }

  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    _saveToStorage(mode);
    notifyListeners();
  }

  void _saveToStorage(ThemeMode mode) {
    final prefs = DatabaseService.profileBox.get('preferences');
    final map = prefs != null
        ? Map<String, dynamic>.from(prefs as Map)
        : <String, dynamic>{};
    map['theme_mode'] = mode == ThemeMode.light
        ? 'light'
        : mode == ThemeMode.dark
            ? 'dark'
            : 'system';
    DatabaseService.profileBox.put('preferences', map);
  }
}
