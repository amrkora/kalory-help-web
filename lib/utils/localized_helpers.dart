import '../l10n/app_localizations.dart';

/// Translates internal English meal-type keys to the current locale.
String localizedMealType(AppLocalizations l10n, String type) {
  switch (type) {
    case 'All':
      return l10n.all;
    case 'Breakfast':
      return l10n.breakfast;
    case 'Lunch':
      return l10n.lunch;
    case 'Dinner':
      return l10n.dinner;
    case 'Snack':
      return l10n.snack;
    case 'Dessert':
      return l10n.dessert;
    default:
      return type;
  }
}

/// Translates known food names to the current locale.
String localizedFoodName(AppLocalizations l10n, String key) {
  switch (key) {
    case 'Banana':
      return l10n.foodBanana;
    case 'Chicken Breast':
      return l10n.foodChickenBreast;
    case 'Rice':
      return l10n.foodRice;
    case 'Eggs':
      return l10n.foodEggs;
    case 'Oatmeal':
      return l10n.foodOatmeal;
    case 'Apple':
      return l10n.foodApple;
    case 'Yogurt':
      return l10n.foodYogurt;
    case 'Oatmeal with Berries':
      return l10n.foodOatmealWithBerries;
    case 'Greek Yogurt':
      return l10n.foodGreekYogurt;
    case 'Black Coffee':
      return l10n.foodBlackCoffee;
    case 'Almonds (10)':
      return l10n.foodAlmonds10;
    case 'Grilled Chicken Salad':
      return l10n.foodGrilledChickenSalad;
    case 'Whole Wheat Roll':
      return l10n.foodWholeWheatRoll;
    case 'Breakfast':
      return l10n.breakfast;
    case 'Lunch':
      return l10n.lunch;
    case 'Dinner':
      return l10n.dinner;
    case 'Snack':
      return l10n.snack;
    default:
      return key;
  }
}
