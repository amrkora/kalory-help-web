import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../theme/app_theme.dart';
import '../providers/meals_provider.dart';
import '../l10n/app_localizations.dart';
import '../utils/localized_helpers.dart' as helpers;
import 'animated_entrance.dart';

class MealTimeline extends StatelessWidget {
  const MealTimeline({super.key});

  @override
  Widget build(BuildContext context) {
    final meals = context.watch<MealsProvider>();
    final mealList = meals.meals;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.dayFlow,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                if (mealList.isNotEmpty)
                  Text(
                    AppLocalizations.of(context)!.mealsCount(mealList.length),
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            if (mealList.isEmpty && !meals.loading)
              _buildEmptyState(context)
            else
              ...mealList.asMap().entries.map((entry) {
                final index = entry.key;
                final meal = entry.value;
                final isLast = index == mealList.length - 1;
                return AnimatedEntrance(
                  delay: Duration(milliseconds: index * 80),
                  child: _MealTimelineNode(
                    meal: meal,
                    isLast: isLast,
                  ),
                );
              }),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Row(
        children: [
          // Dotted line
          SizedBox(
            width: 20,
            height: 60,
            child: CustomPaint(
              painter: _DottedLinePainter(
                color: Theme.of(context).colorScheme.outlineVariant,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              AppLocalizations.of(context)!.noMealsLoggedYet,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MealTimelineNode extends StatelessWidget {
  final dynamic meal;
  final bool isLast;

  const _MealTimelineNode({
    required this.meal,
    required this.isLast,
  });

  String _formatMealTime(dynamic meal) {
    // Try to parse time from meal data
    final time = meal['time'] ?? meal['created_at'];
    if (time != null) {
      try {
        final dt = DateTime.parse(time.toString());
        return DateFormat('h:mm a').format(dt);
      } catch (_) {
        return time.toString();
      }
    }
    // Fallback based on meal type
    final type = (meal['meal_type'] ?? '').toString().toLowerCase();
    switch (type) {
      case 'breakfast':
        return '8:00 AM';
      case 'lunch':
        return '12:30 PM';
      case 'dinner':
        return '6:30 PM';
      case 'snack':
        return '3:00 PM';
      default:
        return '';
    }
  }

  String _localizedMealType(AppLocalizations l10n, String type) =>
      helpers.localizedMealType(l10n, type);

  String _localizedFoodName(AppLocalizations l10n, String key) =>
      helpers.localizedFoodName(l10n, key);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final items = (meal['items'] as List<dynamic>?) ?? [];
    final totalCal = items.fold<num>(0, (sum, item) => sum + (item['calories'] ?? 0));
    final mealType = _localizedMealType(l10n, meal['meal_type'] ?? '');
    final timeStr = _formatMealTime(meal);
    final itemNames = items.map<String>((i) => _localizedFoodName(l10n, i['name']?.toString() ?? '')).where((n) => n.isNotEmpty).toList();
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Time column
          SizedBox(
            width: 64,
            child: Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text(
                timeStr,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
          ),
          // Timeline line + dot
          SizedBox(
            width: 24,
            child: Column(
              children: [
                // Dot
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: AppColors.accentGradient,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.accent.withValues(alpha: 0.3),
                        blurRadius: 4,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                ),
                // Vertical line
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            AppColors.primary.withValues(alpha: 0.6),
                            AppColors.secondary.withValues(alpha: 0.3),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(1),
                      ),
                    ),
                  )
                else
                  // Dotted line after last meal
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: CustomPaint(
                        size: const Size(2, double.infinity),
                        painter: _DottedLinePainter(
                          color: Theme.of(context).colorScheme.outlineVariant,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          // Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        mealType,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          gradient: AppColors.primaryGradient,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          '${totalCal.toInt()} ${AppLocalizations.of(context)!.kcalUnit}',
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 10,
                              ),
                        ),
                      ),
                    ],
                  ),
                  if (itemNames.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      itemNames.take(3).join(', '),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DottedLinePainter extends CustomPainter {
  final Color color;

  _DottedLinePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    const dashHeight = 4.0;
    const dashSpace = 4.0;
    double startY = 0;
    final x = size.width / 2;

    while (startY < size.height) {
      canvas.drawLine(
        Offset(x, startY),
        Offset(x, (startY + dashHeight).clamp(0, size.height)),
        paint,
      );
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(_DottedLinePainter oldDelegate) =>
      oldDelegate.color != color;
}
