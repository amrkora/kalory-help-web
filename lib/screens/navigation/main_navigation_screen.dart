import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import '../../theme/app_theme.dart';
import '../home/home_screen.dart';
import '../log/log_screen.dart';
import '../discover/discover_screen.dart';
import '../progress/progress_screen.dart';
import '../profile/profile_screen.dart';
import '../../providers/summary_provider.dart';
import '../../providers/meals_provider.dart';
import '../../providers/profile_provider.dart';
import '../../providers/water_provider.dart';
import '../../l10n/app_localizations.dart';

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
