import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navLog.
  ///
  /// In en, this message translates to:
  /// **'Log'**
  String get navLog;

  /// No description provided for @navDiscover.
  ///
  /// In en, this message translates to:
  /// **'Discover'**
  String get navDiscover;

  /// No description provided for @navProgress.
  ///
  /// In en, this message translates to:
  /// **'Progress'**
  String get navProgress;

  /// No description provided for @navProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navProfile;

  /// No description provided for @discoverTitle.
  ///
  /// In en, this message translates to:
  /// **'Discover'**
  String get discoverTitle;

  /// No description provided for @recipesToExplore.
  ///
  /// In en, this message translates to:
  /// **'{count} recipes to explore'**
  String recipesToExplore(int count);

  /// No description provided for @searchRecipes.
  ///
  /// In en, this message translates to:
  /// **'Search recipes...'**
  String get searchRecipes;

  /// No description provided for @featured.
  ///
  /// In en, this message translates to:
  /// **'FEATURED'**
  String get featured;

  /// No description provided for @allRecipes.
  ///
  /// In en, this message translates to:
  /// **'All Recipes'**
  String get allRecipes;

  /// No description provided for @recipesCount.
  ///
  /// In en, this message translates to:
  /// **'{count} recipes'**
  String recipesCount(int count);

  /// No description provided for @noRecipesFound.
  ///
  /// In en, this message translates to:
  /// **'No recipes found'**
  String get noRecipesFound;

  /// No description provided for @nutritionPerServing.
  ///
  /// In en, this message translates to:
  /// **'Nutrition per serving'**
  String get nutritionPerServing;

  /// No description provided for @method.
  ///
  /// In en, this message translates to:
  /// **'Method'**
  String get method;

  /// No description provided for @viewOnSource.
  ///
  /// In en, this message translates to:
  /// **'View on {source}'**
  String viewOnSource(String source);

  /// No description provided for @clearSearch.
  ///
  /// In en, this message translates to:
  /// **'Clear search'**
  String get clearSearch;

  /// No description provided for @todaysLog.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Log'**
  String get todaysLog;

  /// No description provided for @searchFoodsToAdd.
  ///
  /// In en, this message translates to:
  /// **'Search foods to add...'**
  String get searchFoodsToAdd;

  /// No description provided for @quickAdd.
  ///
  /// In en, this message translates to:
  /// **'Quick Add'**
  String get quickAdd;

  /// No description provided for @todaysMeals.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Meals'**
  String get todaysMeals;

  /// No description provided for @noMealsLogged.
  ///
  /// In en, this message translates to:
  /// **'No meals logged yet today'**
  String get noMealsLogged;

  /// No description provided for @tapAddFood.
  ///
  /// In en, this message translates to:
  /// **'Tap \"Add Food\" or use Quick Add above'**
  String get tapAddFood;

  /// No description provided for @addFood.
  ///
  /// In en, this message translates to:
  /// **'Add Food'**
  String get addFood;

  /// No description provided for @addItem.
  ///
  /// In en, this message translates to:
  /// **'Add item'**
  String get addItem;

  /// No description provided for @deleteMeal.
  ///
  /// In en, this message translates to:
  /// **'Delete meal'**
  String get deleteMeal;

  /// No description provided for @deleteMealTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Meal'**
  String get deleteMealTitle;

  /// No description provided for @deleteMealConfirm.
  ///
  /// In en, this message translates to:
  /// **'Remove {mealType} and all its food items?'**
  String deleteMealConfirm(String mealType);

  /// No description provided for @dailySummary.
  ///
  /// In en, this message translates to:
  /// **'Daily Summary'**
  String get dailySummary;

  /// No description provided for @consumed.
  ///
  /// In en, this message translates to:
  /// **'Consumed'**
  String get consumed;

  /// No description provided for @remaining.
  ///
  /// In en, this message translates to:
  /// **'Remaining'**
  String get remaining;

  /// No description provided for @goal.
  ///
  /// In en, this message translates to:
  /// **'Goal'**
  String get goal;

  /// No description provided for @servingSize.
  ///
  /// In en, this message translates to:
  /// **'Serving size'**
  String get servingSize;

  /// No description provided for @customAmount.
  ///
  /// In en, this message translates to:
  /// **'Custom amount'**
  String get customAmount;

  /// No description provided for @addTo.
  ///
  /// In en, this message translates to:
  /// **'Add to {mealType}'**
  String addTo(String mealType);

  /// No description provided for @mealOptions.
  ///
  /// In en, this message translates to:
  /// **'Meal options'**
  String get mealOptions;

  /// No description provided for @myProfile.
  ///
  /// In en, this message translates to:
  /// **'My Profile'**
  String get myProfile;

  /// No description provided for @dailyGoals.
  ///
  /// In en, this message translates to:
  /// **'Daily Goals'**
  String get dailyGoals;

  /// No description provided for @recalculate.
  ///
  /// In en, this message translates to:
  /// **'Recalculate'**
  String get recalculate;

  /// No description provided for @recalculateGoals.
  ///
  /// In en, this message translates to:
  /// **'Recalculate Goals'**
  String get recalculateGoals;

  /// No description provided for @recalculateMessage.
  ///
  /// In en, this message translates to:
  /// **'This will recalculate all your daily nutrition goals based on your current body info (gender, height, weight, age, activity level).\n\nAny manual edits to individual goals will be overwritten.'**
  String get recalculateMessage;

  /// No description provided for @bodyInfo.
  ///
  /// In en, this message translates to:
  /// **'Body Info'**
  String get bodyInfo;

  /// No description provided for @preferences.
  ///
  /// In en, this message translates to:
  /// **'Preferences'**
  String get preferences;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @arabic.
  ///
  /// In en, this message translates to:
  /// **'العربية'**
  String get arabic;

  /// No description provided for @chooseLanguage.
  ///
  /// In en, this message translates to:
  /// **'Choose Language'**
  String get chooseLanguage;

  /// No description provided for @exportData.
  ///
  /// In en, this message translates to:
  /// **'Export Data'**
  String get exportData;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @helpSupport.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get helpSupport;

  /// No description provided for @dataExported.
  ///
  /// In en, this message translates to:
  /// **'Data exported!'**
  String get dataExported;

  /// No description provided for @exportFailed.
  ///
  /// In en, this message translates to:
  /// **'Export failed. Please try again.'**
  String get exportFailed;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// No description provided for @height.
  ///
  /// In en, this message translates to:
  /// **'Height'**
  String get height;

  /// No description provided for @weight.
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get weight;

  /// No description provided for @age.
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get age;

  /// No description provided for @activityLevel.
  ///
  /// In en, this message translates to:
  /// **'Activity Level'**
  String get activityLevel;

  /// No description provided for @dietType.
  ///
  /// In en, this message translates to:
  /// **'Diet Type'**
  String get dietType;

  /// No description provided for @sedentary.
  ///
  /// In en, this message translates to:
  /// **'Sedentary'**
  String get sedentary;

  /// No description provided for @sedentaryDesc.
  ///
  /// In en, this message translates to:
  /// **'Little to no exercise'**
  String get sedentaryDesc;

  /// No description provided for @light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// No description provided for @lightDesc.
  ///
  /// In en, this message translates to:
  /// **'Light exercise 1-3 days/week'**
  String get lightDesc;

  /// No description provided for @moderate.
  ///
  /// In en, this message translates to:
  /// **'Moderate'**
  String get moderate;

  /// No description provided for @moderateDesc.
  ///
  /// In en, this message translates to:
  /// **'Moderate exercise 3-5 days/week'**
  String get moderateDesc;

  /// No description provided for @active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get active;

  /// No description provided for @activeDesc.
  ///
  /// In en, this message translates to:
  /// **'Hard exercise 6-7 days/week'**
  String get activeDesc;

  /// No description provided for @veryActive.
  ///
  /// In en, this message translates to:
  /// **'Very Active'**
  String get veryActive;

  /// No description provided for @veryActiveDesc.
  ///
  /// In en, this message translates to:
  /// **'Very hard exercise & physical job'**
  String get veryActiveDesc;

  /// No description provided for @omnivore.
  ///
  /// In en, this message translates to:
  /// **'Flexible'**
  String get omnivore;

  /// No description provided for @omnivoreDesc.
  ///
  /// In en, this message translates to:
  /// **'No dietary restrictions'**
  String get omnivoreDesc;

  /// No description provided for @vegetarian.
  ///
  /// In en, this message translates to:
  /// **'Vegetarian'**
  String get vegetarian;

  /// No description provided for @vegetarianDesc.
  ///
  /// In en, this message translates to:
  /// **'No meat or fish'**
  String get vegetarianDesc;

  /// No description provided for @vegan.
  ///
  /// In en, this message translates to:
  /// **'Vegan'**
  String get vegan;

  /// No description provided for @veganDesc.
  ///
  /// In en, this message translates to:
  /// **'No animal products at all'**
  String get veganDesc;

  /// No description provided for @pescatarian.
  ///
  /// In en, this message translates to:
  /// **'Pescatarian'**
  String get pescatarian;

  /// No description provided for @pescatarianDesc.
  ///
  /// In en, this message translates to:
  /// **'Fish & seafood, no meat'**
  String get pescatarianDesc;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @notSet.
  ///
  /// In en, this message translates to:
  /// **'Not set'**
  String get notSet;

  /// No description provided for @calories.
  ///
  /// In en, this message translates to:
  /// **'Calories'**
  String get calories;

  /// No description provided for @protein.
  ///
  /// In en, this message translates to:
  /// **'Protein'**
  String get protein;

  /// No description provided for @carbs.
  ///
  /// In en, this message translates to:
  /// **'Carbs'**
  String get carbs;

  /// No description provided for @fat.
  ///
  /// In en, this message translates to:
  /// **'Fat'**
  String get fat;

  /// No description provided for @fiber.
  ///
  /// In en, this message translates to:
  /// **'Fiber'**
  String get fiber;

  /// No description provided for @water.
  ///
  /// In en, this message translates to:
  /// **'Water'**
  String get water;

  /// No description provided for @welcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Kalory Help'**
  String get welcomeTitle;

  /// No description provided for @welcomeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Let\'s personalize your nutrition goals based on your body and lifestyle.'**
  String get welcomeSubtitle;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// No description provided for @biologicalSex.
  ///
  /// In en, this message translates to:
  /// **'What\'s your biological sex?'**
  String get biologicalSex;

  /// No description provided for @biologicalSexSubtitle.
  ///
  /// In en, this message translates to:
  /// **'This helps us calculate your basal metabolic rate.'**
  String get biologicalSexSubtitle;

  /// No description provided for @yourMeasurements.
  ///
  /// In en, this message translates to:
  /// **'Your measurements'**
  String get yourMeasurements;

  /// No description provided for @measurementsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'We use these to estimate your daily energy needs.'**
  String get measurementsSubtitle;

  /// No description provided for @ageRangeQuestion.
  ///
  /// In en, this message translates to:
  /// **'What\'s your age range?'**
  String get ageRangeQuestion;

  /// No description provided for @ageRangeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Age affects your metabolic rate.'**
  String get ageRangeSubtitle;

  /// No description provided for @activityQuestion.
  ///
  /// In en, this message translates to:
  /// **'How active are you?'**
  String get activityQuestion;

  /// No description provided for @activitySubtitle.
  ///
  /// In en, this message translates to:
  /// **'This determines your daily calorie multiplier.'**
  String get activitySubtitle;

  /// No description provided for @dietTypeQuestion.
  ///
  /// In en, this message translates to:
  /// **'What\'s your diet type?'**
  String get dietTypeQuestion;

  /// No description provided for @dietTypeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'This helps tailor your macro ratios. You can skip this.'**
  String get dietTypeSubtitle;

  /// No description provided for @yourDailyGoals.
  ///
  /// In en, this message translates to:
  /// **'Your Daily Goals'**
  String get yourDailyGoals;

  /// No description provided for @goalsRecommendation.
  ///
  /// In en, this message translates to:
  /// **'Based on your profile, here\'s what we recommend.'**
  String get goalsRecommendation;

  /// No description provided for @letsGo.
  ///
  /// In en, this message translates to:
  /// **'Let\'s Go!'**
  String get letsGo;

  /// No description provided for @goBack.
  ///
  /// In en, this message translates to:
  /// **'Go Back'**
  String get goBack;

  /// No description provided for @foodName.
  ///
  /// In en, this message translates to:
  /// **'Food name'**
  String get foodName;

  /// No description provided for @meal.
  ///
  /// In en, this message translates to:
  /// **'Meal'**
  String get meal;

  /// No description provided for @noFoodsFound.
  ///
  /// In en, this message translates to:
  /// **'No foods found for \"{query}\"'**
  String noFoodsFound(String query);

  /// No description provided for @resultCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No results} =1{1 result} other{{count} results}}'**
  String resultCount(int count);

  /// No description provided for @addedToMeal.
  ///
  /// In en, this message translates to:
  /// **'{food} added to {mealType}'**
  String addedToMeal(String food, String mealType);

  /// No description provided for @removed.
  ///
  /// In en, this message translates to:
  /// **'{item} removed'**
  String removed(String item);

  /// No description provided for @deleted.
  ///
  /// In en, this message translates to:
  /// **'{item} deleted'**
  String deleted(String item);

  /// No description provided for @addedText.
  ///
  /// In en, this message translates to:
  /// **'{item} added'**
  String addedText(String item);

  /// No description provided for @failedToAdd.
  ///
  /// In en, this message translates to:
  /// **'Failed to add: {error}'**
  String failedToAdd(String error);

  /// No description provided for @failedToDelete.
  ///
  /// In en, this message translates to:
  /// **'Failed to delete: {error}'**
  String failedToDelete(String error);

  /// No description provided for @failedToRemove.
  ///
  /// In en, this message translates to:
  /// **'Failed to remove: {error}'**
  String failedToRemove(String error);

  /// No description provided for @breakfast.
  ///
  /// In en, this message translates to:
  /// **'Breakfast'**
  String get breakfast;

  /// No description provided for @lunch.
  ///
  /// In en, this message translates to:
  /// **'Lunch'**
  String get lunch;

  /// No description provided for @dinner.
  ///
  /// In en, this message translates to:
  /// **'Dinner'**
  String get dinner;

  /// No description provided for @snack.
  ///
  /// In en, this message translates to:
  /// **'Snack'**
  String get snack;

  /// No description provided for @dessert.
  ///
  /// In en, this message translates to:
  /// **'Dessert'**
  String get dessert;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @appVersion.
  ///
  /// In en, this message translates to:
  /// **'Kalory Help v1.0.0'**
  String get appVersion;

  /// No description provided for @goodMorning.
  ///
  /// In en, this message translates to:
  /// **'Good morning'**
  String get goodMorning;

  /// No description provided for @goodAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Good afternoon'**
  String get goodAfternoon;

  /// No description provided for @goodEvening.
  ///
  /// In en, this message translates to:
  /// **'Good evening'**
  String get goodEvening;

  /// No description provided for @kaloryHelp.
  ///
  /// In en, this message translates to:
  /// **'Kalory Help'**
  String get kaloryHelp;

  /// No description provided for @toggleTheme.
  ///
  /// In en, this message translates to:
  /// **'Toggle theme'**
  String get toggleTheme;

  /// No description provided for @tipOfTheDay.
  ///
  /// In en, this message translates to:
  /// **'Tip of the Day'**
  String get tipOfTheDay;

  /// No description provided for @progressTitle.
  ///
  /// In en, this message translates to:
  /// **'Progress'**
  String get progressTitle;

  /// No description provided for @week.
  ///
  /// In en, this message translates to:
  /// **'Week'**
  String get week;

  /// No description provided for @month.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get month;

  /// No description provided for @threeMonths.
  ///
  /// In en, this message translates to:
  /// **'3 Months'**
  String get threeMonths;

  /// No description provided for @weightTrend.
  ///
  /// In en, this message translates to:
  /// **'Weight Trend'**
  String get weightTrend;

  /// No description provided for @noWeightData.
  ///
  /// In en, this message translates to:
  /// **'No weight data'**
  String get noWeightData;

  /// No description provided for @weightChartLabel.
  ///
  /// In en, this message translates to:
  /// **'Weight trend chart showing {count} data points'**
  String weightChartLabel(int count);

  /// No description provided for @current.
  ///
  /// In en, this message translates to:
  /// **'Current'**
  String get current;

  /// No description provided for @change.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get change;

  /// No description provided for @bmi.
  ///
  /// In en, this message translates to:
  /// **'BMI'**
  String get bmi;

  /// No description provided for @underweight.
  ///
  /// In en, this message translates to:
  /// **'Underweight'**
  String get underweight;

  /// No description provided for @normal.
  ///
  /// In en, this message translates to:
  /// **'Normal'**
  String get normal;

  /// No description provided for @overweight.
  ///
  /// In en, this message translates to:
  /// **'Overweight'**
  String get overweight;

  /// No description provided for @obese.
  ///
  /// In en, this message translates to:
  /// **'Obese'**
  String get obese;

  /// No description provided for @na.
  ///
  /// In en, this message translates to:
  /// **'N/A'**
  String get na;

  /// No description provided for @calorieTrends.
  ///
  /// In en, this message translates to:
  /// **'Calorie Trends'**
  String get calorieTrends;

  /// No description provided for @noCalorieData.
  ///
  /// In en, this message translates to:
  /// **'No calorie data'**
  String get noCalorieData;

  /// No description provided for @nutritionAverages.
  ///
  /// In en, this message translates to:
  /// **'Nutrition Averages'**
  String get nutritionAverages;

  /// No description provided for @dailyAverageThisWeek.
  ///
  /// In en, this message translates to:
  /// **'Daily average this week'**
  String get dailyAverageThisWeek;

  /// No description provided for @streaksAchievements.
  ///
  /// In en, this message translates to:
  /// **'STREAKS & ACHIEVEMENTS'**
  String get streaksAchievements;

  /// No description provided for @loggingStreak.
  ///
  /// In en, this message translates to:
  /// **'Logging Streak'**
  String get loggingStreak;

  /// No description provided for @waterStreak.
  ///
  /// In en, this message translates to:
  /// **'Water Streak'**
  String get waterStreak;

  /// No description provided for @weeklyGoalsMet.
  ///
  /// In en, this message translates to:
  /// **'Weekly Goals Met'**
  String get weeklyGoalsMet;

  /// No description provided for @daysCount.
  ///
  /// In en, this message translates to:
  /// **'{count} days'**
  String daysCount(int count);

  /// No description provided for @countOfFour.
  ///
  /// In en, this message translates to:
  /// **'{count} of 4'**
  String countOfFour(int count);

  /// No description provided for @faq.
  ///
  /// In en, this message translates to:
  /// **'Frequently Asked Questions'**
  String get faq;

  /// No description provided for @faqDataStoredQ.
  ///
  /// In en, this message translates to:
  /// **'How is my data stored?'**
  String get faqDataStoredQ;

  /// No description provided for @faqDataStoredA.
  ///
  /// In en, this message translates to:
  /// **'All your data is stored locally on your device using Hive, a lightweight local database. Nothing is ever sent to a server. Your nutrition data never leaves your device.'**
  String get faqDataStoredA;

  /// No description provided for @faqExportQ.
  ///
  /// In en, this message translates to:
  /// **'Can I export my data?'**
  String get faqExportQ;

  /// No description provided for @faqExportA.
  ///
  /// In en, this message translates to:
  /// **'Yes! Go to Profile > Export Data to download a JSON file containing all your meals, water intake, weight entries, and profile information.'**
  String get faqExportA;

  /// No description provided for @faqResetQ.
  ///
  /// In en, this message translates to:
  /// **'How do I reset my data?'**
  String get faqResetQ;

  /// No description provided for @faqResetA.
  ///
  /// In en, this message translates to:
  /// **'You can clear all your data using the \"Delete All Data\" option in Profile > Settings, or by uninstalling and reinstalling the app.'**
  String get faqResetA;

  /// No description provided for @faqSyncQ.
  ///
  /// In en, this message translates to:
  /// **'Is my data synced anywhere?'**
  String get faqSyncQ;

  /// No description provided for @faqSyncA.
  ///
  /// In en, this message translates to:
  /// **'No. Kalory Help is fully offline. There are no accounts, no cloud sync, and no remote databases. Your data exists only on this device.'**
  String get faqSyncA;

  /// No description provided for @aboutKaloryHelp.
  ///
  /// In en, this message translates to:
  /// **'About Kalory Help'**
  String get aboutKaloryHelp;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version 1.0.0'**
  String get version;

  /// No description provided for @aboutDescription.
  ///
  /// In en, this message translates to:
  /// **'Kalory Help is a privacy-first nutrition tracking app that works entirely on your device. Track meals, water intake, and weight — all without an account or internet connection.\n\nDisclaimer: This app is for informational purposes only and is not a substitute for professional medical or nutritional advice.'**
  String get aboutDescription;

  /// No description provided for @privacyPolicyTitle.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicyTitle;

  /// No description provided for @lastUpdated.
  ///
  /// In en, this message translates to:
  /// **'Last updated: February 2026'**
  String get lastUpdated;

  /// No description provided for @privacyDataStaysTitle.
  ///
  /// In en, this message translates to:
  /// **'Your Data Stays on Your Device'**
  String get privacyDataStaysTitle;

  /// No description provided for @privacyDataStaysBody.
  ///
  /// In en, this message translates to:
  /// **'Kalory Help is a fully offline nutrition tracking app. All data you enter — including meals, water intake, weight, and profile information — is stored exclusively on your device. Nothing is sent to any server.'**
  String get privacyDataStaysBody;

  /// No description provided for @privacyNoCollectionTitle.
  ///
  /// In en, this message translates to:
  /// **'No Data Collection'**
  String get privacyNoCollectionTitle;

  /// No description provided for @privacyNoCollectionBody.
  ///
  /// In en, this message translates to:
  /// **'We do not collect, transmit, or store any personal information. There are no user accounts, no cloud sync, and no remote databases.'**
  String get privacyNoCollectionBody;

  /// No description provided for @privacyNoAnalyticsTitle.
  ///
  /// In en, this message translates to:
  /// **'No Analytics or Tracking'**
  String get privacyNoAnalyticsTitle;

  /// No description provided for @privacyNoAnalyticsBody.
  ///
  /// In en, this message translates to:
  /// **'Kalory Help does not use any analytics services, advertising SDKs, or tracking technologies. We do not track your usage patterns, location, or any other behavioral data.'**
  String get privacyNoAnalyticsBody;

  /// No description provided for @privacyNoSharingTitle.
  ///
  /// In en, this message translates to:
  /// **'No Third-Party Sharing'**
  String get privacyNoSharingTitle;

  /// No description provided for @privacyNoSharingBody.
  ///
  /// In en, this message translates to:
  /// **'Since no data leaves your device, there is nothing to share with third parties. Your nutrition data is yours alone.'**
  String get privacyNoSharingBody;

  /// No description provided for @privacyDeletionTitle.
  ///
  /// In en, this message translates to:
  /// **'Data Deletion'**
  String get privacyDeletionTitle;

  /// No description provided for @privacyDeletionBody.
  ///
  /// In en, this message translates to:
  /// **'You can delete all your data at any time using the \"Delete All Data\" option in Profile > Settings, or by uninstalling the app. Once deleted, data cannot be recovered — because we never had a copy.'**
  String get privacyDeletionBody;

  /// No description provided for @privacyContactTitle.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get privacyContactTitle;

  /// No description provided for @privacyContactBody.
  ///
  /// In en, this message translates to:
  /// **'If you have any questions about this privacy policy, please reach out through the app store listing.'**
  String get privacyContactBody;

  /// No description provided for @dayFlow.
  ///
  /// In en, this message translates to:
  /// **'Day Flow'**
  String get dayFlow;

  /// No description provided for @mealsCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No meals} =1{1 meal} other{{count} meals}}'**
  String mealsCount(int count);

  /// No description provided for @noMealsLoggedYet.
  ///
  /// In en, this message translates to:
  /// **'No meals logged yet'**
  String get noMealsLoggedYet;

  /// No description provided for @hydration.
  ///
  /// In en, this message translates to:
  /// **'Hydration'**
  String get hydration;

  /// No description provided for @tapToAddGlass.
  ///
  /// In en, this message translates to:
  /// **'Tap to add a glass'**
  String get tapToAddGlass;

  /// No description provided for @waterIntake.
  ///
  /// In en, this message translates to:
  /// **'Water intake'**
  String get waterIntake;

  /// No description provided for @glassesToday.
  ///
  /// In en, this message translates to:
  /// **'{current} / {goal} glasses today'**
  String glassesToday(int current, int goal);

  /// No description provided for @remainingLabel.
  ///
  /// In en, this message translates to:
  /// **'remaining'**
  String get remainingLabel;

  /// No description provided for @overLabel.
  ///
  /// In en, this message translates to:
  /// **'over'**
  String get overLabel;

  /// No description provided for @kaloryScore.
  ///
  /// In en, this message translates to:
  /// **'Kalory Score'**
  String get kaloryScore;

  /// No description provided for @scoreBreakdown.
  ///
  /// In en, this message translates to:
  /// **'Score Breakdown'**
  String get scoreBreakdown;

  /// No description provided for @calorieAdherence.
  ///
  /// In en, this message translates to:
  /// **'Calorie Adherence'**
  String get calorieAdherence;

  /// No description provided for @macroBalance.
  ///
  /// In en, this message translates to:
  /// **'Macro Balance'**
  String get macroBalance;

  /// No description provided for @perfectDay.
  ///
  /// In en, this message translates to:
  /// **'Perfect day!'**
  String get perfectDay;

  /// No description provided for @greatBalance.
  ///
  /// In en, this message translates to:
  /// **'Great balance!'**
  String get greatBalance;

  /// No description provided for @gettingThere.
  ///
  /// In en, this message translates to:
  /// **'Getting there'**
  String get gettingThere;

  /// No description provided for @needsAttention.
  ///
  /// In en, this message translates to:
  /// **'Needs attention'**
  String get needsAttention;

  /// No description provided for @foodBanana.
  ///
  /// In en, this message translates to:
  /// **'Banana'**
  String get foodBanana;

  /// No description provided for @foodChickenBreast.
  ///
  /// In en, this message translates to:
  /// **'Chicken Breast'**
  String get foodChickenBreast;

  /// No description provided for @foodRice.
  ///
  /// In en, this message translates to:
  /// **'Rice'**
  String get foodRice;

  /// No description provided for @foodEggs.
  ///
  /// In en, this message translates to:
  /// **'Eggs'**
  String get foodEggs;

  /// No description provided for @foodOatmeal.
  ///
  /// In en, this message translates to:
  /// **'Oatmeal'**
  String get foodOatmeal;

  /// No description provided for @foodApple.
  ///
  /// In en, this message translates to:
  /// **'Apple'**
  String get foodApple;

  /// No description provided for @foodYogurt.
  ///
  /// In en, this message translates to:
  /// **'Yogurt'**
  String get foodYogurt;

  /// No description provided for @proteinGrams.
  ///
  /// In en, this message translates to:
  /// **'{value}g protein'**
  String proteinGrams(String value);

  /// No description provided for @kcalPer100g.
  ///
  /// In en, this message translates to:
  /// **'{kcal} kcal / 100g'**
  String kcalPer100g(int kcal);

  /// No description provided for @kcalPerServing.
  ///
  /// In en, this message translates to:
  /// **'{kcal} kcal / serving'**
  String kcalPerServing(int kcal);

  /// No description provided for @foodOatmealWithBerries.
  ///
  /// In en, this message translates to:
  /// **'Oatmeal with Berries'**
  String get foodOatmealWithBerries;

  /// No description provided for @foodGreekYogurt.
  ///
  /// In en, this message translates to:
  /// **'Greek Yogurt'**
  String get foodGreekYogurt;

  /// No description provided for @foodBlackCoffee.
  ///
  /// In en, this message translates to:
  /// **'Black Coffee'**
  String get foodBlackCoffee;

  /// No description provided for @foodAlmonds10.
  ///
  /// In en, this message translates to:
  /// **'Almonds (10)'**
  String get foodAlmonds10;

  /// No description provided for @foodGrilledChickenSalad.
  ///
  /// In en, this message translates to:
  /// **'Grilled Chicken Salad'**
  String get foodGrilledChickenSalad;

  /// No description provided for @foodWholeWheatRoll.
  ///
  /// In en, this message translates to:
  /// **'Whole Wheat Roll'**
  String get foodWholeWheatRoll;

  /// No description provided for @kcalUnit.
  ///
  /// In en, this message translates to:
  /// **'kcal'**
  String get kcalUnit;

  /// No description provided for @gramUnit.
  ///
  /// In en, this message translates to:
  /// **'g'**
  String get gramUnit;

  /// No description provided for @cmUnit.
  ///
  /// In en, this message translates to:
  /// **'cm'**
  String get cmUnit;

  /// No description provided for @kgUnit.
  ///
  /// In en, this message translates to:
  /// **'kg'**
  String get kgUnit;

  /// No description provided for @glassesUnit.
  ///
  /// In en, this message translates to:
  /// **'glasses'**
  String get glassesUnit;

  /// No description provided for @yearsUnit.
  ///
  /// In en, this message translates to:
  /// **'years'**
  String get yearsUnit;

  /// No description provided for @catVegetables.
  ///
  /// In en, this message translates to:
  /// **'Vegetables'**
  String get catVegetables;

  /// No description provided for @catFruit.
  ///
  /// In en, this message translates to:
  /// **'Fruit'**
  String get catFruit;

  /// No description provided for @catMeat.
  ///
  /// In en, this message translates to:
  /// **'Meat and meat products'**
  String get catMeat;

  /// No description provided for @catFish.
  ///
  /// In en, this message translates to:
  /// **'Fish and fish products'**
  String get catFish;

  /// No description provided for @catCereals.
  ///
  /// In en, this message translates to:
  /// **'Cereals and cereal products'**
  String get catCereals;

  /// No description provided for @catNuts.
  ///
  /// In en, this message translates to:
  /// **'Nuts and seeds'**
  String get catNuts;

  /// No description provided for @catMilk.
  ///
  /// In en, this message translates to:
  /// **'Milk and milk products'**
  String get catMilk;

  /// No description provided for @catEggs.
  ///
  /// In en, this message translates to:
  /// **'Eggs'**
  String get catEggs;

  /// No description provided for @catBeverages.
  ///
  /// In en, this message translates to:
  /// **'Beverages'**
  String get catBeverages;

  /// No description provided for @difficultyEasy.
  ///
  /// In en, this message translates to:
  /// **'Easy'**
  String get difficultyEasy;

  /// No description provided for @difficultyMedium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get difficultyMedium;

  /// No description provided for @difficultyHard.
  ///
  /// In en, this message translates to:
  /// **'Hard'**
  String get difficultyHard;

  /// No description provided for @minuteShort.
  ///
  /// In en, this message translates to:
  /// **'min'**
  String get minuteShort;

  /// No description provided for @servingsLabel.
  ///
  /// In en, this message translates to:
  /// **'servings'**
  String get servingsLabel;

  /// No description provided for @tapToEdit.
  ///
  /// In en, this message translates to:
  /// **'Tap to edit'**
  String get tapToEdit;

  /// No description provided for @stepIndicator.
  ///
  /// In en, this message translates to:
  /// **'Step {step} of {total}'**
  String stepIndicator(int step, int total);

  /// No description provided for @stepCurrent.
  ///
  /// In en, this message translates to:
  /// **', current'**
  String get stepCurrent;

  /// No description provided for @stepCompleted.
  ///
  /// In en, this message translates to:
  /// **', completed'**
  String get stepCompleted;

  /// No description provided for @deleteAllData.
  ///
  /// In en, this message translates to:
  /// **'Delete All Data'**
  String get deleteAllData;

  /// No description provided for @deleteAllDataTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete All Data'**
  String get deleteAllDataTitle;

  /// No description provided for @deleteAllDataMessage.
  ///
  /// In en, this message translates to:
  /// **'This will permanently delete all your meals, water intake, weight entries, and profile data. This action cannot be undone.'**
  String get deleteAllDataMessage;

  /// No description provided for @deleteAllDataWarning.
  ///
  /// In en, this message translates to:
  /// **'Warning: This is irreversible!'**
  String get deleteAllDataWarning;

  /// No description provided for @deleteAllDataFinalConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure? All your data will be lost forever.'**
  String get deleteAllDataFinalConfirm;

  /// No description provided for @deleteAllDataConfirm.
  ///
  /// In en, this message translates to:
  /// **'Delete Everything'**
  String get deleteAllDataConfirm;

  /// No description provided for @dataDeleted.
  ///
  /// In en, this message translates to:
  /// **'All data has been deleted'**
  String get dataDeleted;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
