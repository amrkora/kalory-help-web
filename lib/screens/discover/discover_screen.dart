import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../theme/app_theme.dart';
import '../../providers/profile_provider.dart';
import '../../providers/recipes_provider.dart';
import '../../widgets/animated_entrance.dart';
import '../../l10n/app_localizations.dart';
import '../../utils/localized_helpers.dart' as helpers;

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  int _selectedCategory = 0;
  final List<String> _categoryKeys = [
    'All',
    'Breakfast',
    'Lunch',
    'Dinner',
    'Snack',
    'Dessert',
  ];

  String _localizedCategory(AppLocalizations l10n, String key) =>
      helpers.localizedMealType(l10n, key);

  String _localizedDifficulty(AppLocalizations l10n, String difficulty) {
    switch (difficulty) {
      case 'Easy': return l10n.difficultyEasy;
      case 'Medium': return l10n.difficultyMedium;
      case 'Hard': return l10n.difficultyHard;
      default: return difficulty;
    }
  }

  String _recipeField(dynamic recipe, String field, BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    if (locale == 'ar' && recipe['${field}_ar'] != null) {
      return recipe['${field}_ar'].toString();
    }
    return (recipe[field] ?? '').toString();
  }

  List<String> _recipeSteps(dynamic recipe, BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    if (locale == 'ar' && recipe['steps_ar'] != null) {
      return List<String>.from(recipe['steps_ar']);
    }
    return List<String>.from(recipe['steps'] ?? []);
  }

  final _searchController = TextEditingController();

  static const _meatKw = r'\b(?:chicken|beef|pork|lamb|mutton|veal|venison|bacon|ham|sausage|turkey|duck|goose|pheasant|rabbit|pancetta)\b';
  static const _fishKw = r'\b(?:fish|salmon|tuna|cod|prawn|prawns|shrimp|crab|lobster|anchovy|anchovies|mackerel|sardine|trout|haddock|herring|squid)\b';
  static const _dairyKw = r'\b(?:cheese|milk|yogurt|yoghurt|cream|ghee|whey|cottage)\b';
  static const _eggKw = r'\beggs?\b';

  static final _veganFilter = RegExp('$_meatKw|$_fishKw|$_dairyKw|$_eggKw', caseSensitive: false);
  static final _vegetarianFilter = RegExp('$_meatKw|$_fishKw', caseSensitive: false);
  static final _pescatarianFilter = RegExp(_meatKw, caseSensitive: false);

  List<dynamic> _filterByDiet(List<dynamic> recipes, String? dietType) {
    RegExp? pattern;
    switch (dietType) {
      case 'vegan':
        pattern = _veganFilter;
        break;
      case 'vegetarian':
        pattern = _vegetarianFilter;
        break;
      case 'pescatarian':
        pattern = _pescatarianFilter;
        break;
      default:
        return recipes;
    }
    return recipes.where((r) => !pattern!.hasMatch((r['name'] ?? '').toString())).toList();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RecipesProvider>().loadAll();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // ─── Category visuals ───
  static const _categoryGradients = <String, List<Color>>{
    'Breakfast': [Color(0xFFF59E0B), Color(0xFFEF4444)],
    'Lunch': [Color(0xFF10B981), Color(0xFF059669)],
    'Dinner': [Color(0xFF4BA3C7), Color(0xFF6366F1)],
    'Snack': [Color(0xFF8B5CF6), Color(0xFFEC4899)],
    'Dessert': [Color(0xFFEC4899), Color(0xFFF59E0B)],
  };

  static const _categoryIcons = <String, IconData>{
    'Breakfast': Icons.egg_alt_rounded,
    'Lunch': Icons.lunch_dining_rounded,
    'Dinner': Icons.dinner_dining_rounded,
    'Snack': Icons.cookie_rounded,
    'Dessert': Icons.cake_rounded,
  };

  LinearGradient _gradientFor(String category) {
    final colors = _categoryGradients[category] ??
        [AppColors.primary, AppColors.secondary];
    return LinearGradient(
      colors: colors,
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }

  IconData _iconFor(String category) {
    return _categoryIcons[category] ?? Icons.restaurant_rounded;
  }

  // ─── Source styling ───
  Color _sourceColor(String source) {
    switch (source) {
      case 'BBC Good Food':
        return const Color(0xFF8B4513);
      case 'Jamie Oliver':
        return const Color(0xFF2E7D32);
      case 'NHS':
        return const Color(0xFF005EB8);
      default:
        return AppColors.primary;
    }
  }

  Widget _buildSourceBadge(BuildContext context, String source) {
    final color = _sourceColor(source);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        source,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
              fontSize: 10,
            ),
      ),
    );
  }

  Color _difficultyColor(String difficulty) {
    switch (difficulty) {
      case 'Easy':
        return AppColors.success;
      case 'Medium':
        return AppColors.warning;
      case 'Hard':
        return AppColors.error;
      default:
        return AppColors.success;
    }
  }

  // ─── Detail bottom sheet ───
  void _showRecipeDetail(BuildContext context, dynamic recipe) {
    final category = (recipe['category'] ?? 'Dinner').toString();
    final source = (recipe['source'] ?? '').toString();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => FractionallySizedBox(
        heightFactor: 0.85,
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(ctx).colorScheme.surface,
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            children: [
              // Hero image header
              Container(
                height: 220,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: _gradientFor(category),
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: Stack(
                  children: [
                    // Real image
                    if ((recipe['image_url'] ?? '').toString().isNotEmpty)
                      Positioned.fill(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(24)),
                          child: Image.network(
                            recipe['image_url'],
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Center(
                              child: Icon(_iconFor(category),
                                  size: 64, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    // Dark overlay for readability
                    Positioned.fill(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(24)),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withValues(alpha: 0.1),
                              Colors.black.withValues(alpha: 0.5),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Handle bar
                    Positioned(
                      top: 10,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Container(
                          width: 40,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.5),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                    ),
                    // Close button
                    Positioned(
                      top: 8,
                      right: 12,
                      child: IconButton(
                        tooltip: AppLocalizations.of(ctx)!.close,
                        icon: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.2),
                            shape: BoxShape.circle,
                          ),
                          child:
                              const Icon(Icons.close, color: Colors.white, size: 20),
                        ),
                        onPressed: () => Navigator.pop(ctx),
                      ),
                    ),
                    // Category badge on image
                    Positioned(
                      bottom: 16,
                      left: 20,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.25),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          _localizedCategory(AppLocalizations.of(ctx)!, category),
                          style:
                              Theme.of(ctx).textTheme.labelSmall?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.5,
                                  ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Source + difficulty row
                      Row(
                        children: [
                          if (source.isNotEmpty) ...[
                            _buildSourceBadge(ctx, source),
                            const SizedBox(width: 8),
                          ],
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: _difficultyColor(
                                      recipe['difficulty'] ?? 'Easy')
                                  .withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              _localizedDifficulty(AppLocalizations.of(ctx)!, recipe['difficulty'] ?? 'Easy'),
                              style: Theme.of(ctx)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                    color: _difficultyColor(
                                        recipe['difficulty'] ?? 'Easy'),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 10,
                                  ),
                            ),
                          ),
                          const Spacer(),
                          // Prep time + servings
                          Row(
                            children: [
                              Icon(Icons.timer_outlined,
                                  size: 14,
                                  color: Theme.of(ctx)
                                      .colorScheme
                                      .onSurfaceVariant),
                              const SizedBox(width: 3),
                              Text(
                                '${recipe['prep_time']} ${AppLocalizations.of(ctx)!.minuteShort}',
                                style: Theme.of(ctx)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                        color: Theme.of(ctx)
                                            .colorScheme
                                            .onSurfaceVariant),
                              ),
                              const SizedBox(width: 10),
                              Icon(Icons.people_outline,
                                  size: 14,
                                  color: Theme.of(ctx)
                                      .colorScheme
                                      .onSurfaceVariant),
                              const SizedBox(width: 3),
                              Text(
                                '${recipe['servings']}',
                                style: Theme.of(ctx)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                        color: Theme.of(ctx)
                                            .colorScheme
                                            .onSurfaceVariant),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Name
                      Text(
                        _recipeField(recipe, 'name', ctx),
                        style: Theme.of(ctx)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),

                      // Description
                      if (_recipeField(recipe, 'description', ctx)
                          .isNotEmpty) ...[
                        const SizedBox(height: 10),
                        Text(
                          _recipeField(recipe, 'description', ctx),
                          style:
                              Theme.of(ctx).textTheme.bodyMedium?.copyWith(
                                    color: Theme.of(ctx)
                                        .colorScheme
                                        .onSurfaceVariant,
                                    height: 1.5,
                                  ),
                        ),
                      ],
                      const SizedBox(height: 24),

                      // Nutrition card
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            _gradientFor(category)
                                .colors[0]
                                .withValues(alpha: 0.08),
                            _gradientFor(category)
                                .colors[1]
                                .withValues(alpha: 0.08),
                          ]),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: _gradientFor(category)
                                .colors[0]
                                .withValues(alpha: 0.15),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(ctx)!.nutritionPerServing,
                              style: Theme.of(ctx)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                _nutrientCircle(ctx, '${recipe['calories']}',
                                    AppLocalizations.of(ctx)!.kcalUnit, AppColors.accent),
                                _nutrientCircle(
                                    ctx,
                                    '${recipe['protein']}${AppLocalizations.of(ctx)!.gramUnit}',
                                    AppLocalizations.of(ctx)!.protein,
                                    const Color(0xFFEC4899)),
                                _nutrientCircle(
                                    ctx,
                                    '${recipe['carbs']}${AppLocalizations.of(ctx)!.gramUnit}',
                                    AppLocalizations.of(ctx)!.carbs,
                                    const Color(0xFF10B981)),
                                _nutrientCircle(
                                    ctx,
                                    '${recipe['fat']}${AppLocalizations.of(ctx)!.gramUnit}',
                                    AppLocalizations.of(ctx)!.fat,
                                    const Color(0xFF6366F1)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Method / Steps
                      if (_recipeSteps(recipe, ctx).isNotEmpty) ...[
                        const SizedBox(height: 24),
                        Text(
                          AppLocalizations.of(ctx)!.method,
                          style: Theme.of(ctx)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 12),
                        ...List.generate(
                          _recipeSteps(recipe, ctx).length,
                          (i) {
                            final step = _recipeSteps(recipe, ctx)[i];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 28,
                                    height: 28,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: _gradientFor(category),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      '${i + 1}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 4),
                                      child: Text(
                                        step,
                                        style: Theme.of(ctx)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              height: 1.5,
                                              color: Theme.of(ctx)
                                                  .colorScheme
                                                  .onSurface
                                                  .withValues(alpha: 0.8),
                                            ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                      // View full recipe link
                      if ((recipe['source_url'] ?? '')
                          .toString()
                          .isNotEmpty) ...[
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton.icon(
                            onPressed: () async {
                              final url =
                                  Uri.parse(recipe['source_url'].toString());
                              if (await canLaunchUrl(url)) {
                                await launchUrl(url,
                                    mode: LaunchMode.externalApplication);
                              }
                            },
                            icon: Icon(Icons.open_in_new,
                                size: 18,
                                color: _sourceColor(source)),
                            label: Text(
                              AppLocalizations.of(ctx)!.viewOnSource(source),
                              style: TextStyle(
                                color: _sourceColor(source),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(
                                  color:
                                      _sourceColor(source).withValues(alpha: 0.4)),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _nutrientCircle(
      BuildContext context, String value, String label, Color color) {
    return Expanded(
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color.withValues(alpha: 0.12),
            ),
            alignment: Alignment.center,
            child: Text(
              value,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
        ],
      ),
    );
  }

  // ─── Main build ───
  @override
  Widget build(BuildContext context) {
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
                AnimatedEntrance(
                  child: _buildHeader(context),
                ),
                const SizedBox(height: 20),
                _buildSearchBar(context),
                const SizedBox(height: 16),
                _buildCategoryFilters(context),
                const SizedBox(height: 24),
                AnimatedEntrance(
                  delay: const Duration(milliseconds: 100),
                  child: _buildFeaturedSection(context),
                ),
                const SizedBox(height: 28),
                AnimatedEntrance(
                  delay: const Duration(milliseconds: 200),
                  child: _buildAllRecipes(context),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
      ),
    );
  }

  // ─── Header ───
  Widget _buildHeader(BuildContext context) {
    final recipesProvider = context.watch<RecipesProvider>();
    final dietType = context.watch<ProfileProvider>().dietType;
    final total = _filterByDiet(recipesProvider.recipes, dietType).length;
    final l10n = AppLocalizations.of(context)!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShaderMask(
                shaderCallback: (bounds) =>
                    AppColors.primaryGradient.createShader(bounds),
                child: Text(
                  l10n.discoverTitle,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                l10n.recipesToExplore(total),
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        // Source legend
        Row(
          children: [
            _sourceIndicator(context, 'BBC', const Color(0xFF8B4513)),
            const SizedBox(width: 6),
            _sourceIndicator(context, 'JO', const Color(0xFF2E7D32)),
            const SizedBox(width: 6),
            _sourceIndicator(context, 'NHS', const Color(0xFF005EB8)),
          ],
        ),
      ],
    );
  }

  Widget _sourceIndicator(BuildContext context, String label, Color color) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        shape: BoxShape.circle,
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w700,
              fontSize: 8,
            ),
      ),
    );
  }

  // ─── Search ───
  Widget _buildSearchBar(BuildContext context) {
    return TextField(
      controller: _searchController,
      onChanged: (value) {
        context.read<RecipesProvider>().load(search: value);
      },
      decoration: InputDecoration(
        hintText: AppLocalizations.of(context)!.searchRecipes,
        prefixIcon: const Icon(Icons.search),
        suffixIcon: _searchController.text.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.clear),
                tooltip: AppLocalizations.of(context)!.clearSearch,
                onPressed: () {
                  _searchController.clear();
                  context.read<RecipesProvider>().load();
                  setState(() {});
                },
              )
            : null,
      ),
    );
  }

  // ─── Category filters ───
  Widget _buildCategoryFilters(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(_categoryKeys.length, (index) {
          final selected = _selectedCategory == index;
          return Padding(
            padding: const EdgeInsetsDirectional.only(end: 8),
            child: FilterChip(
              label: Text(_localizedCategory(l10n, _categoryKeys[index])),
              selected: selected,
              onSelected: (_) {
                setState(() => _selectedCategory = index);
                final category = index == 0 ? null : _categoryKeys[index];
                context.read<RecipesProvider>().load(category: category);
              },
              selectedColor: AppColors.primaryContainer,
              checkmarkColor: AppColors.primary,
              labelStyle: TextStyle(
                color: selected ? AppColors.primary : null,
                fontWeight: selected ? FontWeight.w600 : null,
              ),
            ),
          );
        }),
      ),
    );
  }

  // ─── Featured section ───
  Widget _buildFeaturedSection(BuildContext context) {
    final recipesProvider = context.watch<RecipesProvider>();
    final dietType = context.watch<ProfileProvider>().dietType;
    final featured = _filterByDiet(recipesProvider.featured, dietType);
    if (featured.isEmpty) return const SizedBox.shrink();

    final recipe = featured[0];
    final category = (recipe['category'] ?? 'Dinner').toString();
    final source = (recipe['source'] ?? '').toString();

    return GestureDetector(
      onTap: () => _showRecipeDetail(context, recipe),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: _gradientFor(category),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: _gradientFor(category).colors[0].withValues(alpha: 0.3),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Background decoration
            Positioned(
              right: -10,
              bottom: -10,
              child: Icon(_iconFor(category),
                  size: 140, color: Colors.white.withValues(alpha: 0.1)),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                AppLocalizations.of(context)!.featured,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall
                                    ?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 1,
                                      fontSize: 10,
                                    ),
                              ),
                            ),
                            if (source.isNotEmpty) ...[
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  source,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall
                                      ?.copyWith(
                                        color: Colors.white
                                            .withValues(alpha: 0.9),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 10,
                                      ),
                                ),
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          _recipeField(recipe, 'name', context),
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _recipeField(recipe, 'description', context),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                color: Colors.white.withValues(alpha: 0.85),
                                height: 1.4,
                              ),
                        ),
                        const SizedBox(height: 14),
                        Row(
                          children: [
                            _featureBadge(context, Icons.local_fire_department,
                                '${recipe['calories']} ${AppLocalizations.of(context)!.kcalUnit}'),
                            const SizedBox(width: 8),
                            _featureBadge(context, Icons.timer,
                                '${recipe['prep_time']} ${AppLocalizations.of(context)!.minuteShort}'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white.withValues(alpha: 0.2),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: (recipe['image_url'] ?? '').toString().isNotEmpty
                          ? Image.network(
                              recipe['image_url'],
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Icon(
                                  _iconFor(category),
                                  color: Colors.white,
                                  size: 36),
                            )
                          : Icon(_iconFor(category),
                              color: Colors.white, size: 36),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _featureBadge(BuildContext context, IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: Colors.white),
          const SizedBox(width: 4),
          Text(
            text,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 11,
                ),
          ),
        ],
      ),
    );
  }

  // ─── All recipes (list-style cards) ───
  Widget _buildAllRecipes(BuildContext context) {
    final recipesProvider = context.watch<RecipesProvider>();
    final dietType = context.watch<ProfileProvider>().dietType;
    final all = _filterByDiet(recipesProvider.recipes, dietType);
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(l10n.allRecipes,
                style: Theme.of(context).textTheme.titleLarge),
            Text(
              l10n.recipesCount(all.length),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        if (all.isEmpty && !recipesProvider.loading)
          Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                children: [
                  Icon(Icons.search_off_rounded,
                      size: 48,
                      color: Theme.of(context).colorScheme.onSurfaceVariant),
                  const SizedBox(height: 12),
                  Text(
                    l10n.noRecipesFound,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color:
                              Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                ],
              ),
            ),
          )
        else
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: all.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) => AnimatedEntrance(
              delay: Duration(milliseconds: (50 * index).clamp(0, 400)),
              child: _buildRecipeListCard(context, all[index]),
            ),
          ),
      ],
    );
  }

  Widget _buildRecipeListCard(BuildContext context, dynamic recipe) {
    final category = (recipe['category'] ?? 'Dinner').toString();
    final difficulty = (recipe['difficulty'] ?? 'Easy').toString();
    final source = (recipe['source'] ?? '').toString();
    final description = _recipeField(recipe, 'description', context);
    final l10n = AppLocalizations.of(context)!;

    return GestureDetector(
      onTap: () => _showRecipeDetail(context, recipe),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Left image section
            Container(
              width: 110,
              height: 130,
              decoration: BoxDecoration(
                gradient: _gradientFor(category),
                borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(16)),
              ),
              child: Stack(
                children: [
                  if ((recipe['image_url'] ?? '').toString().isNotEmpty)
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.horizontal(
                            left: Radius.circular(16)),
                        child: Image.network(
                          recipe['image_url'],
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Center(
                            child: Icon(_iconFor(category),
                                size: 36, color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  else
                    Center(
                      child: Icon(_iconFor(category),
                          size: 36, color: Colors.white),
                    ),
                  // Calories badge
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        '${recipe['calories']}',
                        style:
                            Theme.of(context).textTheme.labelSmall?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 10,
                                ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Right content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Title
                    Text(
                      _recipeField(recipe, 'name', context),
                      style:
                          Theme.of(context).textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),

                    // Description
                    if (description.isNotEmpty)
                      Text(
                        description,
                        style:
                            Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurfaceVariant,
                                  height: 1.3,
                                ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    const SizedBox(height: 8),

                    // Bottom row: source + difficulty + prep time + macros
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              if (source.isNotEmpty) ...[
                                Flexible(
                                    child: _buildSourceBadge(
                                        context, source)),
                                const SizedBox(width: 6),
                              ],
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: _difficultyColor(difficulty)
                                      .withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  _localizedDifficulty(l10n, difficulty),
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall
                                      ?.copyWith(
                                        color:
                                            _difficultyColor(difficulty),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 9,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 6),
                        Icon(Icons.timer_outlined,
                            size: 12,
                            color: Theme.of(context)
                                .colorScheme
                                .onSurfaceVariant),
                        const SizedBox(width: 2),
                        Text(
                          '${recipe['prep_time']} ${l10n.minuteShort}',
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurfaceVariant,
                                fontSize: 10,
                              ),
                        ),
                        const SizedBox(width: 8),
                        _macroLabel(context, 'P${recipe['protein']}',
                            const Color(0xFFEC4899)),
                        const SizedBox(width: 3),
                        _macroLabel(context, 'C${recipe['carbs']}',
                            const Color(0xFF10B981)),
                        const SizedBox(width: 3),
                        _macroLabel(context, 'F${recipe['fat']}',
                            const Color(0xFF6366F1)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _macroLabel(BuildContext context, String text, Color color) {
    return Text(
      text,
      style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: color,
            fontWeight: FontWeight.w700,
            fontSize: 9,
          ),
    );
  }
}
