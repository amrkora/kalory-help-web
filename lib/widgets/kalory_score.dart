import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../providers/summary_provider.dart';
import '../providers/water_provider.dart';
import '../l10n/app_localizations.dart';

class KaloryScore extends StatefulWidget {
  const KaloryScore({super.key});

  static int computeScore(SummaryProvider summary, WaterProvider water) {
    // Calorie adherence (40%): 1 - |consumed - goal| / goal, clamped 0-1
    final calGoal = summary.caloriesGoal;
    final calConsumed = summary.caloriesConsumed;
    final calAdherence =
        calGoal > 0 ? (1 - (calConsumed - calGoal).abs() / calGoal).clamp(0.0, 1.0) : 0.0;

    // Macro balance (35%): average of each macro's progress toward goal, clamped 0-1
    double macroScore(int consumed, int goal) {
      if (goal <= 0) return 0.0;
      final ratio = consumed / goal;
      return (1 - (ratio - 1).abs()).clamp(0.0, 1.0);
    }

    final proteinScore = macroScore(summary.proteinConsumed, summary.proteinGoal);
    final carbsScore = macroScore(summary.carbsConsumed, summary.carbsGoal);
    final fatScore = macroScore(summary.fatConsumed, summary.fatGoal);
    final macroBalance = (proteinScore + carbsScore + fatScore) / 3;

    // Hydration (25%): waterConsumed / waterGoal, clamped 0-1
    final waterGoal = water.goal;
    final waterConsumed = water.consumed;
    final hydration = waterGoal > 0 ? (waterConsumed / waterGoal).clamp(0.0, 1.0) : 0.0;

    // Weighted sum
    final score = (calAdherence * 0.40 + macroBalance * 0.35 + hydration * 0.25) * 100;
    return score.round();
  }

  @override
  State<KaloryScore> createState() => _KaloryScoreState();
}

class _KaloryScoreState extends State<KaloryScore>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
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

  static String _getLabel(int score, AppLocalizations l10n) {
    if (score >= 90) return l10n.perfectDay;
    if (score >= 70) return l10n.greatBalance;
    if (score >= 50) return l10n.gettingThere;
    return l10n.needsAttention;
  }

  static IconData _getIcon(int score) {
    if (score >= 90) return Icons.star_rounded;
    if (score >= 70) return Icons.check_circle_rounded;
    if (score >= 50) return Icons.trending_up_rounded;
    return Icons.info_outline_rounded;
  }

  /// Computes individual component scores (0.0–1.0) for the breakdown.
  static ({double calories, double macros, double hydration}) _componentScores(
      SummaryProvider summary, WaterProvider water) {
    final calGoal = summary.caloriesGoal;
    final calConsumed = summary.caloriesConsumed;
    final cal = calGoal > 0
        ? (1 - (calConsumed - calGoal).abs() / calGoal).clamp(0.0, 1.0)
        : 0.0;

    double macroScore(int consumed, int goal) {
      if (goal <= 0) return 0.0;
      final ratio = consumed / goal;
      return (1 - (ratio - 1).abs()).clamp(0.0, 1.0);
    }

    final p = macroScore(summary.proteinConsumed, summary.proteinGoal);
    final c = macroScore(summary.carbsConsumed, summary.carbsGoal);
    final f = macroScore(summary.fatConsumed, summary.fatGoal);
    final macros = (p + c + f) / 3;

    final wGoal = water.goal;
    final wConsumed = water.consumed;
    final hyd = wGoal > 0 ? (wConsumed / wGoal).clamp(0.0, 1.0) : 0.0;

    return (calories: cal, macros: macros, hydration: hyd);
  }

  void _showBreakdown(BuildContext context) {
    final summary = context.read<SummaryProvider>();
    final water = context.read<WaterProvider>();
    final l10n = AppLocalizations.of(context)!;
    final components = _componentScores(summary, water);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(ctx).colorScheme.surface,
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle bar
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Theme.of(ctx).colorScheme.outlineVariant,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                l10n.scoreBreakdown,
                style: Theme.of(ctx).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 20),
              _breakdownRow(ctx, l10n.calorieAdherence, components.calories,
                  0.40, AppColors.accent),
              const SizedBox(height: 12),
              _breakdownRow(ctx, l10n.macroBalance, components.macros, 0.35,
                  AppColors.primary),
              const SizedBox(height: 12),
              _breakdownRow(ctx, l10n.hydration, components.hydration, 0.25,
                  AppColors.success),
            ],
          ),
        );
      },
    );
  }

  Widget _breakdownRow(BuildContext context, String label, double value,
      double weight, Color color) {
    final points = (value * weight * 100).round();
    final maxPoints = (weight * 100).round();

    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const SizedBox(height: 4),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: value.clamp(0.0, 1.0),
                  minHeight: 6,
                  backgroundColor:
                      Theme.of(context).colorScheme.surfaceContainerHighest,
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        SizedBox(
          width: 60,
          child: Text(
            '$points / $maxPoints',
            textAlign: TextAlign.end,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final summary = context.watch<SummaryProvider>();
    final water = context.watch<WaterProvider>();
    final l10n = AppLocalizations.of(context)!;
    final score = KaloryScore.computeScore(summary, water);
    final label = _getLabel(score, l10n);
    final icon = _getIcon(score);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Color based on score
    Color statusColor;
    Color statusBg;
    if (score < 50) {
      statusColor = AppColors.error;
      statusBg = isDark ? AppColors.error.withValues(alpha: 0.15) : AppColors.errorContainer;
    } else if (score < 70) {
      statusColor = AppColors.warning;
      statusBg = isDark ? AppColors.warning.withValues(alpha: 0.15) : AppColors.warningContainer;
    } else {
      statusColor = AppColors.success;
      statusBg = isDark ? AppColors.success.withValues(alpha: 0.15) : AppColors.successContainer;
    }

    return Semantics(
      label: '${l10n.kaloryScore}: $score / 100. $label',
      child: GestureDetector(
        onTap: () => _showBreakdown(context),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                final displayScore = (score * _animation.value).round();
                return Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: statusBg,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(icon, color: statusColor, size: 26),
                  ),
                  const SizedBox(width: 16),
                  // Score number with gradient
                  ShaderMask(
                    shaderCallback: (bounds) => LinearGradient(
                      colors: [
                        Theme.of(context).colorScheme.primary,
                        AppColors.accent,
                      ],
                    ).createShader(bounds),
                    child: Text(
                      '$displayScore',
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            height: 1,
                          ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.kaloryScore,
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                color: Theme.of(context).colorScheme.onSurfaceVariant,
                                letterSpacing: 0.8,
                              ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          label,
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                color: statusColor,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        ),
      ),
    );
  }
}
