import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../data/seed_recipes.dart';
import '../data/seed_data.dart' show seedProfile, seedGoals, seedPreferences;

class DatabaseService {
  static late Box mealsBox;
  static late Box waterBox;
  static late Box recipesBox;
  static late Box profileBox;
  static late Box weightBox;
  static late Box foodsBox;

  /// In-memory food database loaded from asset (read-only, not stored in Hive).
  static List<Map<String, dynamic>> foods = [];

  /// In-memory list of user-created custom foods (persisted in foodsBox).
  static List<Map<String, dynamic>> customFoods = [];

  static const _storage = FlutterSecureStorage();
  static const _encKeyName = 'profile_box_key';

  /// Returns the 256-bit encryption key for the profile box, creating one if
  /// it doesn't exist yet.
  static Future<Uint8List> _getEncryptionKey() async {
    final existing = await _storage.read(key: _encKeyName);
    if (existing != null) {
      return base64Url.decode(existing);
    }
    final key = Hive.generateSecureKey();
    await _storage.write(key: _encKeyName, value: base64Url.encode(key));
    return Uint8List.fromList(key);
  }

  /// Opens a regular (unencrypted) Hive box, deleting & recreating on error.
  static Future<Box> _openBox(String name) async {
    try {
      return await Hive.openBox(name);
    } catch (_) {
      await Hive.deleteBoxFromDisk(name);
      return await Hive.openBox(name);
    }
  }

  /// Opens the profile box with AES encryption. Migrates existing unencrypted
  /// data on first run.
  static Future<Box> _openEncryptedProfileBox(Uint8List key) async {
    final cipher = HiveAesCipher(key);

    // Try opening as encrypted first (normal path after migration).
    try {
      return await Hive.openBox('profile', encryptionCipher: cipher);
    } catch (_) {
      // Box exists but is unencrypted — migrate.
    }

    // Read existing unencrypted data.
    Map<dynamic, dynamic> existing = {};
    try {
      final plain = await Hive.openBox('profile');
      existing = plain.toMap();
      await plain.close();
    } catch (_) {
      // Corrupted — will be re-seeded.
    }

    await Hive.deleteBoxFromDisk('profile');
    final encrypted = await Hive.openBox('profile', encryptionCipher: cipher);

    // Restore data into the encrypted box.
    if (existing.isNotEmpty) {
      for (final entry in existing.entries) {
        await encrypted.put(entry.key, entry.value);
      }
    }

    return encrypted;
  }

  static Future<void> initialize() async {
    await Hive.initFlutter();

    final encKey = await _getEncryptionKey();

    // Open all boxes and load the food asset in parallel.
    final results = await Future.wait([
      _openBox('meals'),                  // 0
      _openBox('water'),                  // 1
      _openBox('recipes'),                // 2
      _openEncryptedProfileBox(encKey),   // 3
      _openBox('weight'),                 // 4
      _openBox('foods'),                  // 5
      _loadFoodsAsset(),                  // 6 (returns null)
    ]);

    mealsBox = results[0] as Box;
    waterBox = results[1] as Box;
    recipesBox = results[2] as Box;
    profileBox = results[3] as Box;
    weightBox = results[4] as Box;
    foodsBox = results[5] as Box;

    if (profileBox.get('seeded') != true) {
      await _seed();
    }

    // Re-seed recipes if version changed (e.g. new recipe data)
    if (profileBox.get('recipes_version') != 9) {
      await recipesBox.clear();
      for (var i = 0; i < seedRecipes.length; i++) {
        final recipe = Map<String, dynamic>.from(seedRecipes[i]);
        if (recipe['steps'] != null) {
          recipe['steps'] = List<String>.from(recipe['steps'] as List);
        }
        await recipesBox.put('recipe_$i', recipe);
      }
      await profileBox.put('recipes_version', 9);
    }

    _loadCustomFoods();
  }

  static Future<void> _loadFoodsAsset() async {
    final jsonStr = await rootBundle.loadString('assets/food_ar.json');
    final List<dynamic> raw = json.decode(jsonStr);
    foods = raw.map((e) => Map<String, dynamic>.from(e as Map)).toList();
  }

  static void _loadCustomFoods() {
    customFoods = foodsBox.keys
        .map((key) => Map<String, dynamic>.from(foodsBox.get(key) as Map))
        .toList();
  }

  static Future<void> saveCustomFood({
    required String name,
    required int calories,
    required int protein,
    required int carbs,
    required int fat,
  }) async {
    final entry = {
      'n': name,
      'k': calories,
      'p': protein,
      'carbs': carbs,
      'fat': fat,
      'c': 'Custom',
      'c_ar': 'مخصص',
      'custom': true,
    };
    await foodsBox.put(name.toLowerCase().trim(), entry);
    _loadCustomFoods();
  }

  static Future<void> _seed() async {
    // Profile data
    await profileBox.put('profile', Map<String, dynamic>.from(seedProfile));
    await profileBox.put('goals', Map<String, dynamic>.from(seedGoals));
    await profileBox.put('preferences', Map<String, dynamic>.from(seedPreferences));
    // Recipes
    for (var i = 0; i < seedRecipes.length; i++) {
      final recipe = Map<String, dynamic>.from(seedRecipes[i]);
      if (recipe['steps'] != null) {
        recipe['steps'] = List<String>.from(recipe['steps'] as List);
      }
      await recipesBox.put('recipe_$i', recipe);
    }

    await profileBox.put('seeded', true);
  }

  /// Deletes all user data (meals, water, weight) and resets profile to defaults.
  static Future<void> deleteAllData() async {
    await mealsBox.clear();
    await waterBox.clear();
    await weightBox.clear();
    // Reset profile to defaults but keep seeded flag and recipes
    await profileBox.put('profile', Map<String, dynamic>.from(seedProfile));
    await profileBox.put('goals', Map<String, dynamic>.from(seedGoals));
    await profileBox.put('preferences', Map<String, dynamic>.from(seedPreferences));
    await foodsBox.clear();
    customFoods = [];
    await profileBox.delete('onboarding_completed');
  }
}
