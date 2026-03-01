/// Web stub — SQLite operations are not used on web.
/// FoodDatabase handles web search via in-memory JSON fallback.

Future<void> initializeSqlite() async {}

Future<List<Map<String, dynamic>>> searchFoodsSqlite({
  required String query,
  Set<String> excludedCategories = const {},
  RegExp? excludedNamePattern,
  int limit = 20,
}) async => [];

Future<void> closeSqlite() async {}
