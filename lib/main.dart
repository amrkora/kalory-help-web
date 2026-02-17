import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'theme/app_theme.dart';
import 'screens/home/home_screen.dart';
import 'screens/log/log_screen.dart';
import 'screens/discover/discover_screen.dart';
import 'screens/progress/progress_screen.dart';
import 'screens/profile/profile_screen.dart';
import 'utils/theme_provider.dart';
import 'utils/locale_provider.dart';
import 'services/database_service.dart';
import 'providers/summary_provider.dart';
import 'providers/meals_provider.dart';
import 'providers/recipes_provider.dart';
import 'providers/progress_provider.dart';
import 'providers/profile_provider.dart';
import 'providers/water_provider.dart';
import 'screens/onboarding/onboarding_screen.dart';
import 'l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Show user-friendly error widget in production instead of red screen
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.error_outline, size: 48, color: AppColors.error),
                const SizedBox(height: 16),
                const Text(
                  'Something went wrong',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Please restart the app.',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  };

  // Log Flutter framework errors
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    debugPrint('Flutter error: ${details.exceptionAsString()}');
  };

  // Catch async errors that escape the framework
  PlatformDispatcher.instance.onError = (error, stack) {
    debugPrint('Unhandled error: $error\n$stack');
    return true;
  };

  await initializeDateFormatting();
  await DatabaseService.initialize();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
        ChangeNotifierProvider(create: (_) => SummaryProvider()),
        ChangeNotifierProvider(create: (_) => MealsProvider()),
        ChangeNotifierProvider(create: (_) => RecipesProvider()),
        ChangeNotifierProvider(create: (_) => ProgressProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => WaterProvider()),
      ],
      child: const KaloryHelpApp(),
    ),
  );
}

class KaloryHelpApp extends StatelessWidget {
  const KaloryHelpApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeProvider, LocaleProvider>(
      builder: (context, themeProvider, localeProvider, _) {
        return MaterialApp(
          onGenerateTitle: (context) =>
              AppLocalizations.of(context)?.kaloryHelp ?? 'Kalory Help',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme(),
          darkTheme: AppTheme.darkTheme(),
          themeMode: themeProvider.themeMode,
          locale: localeProvider.locale,
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          home: DatabaseService.profileBox.get('onboarding_completed') == true
              ? const MainNavigationScreen()
              : const OnboardingScreen(),
        );
      },
    );
  }
}

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late final AnimationController _navBarController;
  late final Animation<Offset> _navBarOffset;
  ScrollDirection _lastDirection = ScrollDirection.idle;

  final List<Widget> _screens = const [
    HomeScreen(),
    LogScreen(),
    DiscoverScreen(),
    ProgressScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _navBarController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _navBarOffset = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, 1),
    ).animate(CurvedAnimation(
      parent: _navBarController,
      curve: Curves.easeInOut,
    ));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadInitialData();
    });
  }

  @override
  void dispose() {
    _navBarController.dispose();
    super.dispose();
  }

  void _loadInitialData() {
    final summary = context.read<SummaryProvider>();
    final meals = context.read<MealsProvider>();
    final water = context.read<WaterProvider>();
    final profile = context.read<ProfileProvider>();

    summary.load();
    meals.loadByDate();
    water.load();
    profile.load();
  }

  bool _onScrollNotification(UserScrollNotification notification) {
    final direction = notification.direction;
    if (direction == _lastDirection) return false;
    _lastDirection = direction;

    if (direction == ScrollDirection.reverse) {
      // Scrolling down — hide nav bar
      _navBarController.forward();
    } else if (direction == ScrollDirection.forward) {
      // Scrolling up — show nav bar
      _navBarController.reverse();
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Breakpoints.isDesktop(context);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      extendBody: true,
      body: NotificationListener<UserScrollNotification>(
        onNotification: isDesktop ? null : _onScrollNotification,
        child: Row(
          children: [
            // Desktop/Tablet: Side Navigation Rail
            if (isDesktop)
              NavigationRail(
                selectedIndex: _selectedIndex,
                onDestinationSelected: (index) {
                  setState(() => _selectedIndex = index);
                },
                extended: Breakpoints.isWide(context),
                backgroundColor: Theme.of(context).colorScheme.surface,
                labelType: Breakpoints.isWide(context)
                    ? NavigationRailLabelType.none
                    : NavigationRailLabelType.all,
                destinations: [
                  NavigationRailDestination(
                    icon: const Icon(Icons.home_outlined),
                    selectedIcon: const Icon(Icons.home),
                    label: Text(l10n.navHome),
                  ),
                  NavigationRailDestination(
                    icon: const Icon(Icons.add_circle_outline),
                    selectedIcon: const Icon(Icons.add_circle),
                    label: Text(l10n.navLog),
                  ),
                  NavigationRailDestination(
                    icon: const Icon(Icons.restaurant_menu_outlined),
                    selectedIcon: const Icon(Icons.restaurant_menu),
                    label: Text(l10n.navDiscover),
                  ),
                  NavigationRailDestination(
                    icon: const Icon(Icons.analytics_outlined),
                    selectedIcon: const Icon(Icons.analytics),
                    label: Text(l10n.navProgress),
                  ),
                  NavigationRailDestination(
                    icon: const Icon(Icons.person_outline),
                    selectedIcon: const Icon(Icons.person),
                    label: Text(l10n.navProfile),
                  ),
                ],
              ),

            // Main Content
            Expanded(
              child: _screens[_selectedIndex],
            ),
          ],
        ),
      ),
      bottomNavigationBar: isDesktop
          ? null
          : SlideTransition(
              position: _navBarOffset,
              child: NavigationBar(
                selectedIndex: _selectedIndex,
                onDestinationSelected: (index) {
                  setState(() => _selectedIndex = index);
                },
                destinations: [
                  NavigationDestination(
                    icon: const Icon(Icons.home_outlined),
                    selectedIcon: const Icon(Icons.home),
                    label: l10n.navHome,
                  ),
                  NavigationDestination(
                    icon: const Icon(Icons.add_circle_outline),
                    selectedIcon: const Icon(Icons.add_circle),
                    label: l10n.navLog,
                  ),
                  NavigationDestination(
                    icon: const Icon(Icons.restaurant_menu_outlined),
                    selectedIcon: const Icon(Icons.restaurant_menu),
                    label: l10n.navDiscover,
                  ),
                  NavigationDestination(
                    icon: const Icon(Icons.analytics_outlined),
                    selectedIcon: const Icon(Icons.analytics),
                    label: l10n.navProgress,
                  ),
                  NavigationDestination(
                    icon: const Icon(Icons.person_outline),
                    selectedIcon: const Icon(Icons.person),
                    label: l10n.navProfile,
                  ),
                ],
              ),
            ),
    );
  }
}
