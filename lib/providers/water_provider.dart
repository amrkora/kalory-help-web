import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import '../services/database_service.dart';
import '../utils/date_helpers.dart';

const _uuid = Uuid();

class WaterProvider extends ChangeNotifier {
  Map<String, dynamic>? _water;
  bool _loading = false;
  String? _error;

  Map<String, dynamic>? get water => _water;
  bool get loading => _loading;
  String? get error => _error;

  int get consumed => _water?['glasses_consumed'] ?? 0;
  int get goal => _water?['goal'] ?? 8;
  String? get id => _water?['id'];

  /// Inject data for unit testing without Hive.
  void setTestData({required int consumed, required int goal}) {
    _water = {'glasses_consumed': consumed, 'goal': goal};
  }

  Future<void> load({String? date}) async {
    _error = null;
    _loading = true;
    notifyListeners();
    try {
      final targetDate = date ?? todayKey();
      final raw = DatabaseService.waterBox.get(targetDate);
      _water = raw != null ? Map<String, dynamic>.from(raw as Map) : null;
    } catch (e) {
      _error = 'Could not load water data';
      _water = null;
    }
    _loading = false;
    notifyListeners();
  }

  Future<void> increment() async {
    final today = todayKey();
    final newCount = consumed + 1;

    if (_water != null) {
      _water!['glasses_consumed'] = newCount;
      await DatabaseService.waterBox.put(today, Map<String, dynamic>.from(_water!));
    } else {
      _water = {
        'id': _uuid.v4(),
        'date': today,
        'glasses_consumed': newCount,
        'goal': goal,
      };
      await DatabaseService.waterBox.put(today, Map<String, dynamic>.from(_water!));
    }
    notifyListeners();
  }
}
