import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../l10n/app_localizations.dart';
import '../../data/seed_tips.dart';
import '../../utils/locale_provider.dart';
import '../../theme/app_theme.dart';
import '../../providers/summary_provider.dart';
import '../../providers/meals_provider.dart';
import '../../widgets/kalory_score.dart';
import '../../widgets/activity_rings.dart';
import '../../widgets/hydration_wave.dart';
import '../../widgets/meal_timeline.dart';
import '../../widgets/animated_entrance.dart';
import '../../utils/localized_helpers.dart' as helpers;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Breakpoints.isDesktop(context);
    final isTablet = Breakpoints.isTablet(context);
    final padding = Breakpoints.getHorizontalPadding(context);

    return Scaffold(
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        padding: EdgeInsetsDirectional.only(
          start: padding,
          end: padding,
          top: 16,
          bottom: 16,
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: Breakpoints.getContentWidth(context),
            ),
            child: isDesktop
                ? _buildDesktopLayout(context)
                : isTablet
                    ? _buildTabletLayout(context)
                    : _buildMobileLayout(context),
          ),
        ),
      ),
      floatingActionButton: _buildFAB(context),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AppBar(
      title: ShaderMask(
        shaderCallback: (bounds) => AppColors.primaryGradient.createShader(bounds),
        child: Text(
          l10n.kaloryHelp,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedEntrance(
          child: const KaloryScore(),
        ),
        const SizedBox(height: 8),
        AnimatedEntrance(
          delay: const Duration(milliseconds: 200),
          child: const ActivityRings(),
        ),
        const SizedBox(height: 8),
        AnimatedEntrance(
          delay: const Duration(milliseconds: 300),
          child: const HydrationWave(),
        ),
        const SizedBox(height: 8),
        AnimatedEntrance(
          delay: const Duration(milliseconds: 400),
          child: const MealTimeline(),
        ),
        const SizedBox(height: 8),
        AnimatedEntrance(
          delay: const Duration(milliseconds: 500),
          child: _buildTipCard(context),
        ),
      ],
    );
  }

  Widget _buildTabletLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedEntrance(
          child: const KaloryScore(),
        ),
        const SizedBox(height: 8),
        AnimatedEntrance(
          delay: const Duration(milliseconds: 200),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                flex: 1,
                child: ActivityRings(),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 1,
                child: Column(
                  children: const [
                    HydrationWave(),
                    SizedBox(height: 8),
                    MealTimeline(),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        AnimatedEntrance(
          delay: const Duration(milliseconds: 400),
          child: _buildTipCard(context),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedEntrance(
          child: const KaloryScore(),
        ),
        const SizedBox(height: 8),
        AnimatedEntrance(
          delay: const Duration(milliseconds: 200),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                flex: 1,
                child: ActivityRings(),
              ),
              const SizedBox(width: 24),
              Expanded(
                flex: 1,
                child: Column(
                  children: const [
                    HydrationWave(),
                    SizedBox(height: 8),
                    MealTimeline(),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        AnimatedEntrance(
          delay: const Duration(milliseconds: 400),
          child: _buildTipCard(context),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildTipCard(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final tip = getTodaysTip();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha:0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.lightbulb_outline,
              color: Colors.white,
              size: 32,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.tipOfTheDay,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Colors.white.withValues(alpha:0.9),
                        letterSpacing: 1.2,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  context.read<LocaleProvider>().locale.languageCode == 'ar'
                      ? (tip['text_ar'] ?? tip['text']!)
                      : tip['text']!,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                      ),
                ),
                const SizedBox(height: 6),
                Text(
                  '\u2014 ${tip['source']!}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.white.withValues(alpha:0.7),
                        fontStyle: FontStyle.italic,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFAB(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Semantics(
      button: true,
      label: l10n.quickAdd,
      child: FloatingActionButton.extended(
        tooltip: l10n.quickAdd,
        onPressed: () => _showQuickAddDialog(context),
        icon: const Icon(Icons.add),
        label: Text(l10n.quickAdd),
        backgroundColor: AppColors.accent,
        foregroundColor: Colors.white,
      ),
    );
  }

  String _localizedMealType(AppLocalizations l10n, String type) =>
      helpers.localizedMealType(l10n, type);

  void _showQuickAddDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final nameController = TextEditingController();
    final caloriesController = TextEditingController();
    final proteinController = TextEditingController();
    final carbsController = TextEditingController();
    final fatController = TextEditingController();

    final hour = DateTime.now().hour;
    String mealType;
    if (hour < 11) {
      mealType = 'Breakfast';
    } else if (hour < 15) {
      mealType = 'Lunch';
    } else if (hour < 18) {
      mealType = 'Snack';
    } else {
      mealType = 'Dinner';
    }

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          title: Text(l10n.quickAdd),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<String>(
                  initialValue: mealType,
                  decoration: InputDecoration(labelText: l10n.meal),
                  items: ['Breakfast', 'Lunch', 'Dinner', 'Snack']
                      .map((t) => DropdownMenuItem(value: t, child: Text(_localizedMealType(l10n, t))))
                      .toList(),
                  onChanged: (v) =>
                      setDialogState(() => mealType = v ?? mealType),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: l10n.foodName),
                  textCapitalization: TextCapitalization.words,
                  autofocus: true,
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: caloriesController,
                  decoration: InputDecoration(
                    labelText: l10n.calories,
                    suffixText: l10n.kcalUnit,
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(4),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: proteinController,
                        decoration: InputDecoration(
                          labelText: l10n.protein,
                          suffixText: l10n.gramUnit,
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(3),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: carbsController,
                        decoration: InputDecoration(
                          labelText: l10n.carbs,
                          suffixText: l10n.gramUnit,
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(3),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: fatController,
                        decoration: InputDecoration(
                          labelText: l10n.fat,
                          suffixText: l10n.gramUnit,
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(3),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text(l10n.cancel),
            ),
            FilledButton(
              onPressed: () async {
                if (nameController.text.trim().isEmpty) return;
                if ((int.tryParse(caloriesController.text) ?? 0) <= 0) return;
                Navigator.pop(ctx);
                await _addFood(
                  context,
                  mealType: mealType,
                  name: nameController.text.trim(),
                  calories: int.tryParse(caloriesController.text) ?? 0,
                  protein: int.tryParse(proteinController.text) ?? 0,
                  carbs: int.tryParse(carbsController.text) ?? 0,
                  fat: int.tryParse(fatController.text) ?? 0,
                );
              },
              child: Text(l10n.add),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _addFood(
    BuildContext context, {
    required String mealType,
    required String name,
    required int calories,
    required int protein,
    required int carbs,
    required int fat,
  }) async {
    final mealsProvider = context.read<MealsProvider>();
    final summaryProvider = context.read<SummaryProvider>();
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());

    try {
      final matches = mealsProvider.meals.where((m) => m['meal_type'] == mealType);
      String mealId;
      if (matches.isNotEmpty) {
        mealId = matches.first['id'];
      } else {
        await mealsProvider.createMeal({
          'date': today,
          'mealType': mealType,
          'time': DateFormat('HH:mm').format(DateTime.now()),
        });
        final newMatches = mealsProvider.meals.where((m) => m['meal_type'] == mealType);
        mealId = newMatches.first['id'];
      }

      await mealsProvider.addFoodItem(mealId, {
        'name': name,
        'calories': calories,
        'protein': protein,
        'carbs': carbs,
        'fat': fat,
      });

      await summaryProvider.load();

      if (!context.mounted) return;
      final l10n = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.addedToMeal(name, mealType)),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } catch (e) {
      if (!context.mounted) return;
      final l10n = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.failedToAdd('$e')),
          behavior: SnackBarBehavior.floating,
          backgroundColor: AppColors.error,
        ),
      );
    }
  }
}
