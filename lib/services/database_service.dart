import 'dart:convert';
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

  static const _secureStorage = FlutterSecureStorage();
  static const _keyName = 'hive_encryption_key';

  static Future<List<int>> _getEncryptionKey() async {
    final stored = await _secureStorage.read(key: _keyName);
    if (stored != null) {
      return base64Url.decode(stored);
    }
    final key = Hive.generateSecureKey();
    await _secureStorage.write(key: _keyName, value: base64Url.encode(key));
    return key;
  }

  /// Opens a Hive box with encryption. If the box was previously unencrypted,
  /// deletes it and re-creates as encrypted (seed data will be re-populated).
  static Future<Box> _openEncryptedBox(
      String name, HiveAesCipher cipher) async {
    try {
      return await Hive.openBox(name, encryptionCipher: cipher);
    } catch (_) {
      await Hive.deleteBoxFromDisk(name);
      return await Hive.openBox(name, encryptionCipher: cipher);
    }
  }

  static Future<void> initialize() async {
    await Hive.initFlutter();

    final key = await _getEncryptionKey();
    final cipher = HiveAesCipher(key);

    mealsBox = await _openEncryptedBox('meals', cipher);
    waterBox = await _openEncryptedBox('water', cipher);
    recipesBox = await _openEncryptedBox('recipes', cipher);
    profileBox = await _openEncryptedBox('profile', cipher);
    weightBox = await _openEncryptedBox('weight', cipher);
    foodsBox = await _openEncryptedBox('foods', cipher);

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

    await _loadFoodsAsset();
  }

  static Future<void> _loadFoodsAsset() async {
    final jsonStr = await rootBundle.loadString('assets/food_ar.json');
    final List<dynamic> raw = json.decode(jsonStr);
    foods = raw.map((e) => Map<String, dynamic>.from(e as Map)).toList();
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
    await profileBox.delete('onboarding_completed');
  }
}
