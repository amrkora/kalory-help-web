import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;
import '../theme/app_theme.dart';
import '../providers/summary_provider.dart';
import '../l10n/app_localizations.dart';

class ActivityRings extends StatefulWidget {
  const ActivityRings({super.key});

  @override
  State<ActivityRings> createState() => _ActivityRingsState();
}

class _ActivityRingsState extends State<ActivityRings>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double _ringAnim(int index) {
    final delay = index * 0.08;
    final t = ((_animation.value - delay) / (1.0 - delay)).clamp(0.0, 1.0);
    return Curves.easeOutCubic.transform(t);
  }

  @override
  Widget build(BuildContext context) {
    final summary = context.watch<SummaryProvider>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final calProgress = summary.caloriesGoal > 0
        ? (summary.caloriesConsumed / summary.caloriesGoal).clamp(0.0, 1.0)
        : 0.0;
    final proProgress = summary.proteinGoal > 0
        ? (summary.proteinConsumed / summary.proteinGoal).clamp(0.0, 1.0)
        : 0.0;
    final carbProgress = summary.carbsGoal > 0
        ? (summary.carbsConsumed / summary.carbsGoal).clamp(0.0, 1.0)
        : 0.0;
    final fatProgress = summary.fatGoal > 0
        ? (summary.fatConsumed / summary.fatGoal).clamp(0.0, 1.0)
        : 0.0;

    final remaining = summary.caloriesRemaining;
    final bgColor = isDark ? AppColors.outlineVariantDark : AppColors.outlineVariant;

    final l10n = AppLocalizations.of(context)!;

    return Semantics(
      label: '${l10n.calories} ${(calProgress * 100).round()}%, '
          '${l10n.protein} ${(proProgress * 100).round()}%, '
          '${l10n.carbs} ${(carbProgress * 100).round()}%, '
          '${l10n.fat} ${(fatProgress * 100).round()}%',
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
            return Column(
              children: [
                // Large calorie ring
                SizedBox(
                  width: 160,
                  height: 160,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CustomPaint(
                        size: const Size(160, 160),
                        painter: _SingleRingPainter(
                          progress: calProgress * _ringAnim(0),
                          strokeWidth: 14,
                          colors: [AppColors.primary, AppColors.secondary, AppColors.accent],
                          bgColor: bgColor,
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            NumberFormat('#,###').format((remaining.abs() * _animation.value).round()),
                            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: remaining < 0 ? AppColors.error : null,
                                  height: 1,
                                ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            remaining < 0 ? l10n.overLabel : l10n.remainingLabel,
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                  color: remaining < 0
                                      ? AppColors.error
                                      : Theme.of(context).colorScheme.onSurfaceVariant,
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                // Calorie legend
                Text(
                  '${NumberFormat('#,###').format(summary.caloriesConsumed)} / ${NumberFormat('#,###').format(summary.caloriesGoal)} ${l10n.kcalUnit}',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
                const SizedBox(height: 20),
                // 3 macro circles in a row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _MacroCircle(
                      label: l10n.protein,
                      consumed: summary.proteinConsumed,
                      goal: summary.proteinGoal,
                      unit: l10n.gramUnit,
                      progress: proProgress * _ringAnim(1),
                      colors: const [Color(0xFFEC4899), Color(0xFFF472B6)],
                      bgColor: bgColor,
                    ),
                    _MacroCircle(
                      label: l10n.carbs,
                      consumed: summary.carbsConsumed,
                      goal: summary.carbsGoal,
                      unit: l10n.gramUnit,
                      progress: carbProgress * _ringAnim(2),
                      colors: const [Color(0xFF10B981), Color(0xFF34D399)],
                      bgColor: bgColor,
                    ),
                    _MacroCircle(
                      label: l10n.fat,
                      consumed: summary.fatConsumed,
                      goal: summary.fatGoal,
                      unit: l10n.gramUnit,
                      progress: fatProgress * _ringAnim(3),
                      colors: const [Color(0xFF6366F1), Color(0xFF818CF8)],
                      bgColor: bgColor,
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
      ),
    );
  }
}

class _MacroCircle extends StatelessWidget {
  final String label;
  final int consumed;
  final int goal;
  final String unit;
  final double progress;
  final List<Color> colors;
  final Color bgColor;

  const _MacroCircle({
    required this.label,
    required this.consumed,
    required this.goal,
    required this.unit,
    required this.progress,
    required this.colors,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 72,
          height: 72,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CustomPaint(
                size: const Size(72, 72),
                painter: _SingleRingPainter(
                  progress: progress,
                  strokeWidth: 8,
                  colors: colors,
                  bgColor: bgColor,
                ),
              ),
              Text(
                '$consumed',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      height: 1,
                    ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        Text(
          '$consumed / $goal$unit',
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                fontSize: 10,
              ),
        ),
      ],
    );
  }
}

class _SingleRingPainter extends CustomPainter {
  final double progress;
  final double strokeWidth;
  final List<Color> colors;
  final Color bgColor;

  _SingleRingPainter({
    required this.progress,
    required this.strokeWidth,
    required this.colors,
    required this.bgColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    // Background circle
    final bgPaint = Paint()
      ..color = bgColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, bgPaint);

    // Progress arc
    if (progress > 0) {
      final rect = Rect.fromCircle(center: center, radius: radius);
      final gradientColors = colors.length >= 3
          ? colors
          : [...colors, colors.last];
      final gradient = SweepGradient(
        colors: gradientColors,
        stops: List.generate(gradientColors.length, (i) => i / (gradientColors.length - 1)),
        transform: const GradientRotation(-math.pi / 2),
      );

      final progressPaint = Paint()
        ..shader = gradient.createShader(rect)
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(
        rect,
        -math.pi / 2,
        2 * math.pi * progress,
        false,
        progressPaint,
      );
    }
  }

  @override
  bool shouldRepaint(_SingleRingPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
