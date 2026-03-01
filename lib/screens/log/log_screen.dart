import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../theme/app_theme.dart';
import '../../providers/meals_provider.dart';
import '../../providers/profile_provider.dart';
import '../../providers/summary_provider.dart';
import '../../services/database_service.dart';
import '../../services/food_database.dart';
import '../../widgets/animated_entrance.dart';
import '../../l10n/app_localizations.dart';
import '../../utils/localized_helpers.dart' as helpers;

class LogScreen extends StatefulWidget {
  const LogScreen({super.key});

  @override
  State<LogScreen> createState() => _LogScreenState();
}

class _LogScreenState extends State<LogScreen> {
  int _selectedMealType = -1; // -1 = All
  final List<String> _mealTypeKeys = ['All', 'Breakfast', 'Lunch', 'Dinner', 'Snack'];

  String _localizedMealType(AppLocalizations l10n, String type) =>
      helpers.localizedMealType(l10n, type);
  String _searchQuery = '';
  final _searchController = TextEditingController();
  List<dynamic> _searchResults = [];
  bool _searchLoading = false;
  Timer? _searchDebounce;

  static const Map<String, Map<String, dynamic>> _quickFoodData = {
    'Banana': {'calories': 105, 'protein': 1, 'carbs': 27, 'fat': 0},
    'Chicken Breast': {'calories': 165, 'protein': 31, 'carbs': 0, 'fat': 4, 'diet': 'omnivore'},
    'Rice': {'calories': 206, 'protein': 4, 'carbs': 45, 'fat': 0},
    'Eggs': {'calories': 155, 'protein': 13, 'carbs': 1, 'fat': 11, 'diet': 'vegetarian'},
    'Oatmeal': {'calories': 150, 'protein': 5, 'carbs': 27, 'fat': 3},
    'Apple': {'calories': 95, 'protein': 0, 'carbs': 25, 'fat': 0},
    'Yogurt': {'calories': 100, 'protein': 17, 'carbs': 6, 'fat': 1, 'diet': 'vegetarian'},
  };

  static String _localizedFoodName(AppLocalizations l10n, String key) =>
      helpers.localizedFoodName(l10n, key);

  /// Returns the localized food name from a database entry based on current locale.
  static String _foodName(dynamic food, Locale locale) {
    if (locale.languageCode == 'ar') {
      return (food['n_ar'] as String?) ?? food['n'] ?? '';
    }
    return food['n'] ?? '';
  }

  /// Returns the localized food category from a database entry based on current locale.
  static String _foodCategory(dynamic food, Locale locale) {
    if (locale.languageCode == 'ar') {
      return (food['c_ar'] as String?) ?? food['c'] ?? '';
    }
    return food['c'] ?? '';
  }


  static const _meatKeywords = r'\b(?:chicken|beef|pork|lamb|mutton|veal|venison|bacon|ham|sausage|turkey|duck|goose|pheasant|rabbit)\b';
  static const _fishKeywords = r'\b(?:fish|salmon|tuna|cod|prawn|prawns|shrimp|crab|lobster|anchovy|anchovies|mackerel|sardine|trout|haddock|herring|squid)\b';
  static const _dairyKeywords = r'\b(?:cheese|milk|yogurt|yoghurt|cream|ghee|whey)\b';
  static const _eggKeywords = r'\beggs?\b';
  static const _porkKeywords = r'\b(?:pork|bacon|ham|lard|suet|tallow|dripping|pancetta|prosciutto|salami|pepperoni|chorizo)\b';
  static const _alcoholKeywords = r'\b(?:wine|beer|ale|vodka|whiskey|whisky|rum|gin|tequila|brandy|champagne|cocktail|liqueur|liquor|bourbon|sake|mead|cider|sangria|prosecco|martini|margarita|mojito|absinthe|vermouth|aperol|spritz)\b';

  static final _veganNameFilter = RegExp(
    '$_meatKeywords|$_fishKeywords|$_dairyKeywords|$_eggKeywords',
    caseSensitive: false,
  );
  static final _vegetarianNameFilter = RegExp(
    '$_meatKeywords|$_fishKeywords',
    caseSensitive: false,
  );
  static final _pescatarianNameFilter = RegExp(
    _meatKeywords,
    caseSensitive: false,
  );
  static final _halalNameFilter = RegExp(
    '$_porkKeywords|$_alcoholKeywords',
    caseSensitive: false,
  );

  static Set<String> _excludedCategories(String? dietType) {
    switch (dietType) {
      case 'vegan':
        return {
          'Meat and meat products',
          'Fish and fish products',
          'Eggs',
          'Milk and milk products',
        };
      case 'vegetarian':
        return {
          'Meat and meat products',
          'Fish and fish products',
        };
      case 'pescatarian':
        return {
          'Meat and meat products',
        };
      default:
        return {};
    }
  }

  static RegExp? _excludedNamePattern(String? dietType) {
    switch (dietType) {
      case 'vegan':
        return _veganNameFilter;
      case 'vegetarian':
        return _vegetarianNameFilter;
      case 'pescatarian':
        return _pescatarianNameFilter;
      default:
        return null;
    }
  }

  /// Returns true if the quick-add food is allowed for the given diet.
  /// Foods without a 'diet' key are universally allowed.
  /// 'diet' value indicates the minimum restriction level that allows it:
  ///   'omnivore' = only omnivore/pescatarian, 'vegetarian' = not vegan
  static bool _quickFoodAllowed(Map<String, dynamic> food, String? dietType) {
    final minDiet = food['diet'] as String?;
    if (minDiet == null) return true;
    if (dietType == null || dietType == 'omnivore') return true;
    if (dietType == 'pescatarian') return minDiet != 'omnivore';
    if (dietType == 'vegetarian') return minDiet == 'vegetarian';
    // vegan — only universally allowed foods (no 'diet' tag)
    return false;
  }

  @override
  void dispose() {
    _searchDebounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  void _searchFoods(String query, {bool immediate = false}) {
    _searchDebounce?.cancel();

    if (query.trim().isEmpty) {
      setState(() {
        _searchResults = [];
        _searchLoading = false;
      });
      return;
    }

    setState(() => _searchLoading = true);

    if (immediate) {
      _performSearch(query);
    } else {
      _searchDebounce = Timer(
        const Duration(milliseconds: 300),
        () => _performSearch(query),
      );
    }
  }

  Future<void> _performSearch(String query) async {
    final q = query.toLowerCase();
    final profile = context.read<ProfileProvider>();
    final dietType = profile.dietType;
    final halalMode = profile.halalMode;
    final excludedCats = _excludedCategories(dietType);
    if (halalMode) excludedCats.add('Alcoholic beverages');
    var excludedNames = _excludedNamePattern(dietType);
    if (halalMode) {
      excludedNames = excludedNames != null
          ? RegExp('${excludedNames.pattern}|$_porkKeywords|$_alcoholKeywords', caseSensitive: false)
          : _halalNameFilter;
    }

    // Custom foods first (more relevant)
    final customResults = DatabaseService.customFoods.where((f) {
      final name = (f['n'] as String?) ?? '';
      return name.toLowerCase().contains(q);
    }).toList();

    final assetResults = await FoodDatabase.searchFoods(
      query: query,
      excludedCategories: excludedCats,
      excludedNamePattern: excludedNames,
      limit: 20 - customResults.length.clamp(0, 20),
    );

    // Stale-query guard: only update if query hasn't changed during await
    if (!mounted || _searchQuery != query) return;

    setState(() {
      _searchResults = [...customResults, ...assetResults].take(20).toList();
      _searchLoading = false;
    });
  }

  Future<void> _addSearchResult(BuildContext context, dynamic food) async {
    final locale = Localizations.localeOf(context);
    final name = _foodName(food, locale);
    final isCustom = food['custom'] == true;
    final kcalBase = (food['k'] as num?)?.toDouble() ?? 0;
    final proteinBase = (food['p'] as num?)?.toDouble() ?? 0;
    final carbsBase = (food['carbs'] as num?)?.toDouble() ?? 0;
    final fatBase = (food['fat'] as num?)?.toDouble() ?? 0;
    final category = _foodCategory(food, locale);

    final servingController = TextEditingController(text: isCustom ? '1' : '100');
    final presets = isCustom ? [1, 2, 3] : [50, 75, 100, 150, 200, 250];

    final confirmed = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setSheetState) {
            final amount = double.tryParse(servingController.text) ?? 0;
            final kcal = isCustom
                ? (kcalBase * amount).round()
                : (kcalBase * amount / 100).round();
            final protein = isCustom
                ? (proteinBase * amount * 10).round() / 10
                : (proteinBase * amount / 100 * 10).round() / 10;
            final mealType = _guessMealType();
            final l10n = AppLocalizations.of(ctx)!;
            final suffixLabel = isCustom ? l10n.servingsLabel : l10n.gramUnit;

            return FractionallySizedBox(
              heightFactor: 0.75,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(ctx).colorScheme.surface,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                ),
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(ctx).viewInsets.bottom,
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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

                    // Food name & category
                    Text(
                      name,
                      style: Theme.of(ctx).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Flexible(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppColors.primaryContainer,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              category,
                              style: Theme.of(ctx).textTheme.labelSmall?.copyWith(
                                    color: AppColors.primaryDark,
                                  ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          isCustom
                              ? l10n.kcalPerServing(kcalBase.toInt())
                              : l10n.kcalPer100g(kcalBase.toInt()),
                          style: Theme.of(ctx).textTheme.bodySmall?.copyWith(
                                color: Theme.of(ctx).colorScheme.onSurfaceVariant,
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Serving presets
                    Text(
                      l10n.servingSize,
                      style: Theme.of(ctx).textTheme.labelMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: presets.map((g) {
                        final selected = servingController.text == g.toString();
                        return ChoiceChip(
                          label: Text('$g $suffixLabel'),
                          selected: selected,
                          selectedColor: AppColors.primaryContainer,
                          labelStyle: TextStyle(
                            color: selected ? AppColors.primaryDark : null,
                            fontWeight: selected ? FontWeight.w600 : null,
                            fontSize: 13,
                          ),
                          onSelected: (_) {
                            servingController.text = g.toString();
                            setSheetState(() {});
                          },
                          visualDensity: VisualDensity.compact,
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 12),

                    // Custom input
                    SizedBox(
                      height: 48,
                      child: TextField(
                        controller: servingController,
                        decoration: InputDecoration(
                          isDense: true,
                          hintText: l10n.customAmount,
                          suffixText: suffixLabel,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(4),
                        ],
                        onChanged: (_) => setSheetState(() {}),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Nutrition summary
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primaryContainer.withValues(alpha: 0.5),
                            AppColors.accentContainer.withValues(alpha: 0.5),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  '$kcal',
                                  style: Theme.of(ctx).textTheme.headlineSmall?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.accent,
                                      ),
                                ),
                                Text(l10n.kcalUnit,
                                    style: Theme.of(ctx).textTheme.labelSmall?.copyWith(
                                          color: Theme.of(ctx).colorScheme.onSurfaceVariant,
                                        )),
                              ],
                            ),
                          ),
                          Container(
                            width: 1,
                            height: 36,
                            color: Theme.of(ctx).colorScheme.outlineVariant,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  '$protein${l10n.gramUnit}',
                                  style: Theme.of(ctx).textTheme.headlineSmall?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.primary,
                                      ),
                                ),
                                Text(l10n.protein.toLowerCase(),
                                    style: Theme.of(ctx).textTheme.labelSmall?.copyWith(
                                          color: Theme.of(ctx).colorScheme.onSurfaceVariant,
                                        )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Add button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: FilledButton.icon(
                        onPressed: amount > 0 ? () => Navigator.pop(ctx, true) : null,
                        icon: const Icon(Icons.add_rounded),
                        label: Text(l10n.addTo(_localizedMealType(l10n, mealType))),
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            );
          },
        );
      },
    );

    if (confirmed != true || !context.mounted) return;

    final amount = double.tryParse(servingController.text) ?? (isCustom ? 1 : 100);
    final kcal = isCustom
        ? (kcalBase * amount).round()
        : (kcalBase * amount / 100).round();
    final protein = isCustom
        ? (proteinBase * amount * 10).round() / 10
        : (proteinBase * amount / 100 * 10).round() / 10;
    final carbs = isCustom
        ? (carbsBase * amount * 10).round() / 10
        : (carbsBase * amount / 100 * 10).round() / 10;
    final fat = isCustom
        ? (fatBase * amount * 10).round() / 10
        : (fatBase * amount / 100 * 10).round() / 10;

    final mealsProvider = context.read<MealsProvider>();
    final summaryProvider = context.read<SummaryProvider>();
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final mealType = _guessMealType();

    final displayName = isCustom
        ? (amount == 1 ? name : '$name (x${amount.toInt()})')
        : '$name (${amount.toInt()}g)';

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
        'name': displayName,
        'calories': kcal,
        'protein': protein,
        'carbs': carbs,
        'fat': fat,
      });

      await summaryProvider.load();

      _searchController.clear();
      setState(() {
        _searchQuery = '';
        _searchResults = [];
      });

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.addedToMeal(name, _localizedMealType(AppLocalizations.of(context)!, mealType))),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.failedToAdd('$e')),
            behavior: SnackBarBehavior.floating,
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  List<dynamic> _filteredMeals(List<dynamic> meals) {
    var filtered = meals;

    // Filter by meal type
    if (_selectedMealType >= 0) {
      final typeName = _mealTypeKeys[_selectedMealType + 1];
      filtered = filtered
          .where((m) => (m['meal_type'] ?? '') == typeName)
          .toList();
    }

    // Filter by search query
    if (_searchQuery.isNotEmpty) {
      final q = _searchQuery.toLowerCase();
      filtered = filtered.where((m) {
        final items = (m['items'] as List<dynamic>?) ?? [];
        return items.any((item) =>
            (item['name'] ?? '').toString().toLowerCase().contains(q));
      }).toList();
    }

    return filtered;
  }

  Future<void> _quickAddFood(BuildContext context, String foodName) async {
    final mealsProvider = context.read<MealsProvider>();
    final summaryProvider = context.read<SummaryProvider>();
    final data = _quickFoodData[foodName]!;
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final mealType = _guessMealType();

    try {
      // Find existing meal of this type, or create one
      final matches = mealsProvider.meals.where((m) => m['meal_type'] == mealType);

      if (matches.isNotEmpty) {
        await mealsProvider.addFoodItem(matches.first['id'], {
          'name': foodName,
          'calories': data['calories'],
          'protein': data['protein'],
          'carbs': data['carbs'],
          'fat': data['fat'],
        });
      } else {
        // Create meal first, then add item
        await mealsProvider.createMeal({
          'date': today,
          'mealType': mealType,
          'time': DateFormat('HH:mm').format(DateTime.now()),
        });
        // Reload to get the new meal's ID
        final newMatches = mealsProvider.meals.where((m) => m['meal_type'] == mealType);
        if (newMatches.isNotEmpty) {
          await mealsProvider.addFoodItem(newMatches.first['id'], {
            'name': foodName,
            'calories': data['calories'],
            'protein': data['protein'],
            'carbs': data['carbs'],
            'fat': data['fat'],
          });
        }
      }

      await summaryProvider.load();

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.addedToMeal(_localizedFoodName(AppLocalizations.of(context)!, foodName), _localizedMealType(AppLocalizations.of(context)!, mealType))),
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.failedToAdd('$e')),
            behavior: SnackBarBehavior.floating,
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  String _guessMealType() {
    // If user has a meal type chip selected, use that
    if (_selectedMealType >= 0) {
      return _mealTypeKeys[_selectedMealType + 1];
    }
    // Otherwise guess from time of day
    final hour = DateTime.now().hour;
    if (hour < 11) return 'Breakfast';
    if (hour < 15) return 'Lunch';
    if (hour < 18) return 'Snack';
    return 'Dinner';
  }

  Future<void> _showAddFoodDialog(BuildContext context) async {
    final nameController = TextEditingController();
    final caloriesController = TextEditingController();
    final proteinController = TextEditingController();
    final carbsController = TextEditingController();
    final fatController = TextEditingController();
    final l10n = AppLocalizations.of(context)!;
    String dialogMealType = _selectedMealType >= 0
        ? _mealTypeKeys[_selectedMealType + 1]
        : _guessMealType();

    final result = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setSheetState) {
            return Container(
              decoration: BoxDecoration(
                color: Theme.of(ctx).colorScheme.surface,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
              ),
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(ctx).viewInsets.bottom,
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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

                    // Title
                    Text(
                      l10n.addFood,
                      style: Theme.of(ctx).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(height: 16),

                    // Meal type selector
                    DropdownButtonFormField<String>(
                      value: dialogMealType,
                      decoration: InputDecoration(
                        labelText: l10n.meal,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      items: ['Breakfast', 'Lunch', 'Dinner', 'Snack']
                          .map((t) => DropdownMenuItem(value: t, child: Text(_localizedMealType(l10n, t))))
                          .toList(),
                      onChanged: (v) =>
                          setSheetState(() => dialogMealType = v ?? dialogMealType),
                    ),
                    const SizedBox(height: 12),

                    // Food name
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: l10n.foodName,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      textCapitalization: TextCapitalization.words,
                      autofocus: true,
                    ),
                    const SizedBox(height: 12),

                    // Calories (full width)
                    TextField(
                      controller: caloriesController,
                      decoration: InputDecoration(
                        labelText: l10n.calories,
                        suffixText: l10n.kcalUnit,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(4),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Macros — 2-column grid
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: proteinController,
                            decoration: InputDecoration(
                              labelText: l10n.protein,
                              suffixText: l10n.gramUnit,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(3),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextField(
                            controller: carbsController,
                            decoration: InputDecoration(
                              labelText: l10n.carbs,
                              suffixText: l10n.gramUnit,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
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
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: fatController,
                            decoration: InputDecoration(
                              labelText: l10n.fat,
                              suffixText: l10n.gramUnit,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(3),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(child: SizedBox()),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Add button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: FilledButton.icon(
                        onPressed: () {
                          if (nameController.text.trim().isEmpty) return;
                          if ((int.tryParse(caloriesController.text) ?? 0) <= 0) return;
                          Navigator.pop(ctx, true);
                        },
                        icon: const Icon(Icons.add_rounded),
                        label: Text(l10n.addTo(_localizedMealType(l10n, dialogMealType))),
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );

    if (result != true || !context.mounted) return;

    final mealsProvider = context.read<MealsProvider>();
    final summaryProvider = context.read<SummaryProvider>();
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());

    try {
      // Find or create meal
      final matches = mealsProvider.meals.where((m) => m['meal_type'] == dialogMealType);
      String mealId;
      if (matches.isNotEmpty) {
        mealId = matches.first['id'];
      } else {
        await mealsProvider.createMeal({
          'date': today,
          'mealType': dialogMealType,
          'time': DateFormat('HH:mm').format(DateTime.now()),
        });
        final newMatches = mealsProvider.meals.where((m) => m['meal_type'] == dialogMealType);
        mealId = newMatches.first['id'];
      }

      final foodName = nameController.text.trim();
      final cal = int.tryParse(caloriesController.text) ?? 0;
      final prot = int.tryParse(proteinController.text) ?? 0;
      final carb = int.tryParse(carbsController.text) ?? 0;
      final f = int.tryParse(fatController.text) ?? 0;

      await mealsProvider.addFoodItem(mealId, {
        'name': foodName,
        'calories': cal,
        'protein': prot,
        'carbs': carb,
        'fat': f,
      });

      await DatabaseService.saveCustomFood(
        name: foodName,
        calories: cal,
        protein: prot,
        carbs: carb,
        fat: f,
      );

      await summaryProvider.load();

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.addedToMeal(foodName, _localizedMealType(AppLocalizations.of(context)!, dialogMealType))),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.failedToAdd('$e')),
            behavior: SnackBarBehavior.floating,
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  Future<void> _deleteMeal(BuildContext context, dynamic meal) async {
    final mealType = meal['meal_type'] ?? 'meal';
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.deleteMealTitle),
        content: Text(l10n.deleteMealConfirm(_localizedMealType(l10n, mealType))),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: FilledButton.styleFrom(backgroundColor: AppColors.error),
            child: Text(l10n.delete),
          ),
        ],
      ),
    );

    if (confirmed != true || !context.mounted) return;

    final mealsProvider = context.read<MealsProvider>();
    final summaryProvider = context.read<SummaryProvider>();
    try {
      await mealsProvider.deleteMeal(meal['id']);
      await summaryProvider.load();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.deleted(_localizedMealType(AppLocalizations.of(context)!, mealType))),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.failedToDelete('$e')),
            behavior: SnackBarBehavior.floating,
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  Future<void> _removeFoodItem(
      BuildContext context, String mealId, dynamic item) async {
    final mealsProvider = context.read<MealsProvider>();
    final summaryProvider = context.read<SummaryProvider>();
    try {
      await mealsProvider.removeFoodItem(mealId, item['id']);
      await summaryProvider.load();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.removed(item['name'] ?? '')),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.failedToRemove('$e')),
            behavior: SnackBarBehavior.floating,
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

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
                _buildHeader(context),
                const SizedBox(height: 24),
                _buildMealTypeChips(context),
                const SizedBox(height: 16),
                _buildSearchBar(context),
                if (_searchQuery.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  _buildSearchResults(context),
                ],
                const SizedBox(height: 16),
                if (_searchQuery.isEmpty)
                  _buildQuickAddButtons(context),
                const SizedBox(height: 24),
                _buildTodaysMeals(context),
                const SizedBox(height: 24),
                AnimatedEntrance(
                  delay: const Duration(milliseconds: 200),
                  child: _buildDailySummary(context),
                ),
                const SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ),
      ),
      floatingActionButton: Semantics(
        button: true,
        label: AppLocalizations.of(context)!.addFood,
        child: FloatingActionButton.extended(
          tooltip: AppLocalizations.of(context)!.addFood,
          onPressed: () => _showAddFoodDialog(context),
          icon: const Icon(Icons.add),
          label: Text(AppLocalizations.of(context)!.addFood),
          backgroundColor: AppColors.accent,
          foregroundColor: Colors.white,
        ),
      ),
    );
  }

  Widget _buildSearchResults(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    if (_searchLoading) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
      );
    }

    if (_searchResults.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          l10n.noFoodsFound(_searchQuery),
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.only(start: 4, bottom: 8),
          child: Text(
            l10n.resultCount(_searchResults.length),
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
        ),
        ...(_searchResults.take(20).map((food) {
          final locale = Localizations.localeOf(context);
          final name = _foodName(food, locale);
          final kcal = food['k'] ?? 0;
          final protein = food['p'] ?? 0;
          final category = _foodCategory(food, locale);

          return Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Material(
              color: Theme.of(context).colorScheme.surfaceContainerLow,
              borderRadius: BorderRadius.circular(12),
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () => _addSearchResult(context, food),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_circle_rounded,
                        color: AppColors.primary,
                        size: 22,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '$category  •  ${l10n.proteinGrams('$protein')}',
                              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.accentContainer,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '$kcal ${l10n.kcalUnit}',
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: AppColors.accent,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        })),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShaderMask(
          shaderCallback: (bounds) =>
              AppColors.primaryGradient.createShader(bounds),
          child: Text(
            AppLocalizations.of(context)!.todaysLog,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          DateFormat('EEEE, MMMM d', Localizations.localeOf(context).languageCode).format(DateTime.now()),
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
      ],
    );
  }

  Widget _buildMealTypeChips(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(_mealTypeKeys.length, (index) {
          final chipIndex = index - 1; // -1 = All
          final selected = _selectedMealType == chipIndex;
          return Padding(
            padding: const EdgeInsetsDirectional.only(end: 8),
            child: ChoiceChip(
              label: Text(_localizedMealType(l10n, _mealTypeKeys[index])),
              selected: selected,
              onSelected: (_) => setState(() => _selectedMealType = chipIndex),
              selectedColor: AppColors.primaryContainer,
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

  Widget _buildSearchBar(BuildContext context) {
    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
        hintText: AppLocalizations.of(context)!.searchFoodsToAdd,
        prefixIcon: const Icon(Icons.search),
        suffixIcon: _searchQuery.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.clear),
                tooltip: AppLocalizations.of(context)!.clearSearch,
                onPressed: () {
                  _searchDebounce?.cancel();
                  _searchController.clear();
                  setState(() {
                    _searchQuery = '';
                    _searchResults = [];
                    _searchLoading = false;
                  });
                },
              )
            : null,
      ),
      onChanged: (value) {
        setState(() => _searchQuery = value);
        _searchFoods(value);
      },
      onSubmitted: (value) => _searchFoods(value, immediate: true),
    );
  }

  Widget _buildQuickAddButtons(BuildContext context) {
    final dietType = context.watch<ProfileProvider>().dietType;
    final l10n = AppLocalizations.of(context)!;
    final filtered = _quickFoodData.entries
        .where((e) => _quickFoodAllowed(e.value, dietType))
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.quickAdd,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: filtered.asMap().entries.map((entry) {
            final localizedName = _localizedFoodName(l10n, entry.value.key);
            return AnimatedEntrance(
              delay: Duration(milliseconds: (50 * entry.key).clamp(0, 400)),
              child: ActionChip(
                avatar: const Icon(Icons.add, size: 16),
                label: Text('$localizedName (${entry.value.value['calories']} ${l10n.kcalUnit})'),
                onPressed: () => _quickAddFood(context, entry.value.key),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildTodaysMeals(BuildContext context) {
    final mealsProvider = context.watch<MealsProvider>();
    final meals = _filteredMeals(mealsProvider.meals);
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _selectedMealType < 0
                  ? l10n.todaysMeals
                  : _localizedMealType(l10n, _mealTypeKeys[_selectedMealType + 1]),
              style: Theme.of(context).textTheme.titleLarge,
            ),
            if (mealsProvider.loading)
              const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
          ],
        ),
        const SizedBox(height: 12),
        if (meals.isEmpty && !mealsProvider.loading)
          Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Icon(
                    Icons.restaurant_menu,
                    size: 48,
                    color: Theme.of(context).colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _searchQuery.isNotEmpty
                        ? l10n.noFoodsFound(_searchQuery)
                        : l10n.noMealsLogged,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    l10n.tapAddFood,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                ],
              ),
            ),
          )
        else
          ...meals.asMap().entries.map((entry) => AnimatedEntrance(
                delay: Duration(milliseconds: entry.key * 80),
                child: _buildMealLogCard(context, entry.value),
              )),
      ],
    );
  }

  Widget _buildMealLogCard(BuildContext context, dynamic meal) {
    final items = (meal['items'] as List<dynamic>?) ?? [];
    final totalCalories =
        items.fold<num>(0, (sum, item) => sum + (item['calories'] ?? 0));
    final mealType = meal['meal_type'] ?? '';
    final time = meal['time'] ?? meal['created_at'] ?? '';

    // Format time for display
    String displayTime = '';
    if (time.toString().isNotEmpty) {
      try {
        if (time.toString().contains('T')) {
          final dt = DateTime.parse(time.toString());
          displayTime = DateFormat('h:mm a').format(dt);
        } else if (time.toString().contains(':')) {
          final parts = time.toString().split(':');
          final hour = int.parse(parts[0]);
          final minute = int.parse(parts[1]);
          final dt = DateTime(2000, 1, 1, hour, minute);
          displayTime = DateFormat('h:mm a').format(dt);
        }
      } catch (_) {
        displayTime = time.toString();
      }
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: AppColors.primaryContainer,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          _mealIcon(mealType),
                          size: 18,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _localizedMealType(AppLocalizations.of(context)!, mealType),
                              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            if (displayTime.isNotEmpty)
                              Text(
                                displayTime,
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                                    ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        gradient: AppColors.accentGradient,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '${totalCalories.toInt()} ${AppLocalizations.of(context)!.kcalUnit}',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    PopupMenuButton<String>(
                      tooltip: AppLocalizations.of(context)!.mealOptions,
                      iconSize: 20,
                      padding: EdgeInsets.zero,
                      onSelected: (action) {
                        if (action == 'delete') {
                          _deleteMeal(context, meal);
                        } else if (action == 'add_item') {
                          _showAddItemToMealDialog(context, meal);
                        }
                      },
                      itemBuilder: (_) {
                        final l10n = AppLocalizations.of(context)!;
                        return [
                          PopupMenuItem(
                            value: 'add_item',
                            child: Row(
                              children: [
                                const Icon(Icons.add, size: 18),
                                const SizedBox(width: 8),
                                Text(l10n.addItem),
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            value: 'delete',
                            child: Row(
                              children: [
                                const Icon(Icons.delete_outline, size: 18, color: AppColors.error),
                                const SizedBox(width: 8),
                                Text(l10n.deleteMeal, style: const TextStyle(color: AppColors.error)),
                              ],
                            ),
                          ),
                        ];
                      },
                    ),
                  ],
                ),
              ],
            ),
            if (items.isNotEmpty) ...[
              const Divider(height: 24),
              ...items.map((item) => Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            _localizedFoodName(AppLocalizations.of(context)!, item['name'] ?? ''),
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                        Text(
                          '${(item['calories'] ?? 0).toInt()} ${AppLocalizations.of(context)!.kcalUnit}',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Theme.of(context).colorScheme.onSurfaceVariant,
                              ),
                        ),
                        const SizedBox(width: 4),
                        Semantics(
                          button: true,
                          label: '${AppLocalizations.of(context)!.delete} ${_localizedFoodName(AppLocalizations.of(context)!, item['name'] ?? '')}',
                          child: InkWell(
                            onTap: () => _removeFoodItem(context, meal['id'], item),
                            borderRadius: BorderRadius.circular(12),
                            child: Padding(
                              padding: const EdgeInsets.all(4),
                              child: Icon(
                                Icons.close,
                                size: 14,
                                color: Theme.of(context).colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> _showAddItemToMealDialog(
      BuildContext context, dynamic meal) async {
    final nameController = TextEditingController();
    final caloriesController = TextEditingController();
    final proteinController = TextEditingController();
    final carbsController = TextEditingController();
    final fatController = TextEditingController();
    final l10n = AppLocalizations.of(context)!;
    final mealType = meal['meal_type'] ?? '';

    final result = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(ctx).colorScheme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(ctx).viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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

                // Title
                Text(
                  '${l10n.addItem} - ${_localizedMealType(l10n, mealType)}',
                  style: Theme.of(ctx).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 16),

                // Food name
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: l10n.foodName,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  textCapitalization: TextCapitalization.words,
                  autofocus: true,
                ),
                const SizedBox(height: 12),

                // Calories (full width)
                TextField(
                  controller: caloriesController,
                  decoration: InputDecoration(
                    labelText: l10n.calories,
                    suffixText: l10n.kcalUnit,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(4),
                  ],
                ),
                const SizedBox(height: 12),

                // Macros — 2-column grid
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: proteinController,
                        decoration: InputDecoration(
                          labelText: l10n.protein,
                          suffixText: l10n.gramUnit,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(3),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: carbsController,
                        decoration: InputDecoration(
                          labelText: l10n.carbs,
                          suffixText: l10n.gramUnit,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
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
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: fatController,
                        decoration: InputDecoration(
                          labelText: l10n.fat,
                          suffixText: l10n.gramUnit,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(3),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(child: SizedBox()),
                  ],
                ),
                const SizedBox(height: 20),

                // Add button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: FilledButton.icon(
                    onPressed: () {
                      if (nameController.text.trim().isEmpty) return;
                      if ((int.tryParse(caloriesController.text) ?? 0) <= 0) return;
                      Navigator.pop(ctx, true);
                    },
                    icon: const Icon(Icons.add_rounded),
                    label: Text(l10n.addTo(_localizedMealType(l10n, mealType))),
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    if (result != true || !context.mounted) return;

    final mealsProvider = context.read<MealsProvider>();
    final summaryProvider = context.read<SummaryProvider>();
    try {
      final foodName = nameController.text.trim();
      final cal = int.tryParse(caloriesController.text) ?? 0;
      final prot = int.tryParse(proteinController.text) ?? 0;
      final carb = int.tryParse(carbsController.text) ?? 0;
      final f = int.tryParse(fatController.text) ?? 0;

      await mealsProvider.addFoodItem(meal['id'], {
        'name': foodName,
        'calories': cal,
        'protein': prot,
        'carbs': carb,
        'fat': f,
      });

      await DatabaseService.saveCustomFood(
        name: foodName,
        calories: cal,
        protein: prot,
        carbs: carb,
        fat: f,
      );

      await summaryProvider.load();

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.addedText(foodName)),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.failedToAdd('$e')),
            behavior: SnackBarBehavior.floating,
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  IconData _mealIcon(String type) {
    switch (type) {
      case 'Breakfast':
        return Icons.free_breakfast;
      case 'Lunch':
        return Icons.lunch_dining;
      case 'Dinner':
        return Icons.dinner_dining;
      case 'Snack':
        return Icons.cookie;
      default:
        return Icons.restaurant;
    }
  }

  Widget _buildDailySummary(BuildContext context) {
    final summary = context.watch<SummaryProvider>();
    final consumed = summary.caloriesConsumed;
    final goal = summary.caloriesGoal;
    final remaining = summary.caloriesRemaining;
    final l10n = AppLocalizations.of(context)!;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.dailySummary,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildSummaryItem(
                    context,
                    label: l10n.consumed,
                    value: NumberFormat('#,###').format(consumed),
                    unit: l10n.kcalUnit,
                    color: AppColors.accent,
                  ),
                ),
                Container(
                  width: 1,
                  height: 40,
                  color: Theme.of(context).colorScheme.outlineVariant,
                ),
                Expanded(
                  child: _buildSummaryItem(
                    context,
                    label: l10n.remaining,
                    value: NumberFormat('#,###').format(remaining > 0 ? remaining : 0),
                    unit: l10n.kcalUnit,
                    color: AppColors.primary,
                  ),
                ),
                Container(
                  width: 1,
                  height: 40,
                  color: Theme.of(context).colorScheme.outlineVariant,
                ),
                Expanded(
                  child: _buildSummaryItem(
                    context,
                    label: l10n.goal,
                    value: NumberFormat('#,###').format(goal),
                    unit: l10n.kcalUnit,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: goal > 0 ? (consumed / goal).clamp(0.0, 1.0) : 0,
                minHeight: 8,
                backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                valueColor: const AlwaysStoppedAnimation<Color>(AppColors.accent),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryItem(
    BuildContext context, {
    required String label,
    required String value,
    required String unit,
    required Color color,
  }) {
    return Column(
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
      ],
    );
  }
}
