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
    );
  }
}
