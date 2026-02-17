/// Formats a [DateTime] as YYYY-MM-DD for use as Hive box keys.
String formatDateKey(DateTime d) =>
    '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

/// Returns today's date formatted as YYYY-MM-DD.
String todayKey() => formatDateKey(DateTime.now());
