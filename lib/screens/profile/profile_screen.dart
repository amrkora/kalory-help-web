import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../theme/app_theme.dart';
import '../../utils/locale_provider.dart';
import '../../utils/theme_provider.dart';
import '../../providers/profile_provider.dart';
import '../../utils/nutrition_calculator.dart';
import '../../services/export_service.dart';
import '../../services/database_service.dart';
import '../onboarding/onboarding_screen.dart';
import '../../widgets/animated_entrance.dart';
import '../../l10n/app_localizations.dart';
import '../privacy/privacy_policy_screen.dart';
import '../help/help_support_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = Breakpoints.getHorizontalPadding(context);
    final isDesktop = Breakpoints.isDesktop(context);

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
              child: isDesktop
                  ? _buildDesktopLayout(context)
                  : _buildMobileLayout(context),
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
          child: _buildProfileHeader(context),
        ),
        const SizedBox(height: 24),
        AnimatedEntrance(
          delay: const Duration(milliseconds: 100),
          child: _buildDailyGoals(context),
        ),
        const SizedBox(height: 16),
        AnimatedEntrance(
          delay: const Duration(milliseconds: 200),
          child: _buildBodyInfo(context),
        ),
        const SizedBox(height: 16),
        AnimatedEntrance(
          delay: const Duration(milliseconds: 300),
          child: _buildPreferences(context),
        ),
        const SizedBox(height: 16),
        AnimatedEntrance(
          delay: const Duration(milliseconds: 400),
          child: _buildAccountSection(context),
        ),
        const SizedBox(height: 16),
        _buildAppVersion(context),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Column(
      children: [
        AnimatedEntrance(
          child: _buildProfileHeader(context),
        ),
        const SizedBox(height: 24),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                children: [
                  AnimatedEntrance(
                    delay: const Duration(milliseconds: 100),
                    child: _buildDailyGoals(context),
                  ),
                  const SizedBox(height: 16),
                  AnimatedEntrance(
                    delay: const Duration(milliseconds: 200),
                    child: _buildBodyInfo(context),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: Column(
                children: [
                  AnimatedEntrance(
                    delay: const Duration(milliseconds: 300),
                    child: _buildPreferences(context),
                  ),
                  const SizedBox(height: 16),
                  AnimatedEntrance(
                    delay: const Duration(milliseconds: 400),
                    child: _buildAccountSection(context),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildAppVersion(context),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.white.withValues(alpha: 0.2),
            child: const Icon(Icons.person, size: 40, color: Colors.white),
          ),
          const SizedBox(height: 16),
          Text(
            AppLocalizations.of(context)!.myProfile,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }

  // ── Daily Goals ──────────────────────────────────────────────────────

  Widget _buildDailyGoals(BuildContext context) {
    final profile = context.watch<ProfileProvider>();
    final fmt = NumberFormat('#,###');
    final l10n = AppLocalizations.of(context)!;

    final goals = [
      _GoalItem(Icons.local_fire_department, l10n.calories,
          '${fmt.format(profile.calorieGoal)} ${l10n.kcalUnit}', AppColors.accent,
          'calorie_goal', profile.calorieGoal),
      _GoalItem(Icons.fitness_center, l10n.protein, '${profile.proteinGoal}${l10n.gramUnit}',
          const Color(0xFFEC4899), 'protein_goal', profile.proteinGoal),
      _GoalItem(Icons.grain, l10n.carbs, '${profile.carbsGoal}${l10n.gramUnit}',
          const Color(0xFF10B981), 'carbs_goal', profile.carbsGoal),
      _GoalItem(Icons.opacity, l10n.fat, '${profile.fatGoal}${l10n.gramUnit}',
          const Color(0xFF6366F1), 'fat_goal', profile.fatGoal),
      _GoalItem(Icons.eco, l10n.fiber, '${profile.fiberGoal}${l10n.gramUnit}',
          AppColors.success, 'fiber_goal', profile.fiberGoal),
      _GoalItem(Icons.water_drop, l10n.water, '${profile.waterGoal} ${l10n.glassesUnit}',
          AppColors.primary, 'water_goal', profile.waterGoal),
    ];

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
                  AppLocalizations.of(context)!.dailyGoals,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                TextButton(
                  onPressed: () => _showRecalculateDialog(context),
                  child: Text(AppLocalizations.of(context)!.recalculate),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ...goals.map((goal) => _buildGoalRow(context, goal)),
          ],
        ),
      ),
    );
  }

  Widget _buildGoalRow(BuildContext context, _GoalItem goal) {
    return InkWell(
      onTap: () => _showEditGoalDialog(context, goal),
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: goal.color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(goal.icon, color: goal.color, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                goal.label,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            Text(
              goal.displayValue,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(width: 8),
            Icon(
              Icons.chevron_right,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  // ── Edit Single Goal Dialog ──────────────────────────────────────────

  void _showEditGoalDialog(BuildContext context, _GoalItem goal) {
    final profile = context.read<ProfileProvider>();
    final l10n = AppLocalizations.of(context)!;
    final ctrl = TextEditingController(text: goal.rawValue.toString());

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('${l10n.edit} ${goal.label}'),
        content: TextField(
          controller: ctrl,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(
              goal.label == l10n.water ? 2 : 4,
            ),
          ],
          decoration: InputDecoration(
            labelText: goal.label,
            suffixText: goal.label == l10n.calories
                ? l10n.kcalUnit
                : goal.label == l10n.water
                    ? l10n.glassesUnit
                    : l10n.gramUnit,
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () {
              final val = int.tryParse(ctrl.text.trim());
              if (val != null && val > 0) {
                profile.updateGoals({goal.key: val});
              }
              Navigator.pop(ctx);
            },
            child: Text(l10n.save),
          ),
        ],
      ),
    );
  }

  // ── Recalculate Goals Dialog ─────────────────────────────────────────

  void _showRecalculateDialog(BuildContext context) {
    final profile = context.read<ProfileProvider>();
    final l10n = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.recalculateGoals),
        content: Text(l10n.recalculateMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () {
              _recalculateGoals(profile);
              Navigator.pop(ctx);
            },
            child: Text(l10n.recalculate),
          ),
        ],
      ),
    );
  }

  // ── Body Info ────────────────────────────────────────────────────────

  Widget _buildBodyInfo(BuildContext context) {
    final profile = context.watch<ProfileProvider>();
    final l10n = AppLocalizations.of(context)!;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.bodyInfo,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 8),
            _buildEditableInfoRow(
              context,
              icon: Icons.person_outline,
              label: l10n.gender,
              value: _localizedGender(l10n, profile.gender),
              onTap: () => _showEditGenderDialog(context),
            ),
            _buildEditableInfoRow(
              context,
              icon: Icons.height,
              label: l10n.height,
              value: profile.height != null
                  ? '${profile.height!.round()} ${l10n.cmUnit}'
                  : '--',
              onTap: () => _showEditSliderDialog(
                context,
                title: l10n.height,
                unit: l10n.cmUnit,
                currentValue: profile.height ?? 170,
                min: 120,
                max: 220,
                divisions: 100,
                key: 'height',
                isInt: true,
              ),
            ),
            _buildEditableInfoRow(
              context,
              icon: Icons.monitor_weight_outlined,
              label: l10n.weight,
              value: profile.weight != null ? '${profile.weight} ${l10n.kgUnit}' : '--',
              onTap: () => _showEditSliderDialog(
                context,
                title: l10n.weight,
                unit: l10n.kgUnit,
                currentValue: profile.weight ?? 70,
                min: 30,
                max: 200,
                divisions: 170,
                key: 'weight',
                isInt: false,
              ),
            ),
            _buildEditableInfoRow(
              context,
              icon: Icons.cake_outlined,
              label: l10n.age,
              value: profile.age?.toString() ?? '--',
              onTap: () => _showEditAgeDialog(context),
            ),
            _buildEditableInfoRow(
              context,
              icon: Icons.directions_run,
              label: l10n.activityLevel,
              value: _localizedActivityLevel(l10n, profile.activityLevel),
              onTap: () => _showEditActivityDialog(context),
            ),
            _buildEditableInfoRow(
              context,
              icon: Icons.restaurant_menu,
              label: l10n.dietType,
              value: _localizedDietType(l10n, profile.dietType),
              onTap: () => _showEditDietTypeDialog(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEditableInfoRow(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    required VoidCallback onTap,
  }) {
    return Semantics(
      button: true,
      label: '$label: $value. ${AppLocalizations.of(context)!.tapToEdit}',
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              Icon(
                icon,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                size: 20,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  label,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              Text(
                value,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.chevron_right,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Edit Gender Dialog ───────────────────────────────────────────────

  void _showEditGenderDialog(BuildContext context) {
    final profile = context.read<ProfileProvider>();
    final l10n = AppLocalizations.of(context)!;
    String? selected = profile.gender;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          title: Text(l10n.gender),
          content: SegmentedButton<String>(
            segments: [
              ButtonSegment(value: 'male', label: Text(l10n.male)),
              ButtonSegment(value: 'female', label: Text(l10n.female)),
            ],
            selected: {if (selected != null) selected!},
            onSelectionChanged: (v) =>
                setDialogState(() => selected = v.first),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text(l10n.cancel),
            ),
            FilledButton(
              onPressed: () {
                if (selected != null) {
                  profile.updateProfile({'gender': selected});
                  _recalculateGoals(profile);
                }
                Navigator.pop(ctx);
              },
              child: Text(l10n.save),
            ),
          ],
        ),
      ),
    );
  }

  // ── Edit Slider Dialog (Height / Weight) ─────────────────────────────

  void _showEditSliderDialog(
    BuildContext context, {
    required String title,
    required String unit,
    required double currentValue,
    required double min,
    required double max,
    required int divisions,
    required String key,
    required bool isInt,
  }) {
    final profile = context.read<ProfileProvider>();
    final l10n = AppLocalizations.of(context)!;
    double value = currentValue;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          title: Text(title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                isInt ? '${value.round()} $unit' : '${value.toStringAsFixed(1)} $unit',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
              const SizedBox(height: 16),
              Slider(
                value: value,
                min: min,
                max: max,
                divisions: divisions,
                onChanged: (v) => setDialogState(() => value = v),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${min.round()} $unit',
                      style: Theme.of(context).textTheme.bodySmall),
                  Text('${max.round()} $unit',
                      style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text(l10n.cancel),
            ),
            FilledButton(
              onPressed: () {
                profile.updateProfile({
                  key: isInt ? value.round() : double.parse(value.toStringAsFixed(1)),
                });
                _recalculateGoals(profile);
                Navigator.pop(ctx);
              },
              child: Text(l10n.save),
            ),
          ],
        ),
      ),
    );
  }

  // ── Edit Age Dialog ──────────────────────────────────────────────────

  void _showEditAgeDialog(BuildContext context) {
    final profile = context.read<ProfileProvider>();
    final l10n = AppLocalizations.of(context)!;
    final ctrl = TextEditingController(
      text: profile.age?.toString() ?? '',
    );

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.age),
        content: TextField(
          controller: ctrl,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(3),
          ],
          decoration: InputDecoration(
            labelText: l10n.age,
            suffixText: l10n.yearsUnit,
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () {
              final val = int.tryParse(ctrl.text.trim());
              if (val != null && val > 0 && val < 150) {
                profile.updateProfile({'age': val});
                _recalculateGoals(profile);
              }
              Navigator.pop(ctx);
            },
            child: Text(l10n.save),
          ),
        ],
      ),
    );
  }

  // ── Edit Activity Level Dialog ───────────────────────────────────────

  void _showEditActivityDialog(BuildContext context) {
    final profile = context.read<ProfileProvider>();
    final l10n = AppLocalizations.of(context)!;
    String? selected = profile.activityLevel;

    final levels = [
      ('sedentary', l10n.sedentary, l10n.sedentaryDesc),
      ('light', l10n.light, l10n.lightDesc),
      ('moderate', l10n.moderate, l10n.moderateDesc),
      ('active', l10n.active, l10n.activeDesc),
      ('very_active', l10n.veryActive, l10n.veryActiveDesc),
    ];

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          title: Text(l10n.activityLevel),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: levels.map((level) {
                final isSelected = selected == level.$1;
                return ListTile(
                  title: Text(level.$2),
                  subtitle: Text(level.$3),
                  leading: Icon(
                    isSelected
                        ? Icons.check_circle
                        : Icons.circle_outlined,
                    color: isSelected
                        ? Theme.of(ctx).colorScheme.primary
                        : Theme.of(ctx).colorScheme.onSurfaceVariant,
                  ),
                  onTap: () => setDialogState(() => selected = level.$1),
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text(l10n.cancel),
            ),
            FilledButton(
              onPressed: () {
                if (selected != null) {
                  profile.updateProfile({'activity_level': selected});
                  _recalculateGoals(profile);
                }
                Navigator.pop(ctx);
              },
              child: Text(l10n.save),
            ),
          ],
        ),
      ),
    );
  }

  // ── Edit Diet Type Dialog ──────────────────────────────────────────

  void _showEditDietTypeDialog(BuildContext context) {
    final profile = context.read<ProfileProvider>();
    final l10n = AppLocalizations.of(context)!;
    String? selected = profile.dietType;

    final diets = [
      ('omnivore', l10n.omnivore, l10n.omnivoreDesc),
      ('vegetarian', l10n.vegetarian, l10n.vegetarianDesc),
      ('vegan', l10n.vegan, l10n.veganDesc),
      ('pescatarian', l10n.pescatarian, l10n.pescatarianDesc),
    ];

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          title: Text(l10n.dietType),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: diets.map((diet) {
                final isSelected = selected == diet.$1;
                return ListTile(
                  title: Text(diet.$2),
                  subtitle: Text(diet.$3),
                  leading: Icon(
                    isSelected
                        ? Icons.check_circle
                        : Icons.circle_outlined,
                    color: isSelected
                        ? Theme.of(ctx).colorScheme.primary
                        : Theme.of(ctx).colorScheme.onSurfaceVariant,
                  ),
                  onTap: () => setDialogState(() => selected = diet.$1),
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text(l10n.cancel),
            ),
            FilledButton(
              onPressed: () {
                if (selected != null) {
                  profile.updateProfile({'diet_type': selected});
                  _recalculateGoals(profile);
                }
                Navigator.pop(ctx);
              },
              child: Text(l10n.save),
            ),
          ],
        ),
      ),
    );
  }

  // ── Auto-recalculate goals from current profile ────────────────────

  void _recalculateGoals(ProfileProvider profile) {
    final gender = profile.gender ?? 'female';
    final h = profile.height ?? 165;
    final w = profile.weight ?? 70;
    final age = profile.age ?? 30;
    final activity = profile.activityLevel ?? 'moderate';

    String ageRange;
    if (age <= 25) {
      ageRange = '18-25';
    } else if (age <= 35) {
      ageRange = '26-35';
    } else if (age <= 45) {
      ageRange = '36-45';
    } else if (age <= 55) {
      ageRange = '46-55';
    } else if (age <= 65) {
      ageRange = '56-65';
    } else {
      ageRange = '65+';
    }

    final goals = NutritionCalculator.calculateAllGoals(
      w, h, ageRange, gender, activity,
      dietType: profile.dietType,
    );
    profile.updateGoals(goals);
  }

  // ── Helpers ──────────────────────────────────────────────────────────

  String _localizedGender(AppLocalizations l10n, String? gender) {
    switch (gender) {
      case 'male':
        return l10n.male;
      case 'female':
        return l10n.female;
      default:
        return '--';
    }
  }

  String _localizedActivityLevel(AppLocalizations l10n, String? level) {
    switch (level) {
      case 'sedentary':
        return l10n.sedentary;
      case 'light':
        return l10n.light;
      case 'moderate':
        return l10n.moderate;
      case 'active':
        return l10n.active;
      case 'very_active':
        return l10n.veryActive;
      default:
        return l10n.notSet;
    }
  }

  String _localizedDietType(AppLocalizations l10n, String? type) {
    switch (type) {
      case 'omnivore':
        return l10n.omnivore;
      case 'vegetarian':
        return l10n.vegetarian;
      case 'vegan':
        return l10n.vegan;
      case 'pescatarian':
        return l10n.pescatarian;
      default:
        return l10n.notSet;
    }
  }

  // ── Preferences (unchanged) ──────────────────────────────────────────

  Widget _buildPreferences(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    final l10n = AppLocalizations.of(context)!;
    final isArabic = localeProvider.locale.languageCode == 'ar';

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.preferences,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 8),
            ListTile(
              leading: Icon(
                Icons.language,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                size: 20,
              ),
              title: Text(
                l10n.language,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              trailing: Text(
                isArabic ? l10n.arabic : l10n.english,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              contentPadding: EdgeInsets.zero,
              onTap: () => _showLanguageDialog(context),
            ),
          ],
        ),
      ),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    final localeProvider = context.read<LocaleProvider>();
    final l10n = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.chooseLanguage),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(
                localeProvider.locale.languageCode == 'en'
                    ? Icons.check_circle
                    : Icons.circle_outlined,
                color: localeProvider.locale.languageCode == 'en'
                    ? Theme.of(ctx).colorScheme.primary
                    : Theme.of(ctx).colorScheme.onSurfaceVariant,
              ),
              title: const Text('English'),
              onTap: () {
                localeProvider.setLocale(const Locale('en'));
                Navigator.pop(ctx);
              },
            ),
            ListTile(
              leading: Icon(
                localeProvider.locale.languageCode == 'ar'
                    ? Icons.check_circle
                    : Icons.circle_outlined,
                color: localeProvider.locale.languageCode == 'ar'
                    ? Theme.of(ctx).colorScheme.primary
                    : Theme.of(ctx).colorScheme.onSurfaceVariant,
              ),
              title: const Text('العربية'),
              onTap: () {
                localeProvider.setLocale(const Locale('ar'));
                Navigator.pop(ctx);
              },
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildAccountSection(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.account,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 8),
            _buildDarkModeRow(context, l10n),
            const Divider(height: 1),
            _buildAccountRow(context, Icons.download, l10n.exportData,
                onTap: () async {
              final success = await ExportService.exportData();
              if (!context.mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(success
                      ? l10n.dataExported
                      : l10n.exportFailed),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }),
            const Divider(height: 1),
            _buildAccountRow(
                context, Icons.privacy_tip_outlined, l10n.privacyPolicy,
                onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const PrivacyPolicyScreen()),
                    )),
            const Divider(height: 1),
            _buildAccountRow(context, Icons.help_outline, l10n.helpSupport,
                onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const HelpSupportScreen()),
                    )),
            const Divider(height: 1),
            _buildAccountRow(
                context, Icons.delete_forever, l10n.deleteAllData,
                isDestructive: true,
                onTap: () => _showDeleteAllDataDialog(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildDarkModeRow(BuildContext context, AppLocalizations l10n) {
    final themeProvider = context.watch<ThemeProvider>();
    final isDark = themeProvider.themeMode == ThemeMode.dark;
    final isSystem = themeProvider.themeMode == ThemeMode.system;

    return InkWell(
      onTap: () {
        if (isSystem || !isDark) {
          themeProvider.setThemeMode(ThemeMode.dark);
        } else {
          themeProvider.setThemeMode(ThemeMode.light);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Icon(
              isDark ? Icons.dark_mode : Icons.light_mode,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              size: 20,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                l10n.darkMode,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            Semantics(
              toggled: isDark,
              label: l10n.darkMode,
              child: Tooltip(
                message: l10n.darkMode,
                child: Switch(
                  value: isDark,
                  onChanged: (value) {
                    themeProvider
                        .setThemeMode(value ? ThemeMode.dark : ThemeMode.light);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountRow(BuildContext context, IconData icon, String label,
      {bool isDestructive = false, VoidCallback? onTap}) {
    final color = isDestructive
        ? AppColors.error
        : Theme.of(context).colorScheme.onSurfaceVariant;

    return InkWell(
      onTap: onTap ?? () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: isDestructive ? AppColors.error : null,
                    ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: color,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteAllDataDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    // First dialog: warning with explanation
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        icon: const Icon(Icons.warning_amber_rounded,
            color: AppColors.error, size: 48),
        title: Text(l10n.deleteAllDataTitle),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              l10n.deleteAllDataMessage,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              l10n.deleteAllDataWarning,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.error,
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.error,
            ),
            onPressed: () {
              Navigator.pop(ctx);
              // Second dialog: final confirmation
              _showDeleteFinalConfirmDialog(context);
            },
            child: Text(l10n.deleteAllDataConfirm),
          ),
        ],
      ),
    );
  }

  void _showDeleteFinalConfirmDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        icon: const Icon(Icons.delete_forever,
            color: AppColors.error, size: 48),
        title: Text(l10n.deleteAllDataConfirm),
        content: Text(
          l10n.deleteAllDataFinalConfirm,
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.error,
            ),
            onPressed: () async {
              Navigator.pop(ctx);
              await DatabaseService.deleteAllData();
              if (!context.mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(l10n.dataDeleted),
                  behavior: SnackBarBehavior.floating,
                ),
              );
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const OnboardingScreen()),
                (route) => false,
              );
            },
            child: Text(l10n.deleteAllDataConfirm),
          ),
        ],
      ),
    );
  }

  Widget _buildAppVersion(BuildContext context) {
    return Center(
      child: Text(
        AppLocalizations.of(context)!.appVersion,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
      ),
    );
  }
}

class _GoalItem {
  final IconData icon;
  final String label;
  final String displayValue;
  final Color color;
  final String key;
  final int rawValue;

  _GoalItem(this.icon, this.label, this.displayValue, this.color, this.key,
      this.rawValue);
}
