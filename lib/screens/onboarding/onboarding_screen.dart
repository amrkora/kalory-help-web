import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/app_theme.dart';
import '../../utils/nutrition_calculator.dart';
import '../../providers/profile_provider.dart';
import '../../l10n/app_localizations.dart';
import '../navigation/main_navigation_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _pageController = PageController();
  int _currentStep = 0;

  // Collected values
  String? _gender;
  double _height = 170;
  double _weight = 70;
  String? _ageRange;
  String? _activityLevel;
  String? _dietType;
  bool _halalMode = true;

  static const _totalSteps = 7;

  bool get _canProceed {
    switch (_currentStep) {
      case 0:
        return true; // Welcome — always enabled
      case 1:
        return _gender != null;
      case 2:
        return true; // Sliders always have a value
      case 3:
        return _ageRange != null;
      case 4:
        return _activityLevel != null;
      case 5:
        return true;
      case 6:
        return true; // Summary — always enabled
      default:
        return false;
    }
  }

  void _nextPage() {
    if (_currentStep < _totalSteps - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
      setState(() => _currentStep++);
    }
  }

  void _previousPage() {
    if (_currentStep > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
      setState(() => _currentStep--);
    }
  }

  Future<void> _completeOnboarding() async {
    final profile = context.read<ProfileProvider>();

    final age = NutritionCalculator.ageRangeToMidpoint(_ageRange!);

    final profileData = <String, dynamic>{
      'height': _height.round(),
      'weight': _weight,
      'age': age,
      'gender': _gender,
      'activity_level': _activityLevel,
    };
    if (_dietType != null) profileData['diet_type'] = _dietType;
    profileData['halal_mode'] = _halalMode;
    await profile.updateProfile(profileData);

    final goals = NutritionCalculator.calculateAllGoals(
      _weight, _height, _ageRange!, _gender!, _activityLevel!,
      dietType: _dietType,
    );
    await profile.updateGoals(goals);
    await profile.completeOnboarding();

    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const MainNavigationScreen()),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Step dots
            if (_currentStep > 0) _buildStepDots(),
            // Page content
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildWelcomePage(),
                  _buildGenderPage(),
                  _buildMeasurementsPage(),
                  _buildAgeRangePage(),
                  _buildActivityPage(),
                  _buildDietTypePage(),
                  _buildSummaryPage(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Step indicator dots ──────────────────────────────────────────────

  Widget _buildStepDots() {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(_totalSteps - 1, (i) {
          // Steps 1-5 (skip welcome)
          final stepIndex = i + 1;
          final isActive = stepIndex == _currentStep;
          final isCompleted = stepIndex < _currentStep;
          final l10nDots = AppLocalizations.of(context)!;
          return Semantics(
            label: '${l10nDots.stepIndicator(stepIndex, _totalSteps - 1)}${isActive ? l10nDots.stepCurrent : isCompleted ? l10nDots.stepCompleted : ''}',
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: isActive ? 28 : 10,
              height: 10,
              decoration: BoxDecoration(
                color: isActive || isCompleted
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.outlineVariant,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          );
        }),
      ),
    );
  }

  // ── Page 0: Welcome ──────────────────────────────────────────────────

  Widget _buildWelcomePage() {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(32),
            ),
            child: const Icon(Icons.restaurant, size: 56, color: Colors.white),
          ),
          const SizedBox(height: 40),
          Text(
            l10n.welcomeTitle,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            l10n.welcomeSubtitle,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 48),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: FilledButton(
              onPressed: _nextPage,
              style: FilledButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(l10n.getStarted, style: const TextStyle(fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }

  // ── Page 1: Gender ───────────────────────────────────────────────────

  Widget _buildGenderPage() {
    final l10n = AppLocalizations.of(context)!;
    return _buildStepPage(
      title: l10n.biologicalSex,
      subtitle: l10n.biologicalSexSubtitle,
      content: Row(
        children: [
          Expanded(
            child: _GenderCard(
              icon: Icons.male,
              label: l10n.male,
              selected: _gender == 'male',
              onTap: () => setState(() => _gender = 'male'),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _GenderCard(
              icon: Icons.female,
              label: l10n.female,
              selected: _gender == 'female',
              onTap: () => setState(() => _gender = 'female'),
            ),
          ),
        ],
      ),
    );
  }

  // ── Page 2: Measurements ─────────────────────────────────────────────

  Widget _buildMeasurementsPage() {
    final l10n = AppLocalizations.of(context)!;
    return _buildStepPage(
      title: l10n.yourMeasurements,
      subtitle: l10n.measurementsSubtitle,
      content: Column(
        children: [
          // Height
          _buildSliderSection(
            label: l10n.height,
            value: '${_height.round()} ${l10n.cmUnit}',
            slider: Slider(
              value: _height,
              min: 120,
              max: 220,
              divisions: 100,
              onChanged: (v) => setState(() => _height = v),
            ),
          ),
          const SizedBox(height: 32),
          // Weight
          _buildSliderSection(
            label: l10n.weight,
            value: '${_weight.round()} ${l10n.kgUnit}',
            slider: Slider(
              value: _weight,
              min: 30,
              max: 200,
              divisions: 170,
              onChanged: (v) => setState(() => _weight = v),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliderSection({
    required String label,
    required String value,
    required Widget slider,
  }) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: Theme.of(context).textTheme.titleMedium),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                value,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        slider,
      ],
    );
  }

  // ── Page 3: Age Range ────────────────────────────────────────────────

  Widget _buildAgeRangePage() {
    const ranges = ['18-25', '26-35', '36-45', '46-55', '56-65', '65+'];
    final l10n = AppLocalizations.of(context)!;

    return _buildStepPage(
      title: l10n.ageRangeQuestion,
      subtitle: l10n.ageRangeSubtitle,
      content: Wrap(
        spacing: 12,
        runSpacing: 12,
        children: ranges.map((range) {
          final selected = _ageRange == range;
          return ChoiceChip(
            label: Text(
              range,
              style: TextStyle(
                fontSize: 16,
                fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
                color: selected
                    ? Theme.of(context).colorScheme.onPrimary
                    : null,
              ),
            ),
            selected: selected,
            onSelected: (_) => setState(() => _ageRange = range),
            selectedColor: Theme.of(context).colorScheme.primary,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          );
        }).toList(),
      ),
    );
  }

  // ── Page 4: Activity Level ───────────────────────────────────────────

  Widget _buildActivityPage() {
    final l10n = AppLocalizations.of(context)!;
    final levels = [
      _ActivityOption('sedentary', Icons.weekend, l10n.sedentary,
          l10n.sedentaryDesc),
      _ActivityOption('light', Icons.directions_walk, l10n.light,
          l10n.lightDesc),
      _ActivityOption('moderate', Icons.directions_run, l10n.moderate,
          l10n.moderateDesc),
      _ActivityOption('active', Icons.fitness_center, l10n.active,
          l10n.activeDesc),
      _ActivityOption('very_active', Icons.sports_gymnastics, l10n.veryActive,
          l10n.veryActiveDesc),
    ];

    return _buildStepPage(
      title: l10n.activityQuestion,
      subtitle: l10n.activitySubtitle,
      content: Column(
        children: levels.map((level) {
          final selected = _activityLevel == level.key;
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Material(
              color: selected
                  ? Theme.of(context).colorScheme.primaryContainer
                  : Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(14),
              child: InkWell(
                borderRadius: BorderRadius.circular(14),
                onTap: () => setState(() => _activityLevel = level.key),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Icon(
                        level.icon,
                        color: selected
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.onSurfaceVariant,
                        size: 28,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              level.label,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              level.description,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      if (selected)
                        Icon(Icons.check_circle,
                            color: Theme.of(context).colorScheme.primary),
                    ],
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // ── Page 5: Diet Type ───────────────────────────────────────────────

  Widget _buildDietTypePage() {
    final l10n = AppLocalizations.of(context)!;
    final diets = [
      _ActivityOption('omnivore', Icons.restaurant, l10n.omnivore,
          l10n.omnivoreDesc),
      _ActivityOption('vegetarian', Icons.eco, l10n.vegetarian,
          l10n.vegetarianDesc),
      _ActivityOption('vegan', Icons.spa, l10n.vegan,
          l10n.veganDesc),
      _ActivityOption('pescatarian', Icons.set_meal, l10n.pescatarian,
          l10n.pescatarianDesc),
    ];

    return _buildStepPage(
      title: l10n.dietTypeQuestion,
      subtitle: l10n.dietTypeSubtitle,
      content: Column(
        children: [
          ...diets.map((diet) {
            final selected = _dietType == diet.key;
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Material(
                color: selected
                    ? Theme.of(context).colorScheme.primaryContainer
                    : Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(14),
                child: InkWell(
                  borderRadius: BorderRadius.circular(14),
                  onTap: () => setState(() => _dietType = diet.key),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Icon(
                          diet.icon,
                          color: selected
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.onSurfaceVariant,
                          size: 28,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                diet.label,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                diet.description,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurfaceVariant,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        if (selected)
                          Icon(Icons.check_circle,
                              color: Theme.of(context).colorScheme.primary),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
          const SizedBox(height: 8),
          Material(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(14),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  Icon(
                    Icons.mosque,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    size: 28,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.halal,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          l10n.halalDesc,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurfaceVariant,
                              ),
                        ),
                      ],
                    ),
                  ),
                  Switch(
                    value: _halalMode,
                    onChanged: (value) => setState(() => _halalMode = value),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Page 6: Summary ──────────────────────────────────────────────────

  Widget _buildSummaryPage() {
    final l10n = AppLocalizations.of(context)!;
    // Calculate goals for display
    final goals = (_gender != null &&
            _ageRange != null &&
            _activityLevel != null)
        ? NutritionCalculator.calculateAllGoals(
            _weight, _height, _ageRange!, _gender!, _activityLevel!,
            dietType: _dietType)
        : <String, int>{};

    final summaryItems = [
      _SummaryRow(Icons.local_fire_department, l10n.calories,
          '${goals['calorie_goal'] ?? '--'} ${l10n.kcalUnit}', AppColors.accent),
      _SummaryRow(Icons.fitness_center, l10n.protein,
          '${goals['protein_goal'] ?? '--'}${l10n.gramUnit}', const Color(0xFFEC4899)),
      _SummaryRow(Icons.grain, l10n.carbs,
          '${goals['carbs_goal'] ?? '--'}${l10n.gramUnit}', const Color(0xFF10B981)),
      _SummaryRow(Icons.opacity, l10n.fat,
          '${goals['fat_goal'] ?? '--'}${l10n.gramUnit}', const Color(0xFF6366F1)),
      _SummaryRow(Icons.eco, l10n.fiber,
          '${goals['fiber_goal'] ?? '--'}${l10n.gramUnit}', AppColors.success),
      _SummaryRow(Icons.water_drop, l10n.water,
          '${goals['water_goal'] ?? '--'} ${l10n.glassesUnit}', AppColors.primary),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 32),
                  Text(
                    l10n.yourDailyGoals,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    l10n.goalsRecommendation,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  ...summaryItems.map((item) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: item.color.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(item.icon, color: item.color, size: 22),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(item.label,
                                  style: Theme.of(context).textTheme.bodyLarge),
                            ),
                            Text(
                              item.value,
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                      )),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: FilledButton(
              onPressed: _completeOnboarding,
              style: FilledButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(l10n.letsGo, style: const TextStyle(fontSize: 16)),
            ),
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: _previousPage,
            child: Text(l10n.goBack),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  // ── Shared step page layout ──────────────────────────────────────────

  Widget _buildStepPage({
    required String title,
    required String subtitle,
    required Widget content,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 32),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
          const SizedBox(height: 32),
          Expanded(child: SingleChildScrollView(child: content)),
          // Navigation buttons
          Row(
            children: [
              if (_currentStep > 1)
                TextButton(
                  onPressed: _previousPage,
                  child: Text(AppLocalizations.of(context)!.back),
                ),
              const Spacer(),
              FilledButton(
                onPressed: _canProceed ? _nextPage : null,
                child: Text(AppLocalizations.of(context)!.next),
              ),
            ],
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

// ── Helper classes ────────────────────────────────────────────────────

class _GenderCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _GenderCard({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected
          ? Theme.of(context).colorScheme.primaryContainer
          : Theme.of(context).colorScheme.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 56,
                color: selected
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              const SizedBox(height: 12),
              Text(
                label,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: selected
                          ? Theme.of(context).colorScheme.primary
                          : null,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActivityOption {
  final String key;
  final IconData icon;
  final String label;
  final String description;
  _ActivityOption(this.key, this.icon, this.label, this.description);
}

class _SummaryRow {
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  _SummaryRow(this.icon, this.label, this.value, this.color);
}
