// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get navHome => 'Home';

  @override
  String get navLog => 'Log';

  @override
  String get navDiscover => 'Discover';

  @override
  String get navProgress => 'Progress';

  @override
  String get navProfile => 'Profile';

  @override
  String get discoverTitle => 'Discover';

  @override
  String recipesToExplore(int count) {
    return '$count recipes to explore';
  }

  @override
  String get searchRecipes => 'Search recipes...';

  @override
  String get featured => 'FEATURED';

  @override
  String get allRecipes => 'All Recipes';

  @override
  String recipesCount(int count) {
    return '$count recipes';
  }

  @override
  String get noRecipesFound => 'No recipes found';

  @override
  String get nutritionPerServing => 'Nutrition per serving';

  @override
  String get method => 'Method';

  @override
  String viewOnSource(String source) {
    return 'View on $source';
  }

  @override
  String get clearSearch => 'Clear search';

  @override
  String get todaysLog => 'Today\'s Log';

  @override
  String get searchFoodsToAdd => 'Search foods to add...';

  @override
  String get quickAdd => 'Quick Add';

  @override
  String get todaysMeals => 'Today\'s Meals';

  @override
  String get noMealsLogged => 'No meals logged yet today';

  @override
  String get tapAddFood => 'Tap \"Add Food\" or use Quick Add above';

  @override
  String get addFood => 'Add Food';

  @override
  String get addItem => 'Add item';

  @override
  String get deleteMeal => 'Delete meal';

  @override
  String get deleteMealTitle => 'Delete Meal';

  @override
  String deleteMealConfirm(String mealType) {
    return 'Remove $mealType and all its food items?';
  }

  @override
  String get dailySummary => 'Daily Summary';

  @override
  String get consumed => 'Consumed';

  @override
  String get remaining => 'Remaining';

  @override
  String get goal => 'Goal';

  @override
  String get servingSize => 'Serving size';

  @override
  String get customAmount => 'Custom amount';

  @override
  String addTo(String mealType) {
    return 'Add to $mealType';
  }

  @override
  String get mealOptions => 'Meal options';

  @override
  String get myProfile => 'My Profile';

  @override
  String get dailyGoals => 'Daily Goals';

  @override
  String get recalculate => 'Recalculate';

  @override
  String get recalculateGoals => 'Recalculate Goals';

  @override
  String get recalculateMessage =>
      'This will recalculate all your daily nutrition goals based on your current body info (gender, height, weight, age, activity level).\n\nAny manual edits to individual goals will be overwritten.';

  @override
  String get bodyInfo => 'Body Info';

  @override
  String get preferences => 'Preferences';

  @override
  String get account => 'Account';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get language => 'Language';

  @override
  String get english => 'English';

  @override
  String get arabic => 'العربية';

  @override
  String get chooseLanguage => 'Choose Language';

  @override
  String get exportData => 'Export Data';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get helpSupport => 'Help & Support';

  @override
  String get dataExported => 'Data exported!';

  @override
  String get exportFailed => 'Export failed. Please try again.';

  @override
  String get gender => 'Gender';

  @override
  String get male => 'Male';

  @override
  String get female => 'Female';

  @override
  String get height => 'Height';

  @override
  String get weight => 'Weight';

  @override
  String get age => 'Age';

  @override
  String get activityLevel => 'Activity Level';

  @override
  String get dietType => 'Diet Type';

  @override
  String get sedentary => 'Sedentary';

  @override
  String get sedentaryDesc => 'Little to no exercise';

  @override
  String get light => 'Light';

  @override
  String get lightDesc => 'Light exercise 1-3 days/week';

  @override
  String get moderate => 'Moderate';

  @override
  String get moderateDesc => 'Moderate exercise 3-5 days/week';

  @override
  String get active => 'Active';

  @override
  String get activeDesc => 'Hard exercise 6-7 days/week';

  @override
  String get veryActive => 'Very Active';

  @override
  String get veryActiveDesc => 'Very hard exercise & physical job';

  @override
  String get omnivore => 'Flexible';

  @override
  String get omnivoreDesc => 'No dietary restrictions';

  @override
  String get vegetarian => 'Vegetarian';

  @override
  String get vegetarianDesc => 'No meat or fish';

  @override
  String get vegan => 'Vegan';

  @override
  String get veganDesc => 'No animal products at all';

  @override
  String get pescatarian => 'Pescatarian';

  @override
  String get pescatarianDesc => 'Fish & seafood, no meat';

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get add => 'Add';

  @override
  String get edit => 'Edit';

  @override
  String get back => 'Back';

  @override
  String get next => 'Next';

  @override
  String get close => 'Close';

  @override
  String get notSet => 'Not set';

  @override
  String get calories => 'Calories';

  @override
  String get protein => 'Protein';

  @override
  String get carbs => 'Carbs';

  @override
  String get fat => 'Fat';

  @override
  String get fiber => 'Fiber';

  @override
  String get water => 'Water';

  @override
  String get welcomeTitle => 'Welcome to Kalory Help';

  @override
  String get welcomeSubtitle =>
      'Let\'s personalize your nutrition goals based on your body and lifestyle.';

  @override
  String get getStarted => 'Get Started';

  @override
  String get biologicalSex => 'What\'s your biological sex?';

  @override
  String get biologicalSexSubtitle =>
      'This helps us calculate your basal metabolic rate.';

  @override
  String get yourMeasurements => 'Your measurements';

  @override
  String get measurementsSubtitle =>
      'We use these to estimate your daily energy needs.';

  @override
  String get ageRangeQuestion => 'What\'s your age range?';

  @override
  String get ageRangeSubtitle => 'Age affects your metabolic rate.';

  @override
  String get activityQuestion => 'How active are you?';

  @override
  String get activitySubtitle =>
      'This determines your daily calorie multiplier.';

  @override
  String get dietTypeQuestion => 'What\'s your diet type?';

  @override
  String get dietTypeSubtitle =>
      'This helps tailor your macro ratios. You can skip this.';

  @override
  String get yourDailyGoals => 'Your Daily Goals';

  @override
  String get goalsRecommendation =>
      'Based on your profile, here\'s what we recommend.';

  @override
  String get letsGo => 'Let\'s Go!';

  @override
  String get goBack => 'Go Back';

  @override
  String get foodName => 'Food name';

  @override
  String get meal => 'Meal';

  @override
  String noFoodsFound(String query) {
    return 'No foods found for \"$query\"';
  }

  @override
  String resultCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count results',
      one: '1 result',
      zero: 'No results',
    );
    return '$_temp0';
  }

  @override
  String addedToMeal(String food, String mealType) {
    return '$food added to $mealType';
  }

  @override
  String removed(String item) {
    return '$item removed';
  }

  @override
  String deleted(String item) {
    return '$item deleted';
  }

  @override
  String addedText(String item) {
    return '$item added';
  }

  @override
  String failedToAdd(String error) {
    return 'Failed to add: $error';
  }

  @override
  String failedToDelete(String error) {
    return 'Failed to delete: $error';
  }

  @override
  String failedToRemove(String error) {
    return 'Failed to remove: $error';
  }

  @override
  String get breakfast => 'Breakfast';

  @override
  String get lunch => 'Lunch';

  @override
  String get dinner => 'Dinner';

  @override
  String get snack => 'Snack';

  @override
  String get dessert => 'Dessert';

  @override
  String get all => 'All';

  @override
  String get appVersion => 'Kalory Help v1.0.0';

  @override
  String get goodMorning => 'Good morning';

  @override
  String get goodAfternoon => 'Good afternoon';

  @override
  String get goodEvening => 'Good evening';

  @override
  String get kaloryHelp => 'Kalory Help';

  @override
  String get toggleTheme => 'Toggle theme';

  @override
  String get tipOfTheDay => 'Tip of the Day';

  @override
  String get progressTitle => 'Progress';

  @override
  String get week => 'Week';

  @override
  String get month => 'Month';

  @override
  String get threeMonths => '3 Months';

  @override
  String get weightTrend => 'Weight Trend';

  @override
  String get noWeightData => 'No weight data';

  @override
  String weightChartLabel(int count) {
    return 'Weight trend chart showing $count data points';
  }

  @override
  String get current => 'Current';

  @override
  String get change => 'Change';

  @override
  String get bmi => 'BMI';

  @override
  String get underweight => 'Underweight';

  @override
  String get normal => 'Normal';

  @override
  String get overweight => 'Overweight';

  @override
  String get obese => 'Obese';

  @override
  String get na => 'N/A';

  @override
  String get calorieTrends => 'Calorie Trends';

  @override
  String get noCalorieData => 'No calorie data';

  @override
  String get nutritionAverages => 'Nutrition Averages';

  @override
  String get dailyAverageThisWeek => 'Daily average this week';

  @override
  String get streaksAchievements => 'STREAKS & ACHIEVEMENTS';

  @override
  String get loggingStreak => 'Logging Streak';

  @override
  String get waterStreak => 'Water Streak';

  @override
  String get weeklyGoalsMet => 'Weekly Goals Met';

  @override
  String daysCount(int count) {
    return '$count days';
  }

  @override
  String countOfFour(int count) {
    return '$count of 4';
  }

  @override
  String get faq => 'Frequently Asked Questions';

  @override
  String get faqDataStoredQ => 'How is my data stored?';

  @override
  String get faqDataStoredA =>
      'All your data is stored locally on your device using Hive, a lightweight local database. Nothing is ever sent to a server. Your nutrition data never leaves your device.';

  @override
  String get faqExportQ => 'Can I export my data?';

  @override
  String get faqExportA =>
      'Yes! Go to Profile > Export Data to download a JSON file containing all your meals, water intake, weight entries, and profile information.';

  @override
  String get faqResetQ => 'How do I reset my data?';

  @override
  String get faqResetA =>
      'You can clear all your data by clearing your browser\'s site data for this app, or by uninstalling and reinstalling the app.';

  @override
  String get faqSyncQ => 'Is my data synced anywhere?';

  @override
  String get faqSyncA =>
      'No. Kalory Help is fully offline. There are no accounts, no cloud sync, and no remote databases. Your data exists only on this device.';

  @override
  String get aboutKaloryHelp => 'About Kalory Help';

  @override
  String get version => 'Version 1.0.0';

  @override
  String get aboutDescription =>
      'Kalory Help is a privacy-first nutrition tracking app that works entirely on your device. Track meals, water intake, and weight — all without an account or internet connection.';

  @override
  String get privacyPolicyTitle => 'Privacy Policy';

  @override
  String get lastUpdated => 'Last updated: February 2026';

  @override
  String get privacyDataStaysTitle => 'Your Data Stays on Your Device';

  @override
  String get privacyDataStaysBody =>
      'Kalory Help is a fully offline nutrition tracking app. All data you enter — including meals, water intake, weight, and profile information — is stored exclusively on your device. Nothing is sent to any server.';

  @override
  String get privacyNoCollectionTitle => 'No Data Collection';

  @override
  String get privacyNoCollectionBody =>
      'We do not collect, transmit, or store any personal information. There are no user accounts, no cloud sync, and no remote databases.';

  @override
  String get privacyNoAnalyticsTitle => 'No Analytics or Tracking';

  @override
  String get privacyNoAnalyticsBody =>
      'Kalory Help does not use any analytics services, advertising SDKs, or tracking technologies. We do not track your usage patterns, location, or any other behavioral data.';

  @override
  String get privacyNoSharingTitle => 'No Third-Party Sharing';

  @override
  String get privacyNoSharingBody =>
      'Since no data leaves your device, there is nothing to share with third parties. Your nutrition data is yours alone.';

  @override
  String get privacyDeletionTitle => 'Data Deletion';

  @override
  String get privacyDeletionBody =>
      'You can delete all your data at any time by uninstalling the app or clearing the app\'s storage in your device settings.';

  @override
  String get privacyContactTitle => 'Contact';

  @override
  String get privacyContactBody =>
      'If you have any questions about this privacy policy, please reach out through the app store listing.';

  @override
  String get dayFlow => 'Day Flow';

  @override
  String mealsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count meals',
      one: '1 meal',
      zero: 'No meals',
    );
    return '$_temp0';
  }

  @override
  String get noMealsLoggedYet => 'No meals logged yet';

  @override
  String get hydration => 'Hydration';

  @override
  String get tapToAddGlass => 'Tap to add a glass';

  @override
  String get waterIntake => 'Water intake';

  @override
  String glassesToday(int current, int goal) {
    return '$current / $goal glasses today';
  }

  @override
  String get remainingLabel => 'remaining';

  @override
  String get overLabel => 'over';

  @override
  String get kaloryScore => 'Kalory Score';

  @override
  String get scoreBreakdown => 'Score Breakdown';

  @override
  String get calorieAdherence => 'Calorie Adherence';

  @override
  String get macroBalance => 'Macro Balance';

  @override
  String get perfectDay => 'Perfect day!';

  @override
  String get greatBalance => 'Great balance!';

  @override
  String get gettingThere => 'Getting there';

  @override
  String get needsAttention => 'Needs attention';

  @override
  String get foodBanana => 'Banana';

  @override
  String get foodChickenBreast => 'Chicken Breast';

  @override
  String get foodRice => 'Rice';

  @override
  String get foodEggs => 'Eggs';

  @override
  String get foodOatmeal => 'Oatmeal';

  @override
  String get foodApple => 'Apple';

  @override
  String get foodYogurt => 'Yogurt';

  @override
  String proteinGrams(String value) {
    return '${value}g protein';
  }

  @override
  String kcalPer100g(int kcal) {
    return '$kcal kcal / 100g';
  }

  @override
  String kcalPerServing(int kcal) {
    return '$kcal kcal / serving';
  }

  @override
  String get foodOatmealWithBerries => 'Oatmeal with Berries';

  @override
  String get foodGreekYogurt => 'Greek Yogurt';

  @override
  String get foodBlackCoffee => 'Black Coffee';

  @override
  String get foodAlmonds10 => 'Almonds (10)';

  @override
  String get foodGrilledChickenSalad => 'Grilled Chicken Salad';

  @override
  String get foodWholeWheatRoll => 'Whole Wheat Roll';

  @override
  String get kcalUnit => 'kcal';

  @override
  String get gramUnit => 'g';

  @override
  String get cmUnit => 'cm';

  @override
  String get kgUnit => 'kg';

  @override
  String get glassesUnit => 'glasses';

  @override
  String get yearsUnit => 'years';

  @override
  String get catVegetables => 'Vegetables';

  @override
  String get catFruit => 'Fruit';

  @override
  String get catMeat => 'Meat and meat products';

  @override
  String get catFish => 'Fish and fish products';

  @override
  String get catCereals => 'Cereals and cereal products';

  @override
  String get catNuts => 'Nuts and seeds';

  @override
  String get catMilk => 'Milk and milk products';

  @override
  String get catEggs => 'Eggs';

  @override
  String get catBeverages => 'Beverages';

  @override
  String get difficultyEasy => 'Easy';

  @override
  String get difficultyMedium => 'Medium';

  @override
  String get difficultyHard => 'Hard';

  @override
  String get minuteShort => 'min';

  @override
  String get servingsLabel => 'servings';

  @override
  String get tapToEdit => 'Tap to edit';

  @override
  String stepIndicator(int step, int total) {
    return 'Step $step of $total';
  }

  @override
  String get stepCurrent => ', current';

  @override
  String get stepCompleted => ', completed';

  @override
  String get deleteAllData => 'Delete All Data';

  @override
  String get deleteAllDataTitle => 'Delete All Data';

  @override
  String get deleteAllDataMessage =>
      'This will permanently delete all your meals, water intake, weight entries, and profile data. This action cannot be undone.';

  @override
  String get deleteAllDataWarning => 'Warning: This is irreversible!';

  @override
  String get deleteAllDataFinalConfirm =>
      'Are you sure? All your data will be lost forever.';

  @override
  String get deleteAllDataConfirm => 'Delete Everything';

  @override
  String get dataDeleted => 'All data has been deleted';
}
