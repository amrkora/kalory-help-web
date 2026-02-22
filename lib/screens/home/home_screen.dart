import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../l10n/app_localizations.dart';
import '../../data/seed_tips.dart';
import '../../utils/locale_provider.dart';
import '../../theme/app_theme.dart';
import '../../widgets/kalory_score.dart';
import '../../widgets/activity_rings.dart';
import '../../widgets/hydration_wave.dart';
import '../../widgets/meal_timeline.dart';
import '../../widgets/animated_entrance.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final hour = DateTime.now().hour;
    final greeting = hour < 12
        ? l10n.goodMorning
        : hour < 18
            ? l10n.goodAfternoon
            : l10n.goodEvening;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShaderMask(
          shaderCallback: (bounds) =>
              AppColors.primaryGradient.createShader(bounds),
          child: Text(
            l10n.kaloryHelp,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          greeting,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
      ],
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

}
