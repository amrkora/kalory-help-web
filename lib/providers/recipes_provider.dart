import 'package:flutter/foundation.dart';
import '../services/database_service.dart';

class RecipesProvider extends ChangeNotifier {
  List<dynamic> _recipes = [];
  List<dynamic> _featured = [];
  bool _loading = false;
  String? _error;

  List<dynamic> get recipes => _recipes;
  List<dynamic> get featured => _featured;
  bool get loading => _loading;
  String? get error => _error;

  List<Map<String, dynamic>> _allRecipes() {
    return DatabaseService.recipesBox.values
        .map((v) => Map<String, dynamic>.from(v as Map))
        .toList();
  }

  Future<void> load({String? category, String? search}) async {
    _error = null;
    _loading = true;
    notifyListeners();
    try {
      var all = _allRecipes();

      if (category != null && category != 'All') {
        all = all.where((r) => r['category'] == category).toList();
      }
      if (search != null && search.isNotEmpty) {
        final q = search.toLowerCase();
        all = all
            .where((r) =>
                (r['name'] ?? '').toString().toLowerCase().contains(q))
            .toList();
      }
      _recipes = all;
    } catch (e) {
      _error = 'Could not load recipes';
      _recipes = [];
    }
    _loading = false;
    notifyListeners();
  }

  Future<void> loadFeatured() async {
    try {
      _featured =
          _allRecipes().where((r) => r['featured'] == 1).toList();
    } catch (e) {
      _error = 'Could not load featured recipes';
      _featured = [];
    }
    notifyListeners();
  }

  Future<void> loadAll() async {
    _loading = true;
    notifyListeners();
    await Future.wait([load(), loadFeatured()]);
    _loading = false;
    notifyListeners();
  }
}
