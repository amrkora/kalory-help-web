import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

const int _dbVersion = 2;
Database? _db;
bool _fts5Available = false;

/// Copies the asset DB to the documents directory (if needed) and opens it.
Future<void> initializeSqlite() async {
  final dir = await getApplicationDocumentsDirectory();
  final dbPath = p.join(dir.path, 'food.db');

  bool needsCopy = true;
  if (File(dbPath).existsSync()) {
    try {
      final existing = await openDatabase(dbPath, readOnly: true);
      final rows = await existing.rawQuery(
        "SELECT value FROM meta WHERE key = 'version'",
      );
      if (rows.isNotEmpty && rows.first['value'] == '$_dbVersion') {
        needsCopy = false;
        _db = existing;
      } else {
        await existing.close();
      }
    } catch (_) {
      // Corrupted or old schema — delete and recopy.
      try {
        File(dbPath).deleteSync();
      } catch (_) {}
    }
  }

  if (needsCopy) {
    // Delete any existing file before writing to handle partial/corrupt copies.
    try {
      File(dbPath).deleteSync();
    } catch (_) {}
    final data = await rootBundle.load('assets/food.db');
    final bytes = data.buffer.asUint8List(
      data.offsetInBytes,
      data.lengthInBytes,
    );
    await File(dbPath).writeAsBytes(bytes, flush: true);
    _db = await openDatabase(dbPath, readOnly: true);
  }

  // Probe FTS5 availability.
  _fts5Available = await _checkFts5();
}

/// Returns true if the foods_fts table exists and FTS5 queries work.
Future<bool> _checkFts5() async {
  if (_db == null) return false;
  try {
    await _db!.rawQuery(
      "SELECT rowid FROM foods_fts WHERE foods_fts MATCH 'test' LIMIT 1",
    );
    return true;
  } catch (_) {
    return false;
  }
}

/// Sanitizes a user query for FTS5 MATCH syntax.
///
/// Strips special characters, splits into words, and appends `*` to each
/// for prefix matching. Example: "lamb biryani" -> "lamb* biryani*"
String _buildFts5Query(String query) {
  // Remove FTS5 special characters that could break the query.
  final cleaned = query.replaceAll(RegExp(r'["\*\(\)\-\+\^:{}~]'), ' ').trim();
  if (cleaned.isEmpty) return '';
  final words =
      cleaned.split(RegExp(r'\s+')).where((w) => w.isNotEmpty).toList();
  return words.map((w) => '$w*').join(' ');
}

/// Queries the SQLite food database.
Future<List<Map<String, dynamic>>> searchFoodsSqlite({
  required String query,
  Set<String> excludedCategories = const {},
  RegExp? excludedNamePattern,
  int limit = 20,
}) async {
  if (_db == null) return [];

  final fetchLimit = excludedNamePattern != null ? limit * 3 : limit;

  if (_fts5Available) {
    return _searchFts5(
      query: query,
      excludedCategories: excludedCategories,
      excludedNamePattern: excludedNamePattern,
      limit: limit,
      fetchLimit: fetchLimit,
    );
  }

  return _searchLikeFallback(
    query: query,
    excludedCategories: excludedCategories,
    excludedNamePattern: excludedNamePattern,
    limit: limit,
    fetchLimit: fetchLimit,
  );
}

/// FTS5 indexed search.
Future<List<Map<String, dynamic>>> _searchFts5({
  required String query,
  required Set<String> excludedCategories,
  required RegExp? excludedNamePattern,
  required int limit,
  required int fetchLimit,
}) async {
  final ftsQuery = _buildFts5Query(query);
  if (ftsQuery.isEmpty) return [];

  String sql;
  List<Object?> args;

  if (excludedCategories.isEmpty) {
    sql = '''
      SELECT f.n, f.c, f.k, f.p, f.n_ar, f.c_ar
      FROM foods_fts
      JOIN foods f ON f.id = foods_fts.rowid
      WHERE foods_fts MATCH ?
      LIMIT ?
    ''';
    args = [ftsQuery, fetchLimit];
  } else {
    final placeholders =
        List.filled(excludedCategories.length, '?').join(',');
    sql = '''
      SELECT f.n, f.c, f.k, f.p, f.n_ar, f.c_ar
      FROM foods_fts
      JOIN foods f ON f.id = foods_fts.rowid
      WHERE foods_fts MATCH ?
        AND f.c NOT IN ($placeholders)
      LIMIT ?
    ''';
    args = [ftsQuery, ...excludedCategories, fetchLimit];
  }

  final rows = await _db!.rawQuery(sql, args);
  return _applyNameFilter(rows, excludedNamePattern, limit);
}

/// LIKE fallback for devices without FTS5 support.
Future<List<Map<String, dynamic>>> _searchLikeFallback({
  required String query,
  required Set<String> excludedCategories,
  required RegExp? excludedNamePattern,
  required int limit,
  required int fetchLimit,
}) async {
  final q = query.toLowerCase();

  String sql;
  List<Object?> args;

  if (excludedCategories.isEmpty) {
    sql = '''
      SELECT n, c, k, p, n_ar, c_ar
      FROM foods
      WHERE LOWER(n) LIKE ? OR n_ar LIKE ?
      LIMIT ?
    ''';
    args = ['%$q%', '%$q%', fetchLimit];
  } else {
    final placeholders =
        List.filled(excludedCategories.length, '?').join(',');
    sql = '''
      SELECT n, c, k, p, n_ar, c_ar
      FROM foods
      WHERE (LOWER(n) LIKE ? OR n_ar LIKE ?)
        AND c NOT IN ($placeholders)
      LIMIT ?
    ''';
    args = ['%$q%', '%$q%', ...excludedCategories, fetchLimit];
  }

  final rows = await _db!.rawQuery(sql, args);
  return _applyNameFilter(rows, excludedNamePattern, limit);
}

/// Applies the optional name exclusion regex and enforces the limit.
List<Map<String, dynamic>> _applyNameFilter(
  List<Map<String, dynamic>> rows,
  RegExp? excludedNamePattern,
  int limit,
) {
  if (excludedNamePattern == null) {
    return rows.take(limit).toList();
  }
  final filtered = <Map<String, dynamic>>[];
  for (final row in rows) {
    if (filtered.length >= limit) break;
    final name = row['n'] as String? ?? '';
    if (!excludedNamePattern.hasMatch(name)) {
      filtered.add(row);
    }
  }
  return filtered;
}

/// Closes the SQLite database.
Future<void> closeSqlite() async {
  await _db?.close();
  _db = null;
  _fts5Available = false;
}
