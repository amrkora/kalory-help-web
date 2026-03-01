import 'dart:convert';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart' show rootBundle;

// Conditional imports: sqflite + path_provider are not available on web.
import 'food_database_io.dart' if (dart.library.html) 'food_database_web.dart'
    as platform;

/// Provides read-only access to the pre-built food database.
///
/// On mobile/desktop: copies the SQLite asset to the documents directory and
/// queries it via sqflite.
/// On web: loads the JSON asset into memory and searches in Dart.
class FoodDatabase {
  static bool _initialized = false;

  // Web-only: in-memory food list (empty on mobile).
  static List<Map<String, dynamic>> _webFoods = [];

  /// Initializes the food database for the current platform.
  static Future<void> initialize() async {
    if (kIsWeb) {
      final jsonStr = await rootBundle.loadString('assets/food_ar.json');
      final List<dynamic> raw = json.decode(jsonStr);
      _webFoods = raw.map((e) => Map<String, dynamic>.from(e as Map)).toList();
      _initialized = true;
    } else {
      await platform.initializeSqlite();
      _initialized = true;
    }
  }

  /// Searches the food database by name (English or Arabic).
  static Future<List<Map<String, dynamic>>> searchFoods({
    required String query,
    Set<String> excludedCategories = const {},
    RegExp? excludedNamePattern,
    int limit = 20,
  }) async {
    if (!_initialized) return [];

    if (kIsWeb) {
      return _searchWeb(
        query: query,
        excludedCategories: excludedCategories,
        excludedNamePattern: excludedNamePattern,
        limit: limit,
      );
    }

    return platform.searchFoodsSqlite(
      query: query,
      excludedCategories: excludedCategories,
      excludedNamePattern: excludedNamePattern,
      limit: limit,
    );
  }

  /// Web fallback: linear scan of in-memory list.
  static List<Map<String, dynamic>> _searchWeb({
    required String query,
    Set<String> excludedCategories = const {},
    RegExp? excludedNamePattern,
    int limit = 20,
  }) {
    final q = query.toLowerCase();
    final results = <Map<String, dynamic>>[];

    for (final f in _webFoods) {
      if (results.length >= limit) break;
      final name = f['n'] as String? ?? '';
      final nameAr = f['n_ar'] as String? ?? '';
      if (!name.toLowerCase().contains(q) && !nameAr.contains(q)) continue;
      if (excludedCategories.isNotEmpty && excludedCategories.contains(f['c'])) {
        continue;
      }
      if (excludedNamePattern != null && excludedNamePattern.hasMatch(name)) {
        continue;
      }
      results.add(f);
    }
    return results;
  }

  /// Closes the database.
  static Future<void> close() async {
    if (!kIsWeb) {
      await platform.closeSqlite();
    }
    _webFoods = [];
    _initialized = false;
  }
}
