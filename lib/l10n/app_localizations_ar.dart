// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get navHome => 'الرئيسية';

  @override
  String get navLog => 'السجل';

  @override
  String get navDiscover => 'اكتشف';

  @override
  String get navProgress => 'متابعة';

  @override
  String get navProfile => 'الملف الشخصي';

  @override
  String get discoverTitle => 'اكتشف';

  @override
  String recipesToExplore(int count) {
    return '$count وصفة للاستكشاف';
  }

  @override
  String get searchRecipes => 'ابحث عن وصفات...';

  @override
  String get featured => 'مميز';

  @override
  String get allRecipes => 'جميع الوصفات';

  @override
  String recipesCount(int count) {
    return '$count وصفة';
  }

  @override
  String get noRecipesFound => 'لم يتم العثور على وصفات';

  @override
  String get nutritionPerServing => 'القيمة الغذائية لكل حصة';

  @override
  String get method => 'طريقة التحضير';

  @override
  String viewOnSource(String source) {
    return 'عرض على $source';
  }

  @override
  String get clearSearch => 'مسح البحث';

  @override
  String get todaysLog => 'سجل اليوم';

  @override
  String get searchFoodsToAdd => 'ابحث عن أطعمة لإضافتها...';

  @override
  String get quickAdd => 'إضافة سريعة';

  @override
  String get todaysMeals => 'وجبات اليوم';

  @override
  String get noMealsLogged => 'لم يتم تسجيل وجبات اليوم';

  @override
  String get tapAddFood => 'اضغط \"إضافة طعام\" أو استخدم الإضافة السريعة';

  @override
  String get addFood => 'إضافة طعام';

  @override
  String get addItem => 'إضافة عنصر';

  @override
  String get deleteMeal => 'حذف الوجبة';

  @override
  String get deleteMealTitle => 'حذف الوجبة';

  @override
  String deleteMealConfirm(String mealType) {
    return 'هل تريد إزالة $mealType وجميع عناصرها؟';
  }

  @override
  String get dailySummary => 'الملخص اليومي';

  @override
  String get consumed => 'المستهلك';

  @override
  String get remaining => 'المتبقي';

  @override
  String get goal => 'الهدف';

  @override
  String get servingSize => 'حجم الحصة';

  @override
  String get customAmount => 'كمية مخصصة';

  @override
  String addTo(String mealType) {
    return 'إضافة إلى $mealType';
  }

  @override
  String get mealOptions => 'خيارات الوجبة';

  @override
  String get myProfile => 'الملف الشخصي';

  @override
  String get dailyGoals => 'الأهداف اليومية';

  @override
  String get recalculate => 'إعادة الحساب';

  @override
  String get recalculateGoals => 'إعادة حساب الأهداف';

  @override
  String get recalculateMessage =>
      'سيتم إعادة حساب جميع أهدافك الغذائية اليومية بناءً على معلومات جسمك الحالية (الجنس، الطول، الوزن، العمر، مستوى النشاط).\n\nسيتم استبدال أي تعديلات يدوية على الأهداف الفردية.';

  @override
  String get bodyInfo => 'معلومات الجسم';

  @override
  String get preferences => 'التفضيلات';

  @override
  String get account => 'الحساب';

  @override
  String get darkMode => 'الوضع الداكن';

  @override
  String get language => 'اللغة';

  @override
  String get english => 'English';

  @override
  String get arabic => 'العربية';

  @override
  String get chooseLanguage => 'اختر اللغة';

  @override
  String get exportData => 'تصدير البيانات';

  @override
  String get privacyPolicy => 'سياسة الخصوصية';

  @override
  String get helpSupport => 'المساعدة والدعم';

  @override
  String get dataExported => 'تم تصدير البيانات!';

  @override
  String get exportFailed => 'فشل التصدير. يرجى المحاولة مرة أخرى.';

  @override
  String get gender => 'الجنس';

  @override
  String get male => 'ذكر';

  @override
  String get female => 'أنثى';

  @override
  String get height => 'الطول';

  @override
  String get weight => 'الوزن';

  @override
  String get age => 'العمر';

  @override
  String get activityLevel => 'مستوى النشاط';

  @override
  String get dietType => 'نوع النظام الغذائي';

  @override
  String get sedentary => 'خامل';

  @override
  String get sedentaryDesc => 'قليل أو بدون تمارين';

  @override
  String get light => 'خفيف';

  @override
  String get lightDesc => 'تمارين خفيفة ١-٣ أيام/أسبوع';

  @override
  String get moderate => 'معتدل';

  @override
  String get moderateDesc => 'تمارين معتدلة ٣-٥ أيام/أسبوع';

  @override
  String get active => 'نشيط';

  @override
  String get activeDesc => 'تمارين شاقة ٦-٧ أيام/أسبوع';

  @override
  String get veryActive => 'نشيط جداً';

  @override
  String get veryActiveDesc => 'تمارين شاقة جداً ووظيفة بدنية';

  @override
  String get omnivore => 'مرن';

  @override
  String get omnivoreDesc => 'بدون قيود غذائية';

  @override
  String get vegetarian => 'نباتي';

  @override
  String get vegetarianDesc => 'بدون لحوم أو أسماك';

  @override
  String get vegan => 'نباتي صرف';

  @override
  String get veganDesc => 'بدون منتجات حيوانية';

  @override
  String get pescatarian => 'نباتي يأكل السمك';

  @override
  String get pescatarianDesc => 'أسماك ومأكولات بحرية، بدون لحوم';

  @override
  String get save => 'حفظ';

  @override
  String get cancel => 'إلغاء';

  @override
  String get delete => 'حذف';

  @override
  String get add => 'إضافة';

  @override
  String get edit => 'تعديل';

  @override
  String get back => 'رجوع';

  @override
  String get next => 'التالي';

  @override
  String get close => 'إغلاق';

  @override
  String get notSet => 'غير محدد';

  @override
  String get calories => 'السعرات';

  @override
  String get protein => 'البروتين';

  @override
  String get carbs => 'الكربوهيدرات';

  @override
  String get fat => 'الدهون';

  @override
  String get fiber => 'الألياف';

  @override
  String get water => 'الماء';

  @override
  String get welcomeTitle => 'مرحباً بك في مساعدة كالوري';

  @override
  String get welcomeSubtitle =>
      'لنخصص أهدافك الغذائية بناءً على جسمك ونمط حياتك.';

  @override
  String get getStarted => 'ابدأ الآن';

  @override
  String get biologicalSex => 'ما هو جنسك البيولوجي؟';

  @override
  String get biologicalSexSubtitle => 'يساعدنا هذا في حساب معدل الأيض الأساسي.';

  @override
  String get yourMeasurements => 'قياساتك';

  @override
  String get measurementsSubtitle =>
      'نستخدمها لتقدير احتياجاتك اليومية من الطاقة.';

  @override
  String get ageRangeQuestion => 'ما هو نطاق عمرك؟';

  @override
  String get ageRangeSubtitle => 'العمر يؤثر على معدل الأيض.';

  @override
  String get activityQuestion => 'ما مدى نشاطك؟';

  @override
  String get activitySubtitle => 'يحدد هذا مضاعف السعرات الحرارية اليومية.';

  @override
  String get dietTypeQuestion => 'ما هو نوع نظامك الغذائي؟';

  @override
  String get dietTypeSubtitle =>
      'يساعد في تخصيص نسب المغذيات الكبرى. يمكنك التخطي.';

  @override
  String get yourDailyGoals => 'أهدافك اليومية';

  @override
  String get goalsRecommendation => 'بناءً على ملفك الشخصي، إليك ما نوصي به.';

  @override
  String get letsGo => 'هيا بنا!';

  @override
  String get goBack => 'رجوع';

  @override
  String get foodName => 'اسم الطعام';

  @override
  String get meal => 'الوجبة';

  @override
  String noFoodsFound(String query) {
    return 'لم يتم العثور على أطعمة لـ \"$query\"';
  }

  @override
  String resultCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count نتيجة',
      many: '$count نتيجة',
      few: '$count نتائج',
      two: 'نتيجتان',
      one: 'نتيجة واحدة',
      zero: 'لا نتائج',
    );
    return '$_temp0';
  }

  @override
  String addedToMeal(String food, String mealType) {
    return 'تمت إضافة $food إلى $mealType';
  }

  @override
  String removed(String item) {
    return 'تمت إزالة $item';
  }

  @override
  String deleted(String item) {
    return 'تم حذف $item';
  }

  @override
  String addedText(String item) {
    return 'تمت إضافة $item';
  }

  @override
  String failedToAdd(String error) {
    return 'فشل في الإضافة: $error';
  }

  @override
  String failedToDelete(String error) {
    return 'فشل في الحذف: $error';
  }

  @override
  String failedToRemove(String error) {
    return 'فشل في الإزالة: $error';
  }

  @override
  String get breakfast => 'فطور';

  @override
  String get lunch => 'غداء';

  @override
  String get dinner => 'عشاء';

  @override
  String get snack => 'وجبة خفيفة';

  @override
  String get dessert => 'حلوى';

  @override
  String get all => 'الكل';

  @override
  String get appVersion => 'مساعدة كالوري الإصدار 1.0.0';

  @override
  String get goodMorning => 'صباح الخير';

  @override
  String get goodAfternoon => 'مساء الخير';

  @override
  String get goodEvening => 'مساء الخير';

  @override
  String get kaloryHelp => 'كالوري';

  @override
  String get toggleTheme => 'تبديل المظهر';

  @override
  String get tipOfTheDay => 'نصيحة اليوم';

  @override
  String get progressTitle => 'متابعة';

  @override
  String get week => 'أسبوع';

  @override
  String get month => 'شهر';

  @override
  String get threeMonths => '٣ أشهر';

  @override
  String get weightTrend => 'اتجاه الوزن';

  @override
  String get noWeightData => 'لا توجد بيانات وزن';

  @override
  String weightChartLabel(int count) {
    return 'رسم بياني لاتجاه الوزن يعرض $count نقطة بيانات';
  }

  @override
  String get current => 'الحالي';

  @override
  String get change => 'التغيير';

  @override
  String get bmi => 'مؤشر كتلة الجسم';

  @override
  String get underweight => 'نحيف';

  @override
  String get normal => 'طبيعي';

  @override
  String get overweight => 'زائد الوزن';

  @override
  String get obese => 'سمين';

  @override
  String get na => 'غ/م';

  @override
  String get calorieTrends => 'اتجاهات السعرات';

  @override
  String get noCalorieData => 'لا توجد بيانات سعرات';

  @override
  String get nutritionAverages => 'متوسطات التغذية';

  @override
  String get dailyAverageThisWeek => 'المتوسط اليومي هذا الأسبوع';

  @override
  String get streaksAchievements => 'السلاسل والإنجازات';

  @override
  String get loggingStreak => 'سلسلة التسجيل';

  @override
  String get waterStreak => 'سلسلة الماء';

  @override
  String get weeklyGoalsMet => 'الأهداف الأسبوعية المحققة';

  @override
  String daysCount(int count) {
    return '$count يوم';
  }

  @override
  String countOfFour(int count) {
    return '$count من 4';
  }

  @override
  String get faq => 'الأسئلة الشائعة';

  @override
  String get faqDataStoredQ => 'كيف يتم تخزين بياناتي؟';

  @override
  String get faqDataStoredA =>
      'يتم تخزين جميع بياناتك محلياً على جهازك باستخدام Hive، قاعدة بيانات محلية خفيفة. لا يتم إرسال أي شيء إلى خادم. بيانات التغذية الخاصة بك لا تغادر جهازك أبداً.';

  @override
  String get faqExportQ => 'هل يمكنني تصدير بياناتي؟';

  @override
  String get faqExportA =>
      'نعم! اذهب إلى الملف الشخصي > تصدير البيانات لتنزيل ملف JSON يحتوي على جميع وجباتك واستهلاك الماء وإدخالات الوزن ومعلومات الملف الشخصي.';

  @override
  String get faqResetQ => 'كيف أعيد تعيين بياناتي؟';

  @override
  String get faqResetA =>
      'يمكنك مسح جميع بياناتك باستخدام خيار \"حذف جميع البيانات\" في الملف الشخصي > الإعدادات، أو عن طريق إلغاء تثبيت التطبيق وإعادة تثبيته.';

  @override
  String get faqSyncQ => 'هل تتم مزامنة بياناتي في أي مكان؟';

  @override
  String get faqSyncA =>
      'لا. مساعدة كالوري يعمل بالكامل بدون اتصال. لا توجد حسابات ولا مزامنة سحابية ولا قواعد بيانات عن بُعد. بياناتك موجودة فقط على هذا الجهاز.';

  @override
  String get aboutKaloryHelp => 'حول مساعدة كالوري';

  @override
  String get version => 'الإصدار 1.0.0';

  @override
  String get aboutDescription =>
      'مساعدة كالوري هو تطبيق تتبع تغذية يركز على الخصوصية ويعمل بالكامل على جهازك. تتبع الوجبات واستهلاك الماء والوزن — كل ذلك بدون حساب أو اتصال بالإنترنت.\n\nإخلاء مسؤولية: هذا التطبيق لأغراض إعلامية فقط وليس بديلاً عن الاستشارة الطبية أو الغذائية المتخصصة.';

  @override
  String get privacyPolicyTitle => 'سياسة الخصوصية';

  @override
  String get lastUpdated => 'آخر تحديث: فبراير 2026';

  @override
  String get privacyDataStaysTitle => 'بياناتك تبقى على جهازك';

  @override
  String get privacyDataStaysBody =>
      'مساعدة كالوري هو تطبيق تتبع تغذية يعمل بالكامل بدون اتصال. جميع البيانات التي تدخلها — بما في ذلك الوجبات واستهلاك الماء والوزن ومعلومات الملف الشخصي — يتم تخزينها حصرياً على جهازك. لا يتم إرسال أي شيء إلى أي خادم.';

  @override
  String get privacyNoCollectionTitle => 'لا جمع للبيانات';

  @override
  String get privacyNoCollectionBody =>
      'نحن لا نجمع أو ننقل أو نخزن أي معلومات شخصية. لا توجد حسابات مستخدمين ولا مزامنة سحابية ولا قواعد بيانات عن بُعد.';

  @override
  String get privacyNoAnalyticsTitle => 'لا تحليلات أو تتبع';

  @override
  String get privacyNoAnalyticsBody =>
      'مساعدة كالوري لا يستخدم أي خدمات تحليلات أو حزم SDK إعلانية أو تقنيات تتبع. نحن لا نتتبع أنماط استخدامك أو موقعك أو أي بيانات سلوكية أخرى.';

  @override
  String get privacyNoSharingTitle => 'لا مشاركة مع أطراف ثالثة';

  @override
  String get privacyNoSharingBody =>
      'بما أنه لا تغادر أي بيانات جهازك، فلا يوجد شيء لمشاركته مع أطراف ثالثة. بيانات التغذية الخاصة بك هي ملكك وحدك.';

  @override
  String get privacyDeletionTitle => 'حذف البيانات';

  @override
  String get privacyDeletionBody =>
      'يمكنك حذف جميع بياناتك في أي وقت باستخدام خيار \"حذف جميع البيانات\" في الملف الشخصي > الإعدادات، أو عن طريق إلغاء تثبيت التطبيق. بمجرد الحذف، لا يمكن استرداد البيانات — لأننا لم نحتفظ بنسخة منها أبداً.';

  @override
  String get privacyContactTitle => 'التواصل';

  @override
  String get privacyContactBody =>
      'إذا كان لديك أي أسئلة حول سياسة الخصوصية هذه، يرجى التواصل عبر صفحة التطبيق في المتجر.';

  @override
  String get dayFlow => 'تدفق اليوم';

  @override
  String mealsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count وجبة',
      many: '$count وجبة',
      few: '$count وجبات',
      two: 'وجبتان',
      one: 'وجبة واحدة',
      zero: 'لا وجبات',
    );
    return '$_temp0';
  }

  @override
  String get noMealsLoggedYet => 'لم يتم تسجيل وجبات بعد';

  @override
  String get hydration => 'الترطيب';

  @override
  String get tapToAddGlass => 'اضغط لإضافة كوب';

  @override
  String get waterIntake => 'استهلاك الماء';

  @override
  String glassesToday(int current, int goal) {
    return '$current / $goal أكواب اليوم';
  }

  @override
  String get remainingLabel => 'متبقي';

  @override
  String get overLabel => 'زائد';

  @override
  String get kaloryScore => 'نقاط مساعدة كالوري';

  @override
  String get scoreBreakdown => 'تفاصيل النقاط';

  @override
  String get calorieAdherence => 'الالتزام بالسعرات';

  @override
  String get macroBalance => 'توازن العناصر الغذائية';

  @override
  String get perfectDay => 'يوم مثالي!';

  @override
  String get greatBalance => 'توازن رائع!';

  @override
  String get gettingThere => 'في الطريق الصحيح';

  @override
  String get needsAttention => 'يحتاج انتباه';

  @override
  String get foodBanana => 'موز';

  @override
  String get foodChickenBreast => 'صدر دجاج';

  @override
  String get foodRice => 'أرز';

  @override
  String get foodEggs => 'بيض';

  @override
  String get foodOatmeal => 'شوفان';

  @override
  String get foodApple => 'تفاحة';

  @override
  String get foodYogurt => 'زبادي';

  @override
  String proteinGrams(String value) {
    return '$valueجم بروتين';
  }

  @override
  String kcalPer100g(int kcal) {
    return '$kcal سعرة حرارية / 100جم';
  }

  @override
  String kcalPerServing(int kcal) {
    return '$kcal سعرة حرارية / حصة';
  }

  @override
  String get foodOatmealWithBerries => 'شوفان بالتوت';

  @override
  String get foodGreekYogurt => 'زبادي يوناني';

  @override
  String get foodBlackCoffee => 'قهوة سوداء';

  @override
  String get foodAlmonds10 => 'لوز (10)';

  @override
  String get foodGrilledChickenSalad => 'سلطة دجاج مشوي';

  @override
  String get foodWholeWheatRoll => 'خبز القمح الكامل';

  @override
  String get kcalUnit => 'سعرة حرارية';

  @override
  String get gramUnit => 'جم';

  @override
  String get cmUnit => 'سم';

  @override
  String get kgUnit => 'كجم';

  @override
  String get glassesUnit => 'أكواب';

  @override
  String get yearsUnit => 'سنة';

  @override
  String get catVegetables => 'خضروات';

  @override
  String get catFruit => 'فواكه';

  @override
  String get catMeat => 'لحوم ومنتجات اللحوم';

  @override
  String get catFish => 'أسماك ومنتجات الأسماك';

  @override
  String get catCereals => 'حبوب ومنتجات الحبوب';

  @override
  String get catNuts => 'مكسرات وبذور';

  @override
  String get catMilk => 'حليب ومنتجات الألبان';

  @override
  String get catEggs => 'بيض';

  @override
  String get catBeverages => 'مشروبات';

  @override
  String get difficultyEasy => 'سهل';

  @override
  String get difficultyMedium => 'متوسط';

  @override
  String get difficultyHard => 'صعب';

  @override
  String get minuteShort => 'دقيقة';

  @override
  String get servingsLabel => 'حصص';

  @override
  String get tapToEdit => 'اضغط للتعديل';

  @override
  String stepIndicator(int step, int total) {
    return 'الخطوة $step من $total';
  }

  @override
  String get stepCurrent => '، الحالية';

  @override
  String get stepCompleted => '، مكتملة';

  @override
  String get deleteAllData => 'حذف جميع البيانات';

  @override
  String get deleteAllDataTitle => 'حذف جميع البيانات';

  @override
  String get deleteAllDataMessage =>
      'سيتم حذف جميع وجباتك واستهلاك الماء وإدخالات الوزن وبيانات الملف الشخصي نهائياً. لا يمكن التراجع عن هذا الإجراء.';

  @override
  String get deleteAllDataWarning => 'تحذير: لا يمكن التراجع!';

  @override
  String get deleteAllDataFinalConfirm =>
      'هل أنت متأكد؟ ستفقد جميع بياناتك للأبد.';

  @override
  String get deleteAllDataConfirm => 'حذف الكل';

  @override
  String get dataDeleted => 'تم حذف جميع البيانات';
}
