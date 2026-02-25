import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../theme/app_theme.dart';
import '../../providers/progress_provider.dart';
import '../../providers/profile_provider.dart';
import '../../widgets/macro_bar.dart';
import '../../widgets/animated_entrance.dart';
import '../../l10n/app_localizations.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  int _selectedPeriod = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProgressProvider>().load();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Breakpoints.isDesktop(context);
    final isTablet = Breakpoints.isTablet(context);
    final padding = Breakpoints.getHorizontalPadding(context);

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: padding, vertical: 16),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: Breakpoints.getContentWidth(context),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context),
                const SizedBox(height: 24),
                if (isDesktop)
                  _buildDesktopLayout(context)
                else if (isTablet)
                  _buildTabletLayout(context)
                else
                  _buildMobileLayout(context),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      children: [
        AnimatedEntrance(
          child: _buildCalorieTrends(context),
        ),
        const SizedBox(height: 24),
        AnimatedEntrance(
          delay: const Duration(milliseconds: 100),
          child: _buildNutritionAverages(context),
        ),
        const SizedBox(height: 24),
        AnimatedEntrance(
          delay: const Duration(milliseconds: 200),
          child: _buildStreaksCard(context),
        ),
      ],
    );
  }

  Widget _buildTabletLayout(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildCalorieTrends(context)),
            const SizedBox(width: 16),
            Expanded(child: _buildNutritionAverages(context)),
          ],
        ),
        const SizedBox(height: 24),
        _buildStreaksCard(context),
      ],
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildCalorieTrends(context)),
            const SizedBox(width: 24),
            Expanded(child: _buildNutritionAverages(context)),
          ],
        ),
        const SizedBox(height: 24),
        _buildStreaksCard(context),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final localizedPeriods = [l10n.week, l10n.month, l10n.threeMonths];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShaderMask(
          shaderCallback: (bounds) =>
              AppColors.primaryGradient.createShader(bounds),
          child: Text(
            l10n.progressTitle,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: List.generate(localizedPeriods.length, (index) {
            final selected = _selectedPeriod == index;
            return Padding(
              padding: const EdgeInsetsDirectional.only(end: 8),
              child: ChoiceChip(
                label: Text(localizedPeriods[index]),
                selected: selected,
                onSelected: (_) {
                  setState(() => _selectedPeriod = index);
                  context.read<ProgressProvider>().load(
                        period: context
                            .read<ProgressProvider>()
                            .periodParam(index),
                      );
                },
                selectedColor: AppColors.primaryContainer,
                labelStyle: TextStyle(
                  color: selected ? AppColors.primary : null,
                  fontWeight: selected ? FontWeight.w600 : null,
                ),
                visualDensity: VisualDensity.compact,
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildCalorieTrends(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final progress = context.watch<ProgressProvider>();
    final profile = context.watch<ProfileProvider>();
    final calorieData = progress.calorieData;
    final goal = profile.calorieGoal;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.calorieTrends,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 16),
            if (calorieData.isEmpty)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(l10n.noCalorieData,
                      style: Theme.of(context).textTheme.bodyMedium),
                ),
              )
            else
              ...calorieData.map((entry) {
                final cals =
                    (entry['total_calories'] as num?)?.toInt() ?? 0;
                final ratio = goal > 0
                    ? (cals / goal).clamp(0.0, 1.0)
                    : 0.0;
                final overGoal = cals > goal;
                final date = DateTime.parse(entry['date']);
                final dayLabel = DateFormat('E', Localizations.localeOf(context).languageCode).format(date);

                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 36,
                        child: Text(
                          dayLabel,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurfaceVariant,
                              ),
                        ),
                      ),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: ratio.toDouble(),
                            minHeight: 16,
                            backgroundColor: Theme.of(context)
                                .colorScheme
                                .surfaceContainerHighest,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              overGoal
                                  ? AppColors.warning
                                  : AppColors.primary,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      SizedBox(
                        width: 48,
                        child: Text(
                          '$cals',
                          textAlign: TextAlign.end,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                fontWeight: FontWeight.w600,
                                color:
                                    overGoal ? AppColors.warning : null,
                              ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
          ],
        ),
      ),
    );
  }

  Widget _buildNutritionAverages(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final progress = context.watch<ProgressProvider>();
    final profile = context.watch<ProfileProvider>();
    final nutritionData = progress.nutritionData;

    // Calculate averages
    int avgProtein = 0, avgCarbs = 0, avgFat = 0;
    if (nutritionData.isNotEmpty) {
      final totalP = nutritionData.fold<num>(
          0, (s, e) => s + (e['total_protein'] ?? 0));
      final totalC = nutritionData.fold<num>(
          0, (s, e) => s + (e['total_carbs'] ?? 0));
      final totalF = nutritionData.fold<num>(
          0, (s, e) => s + (e['total_fat'] ?? 0));
      avgProtein = (totalP / nutritionData.length).round();
      avgCarbs = (totalC / nutritionData.length).round();
      avgFat = (totalF / nutritionData.length).round();
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.nutritionAverages,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              l10n.dailyAverageThisWeek,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
            const SizedBox(height: 16),
            MacroBar(
              label: l10n.protein,
              current: avgProtein,
              goal: profile.proteinGoal,
              gradient: const LinearGradient(
                colors: [Color(0xFFEC4899), Color(0xFFF472B6)],
              ),
            ),
            const SizedBox(height: 12),
            MacroBar(
              label: l10n.carbs,
              current: avgCarbs,
              goal: profile.carbsGoal,
              gradient: const LinearGradient(
                colors: [Color(0xFF10B981), Color(0xFF34D399)],
              ),
            ),
            const SizedBox(height: 12),
            MacroBar(
              label: l10n.fat,
              current: avgFat,
              goal: profile.fatGoal,
              gradient: const LinearGradient(
                colors: [Color(0xFF6366F1), Color(0xFF818CF8)],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStreaksCard(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final progress = context.watch<ProgressProvider>();
    final streaks = progress.streaks;

    // Extract streak values
    String loggingVal = l10n.daysCount(0);
    String waterVal = l10n.daysCount(0);
    String goalsVal = l10n.countOfFour(0);
    for (final s in streaks) {
      final type = s['streak_type'];
      final count = s['current_count'] ?? 0;
      if (type == 'logging') loggingVal = l10n.daysCount(count);
      if (type == 'water') waterVal = l10n.daysCount(count);
      if (type == 'goals_met') goalsVal = l10n.countOfFour(count);
    }

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.8, end: 1.0),
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutCubic,
      builder: (context, scale, child) => Transform.scale(
        scale: scale,
        child: child,
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: AppColors.primaryGradient,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.streaksAchievements,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Colors.white.withValues(alpha: 0.9),
                    letterSpacing: 1.2,
                  ),
            ),
            const SizedBox(height: 20),
            _buildStreakRow(
              context,
              icon: Icons.local_fire_department,
              label: l10n.loggingStreak,
              value: loggingVal,
            ),
            const SizedBox(height: 16),
            _buildStreakRow(
              context,
              icon: Icons.water_drop,
              label: l10n.waterStreak,
              value: waterVal,
            ),
            const SizedBox(height: 16),
            _buildStreakRow(
              context,
              icon: Icons.emoji_events,
              label: l10n.weeklyGoalsMet,
              value: goalsVal,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStreakRow(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: Colors.white, size: 22),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white.withValues(alpha: 0.9),
                ),
          ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }
}
