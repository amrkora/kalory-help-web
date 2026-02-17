# Qaleel - Modern Nutrition Tracking App

A beautiful, modern, and fully responsive Flutter app for nutrition tracking and meal planning.

## ✨ Features

- 🎨 **Modern Design** - Contemporary purple/indigo color scheme with gradients
- 📱 **Fully Responsive** - Adaptive layouts for mobile, tablet, and desktop
- 🌓 **Dark Mode** - Complete dark theme support with system preference detection
- 📊 **Calorie Tracking** - Beautiful progress rings and visual analytics
- 🥗 **Macro Tracking** - Protein, carbs, and fat with gradient progress bars
- 💧 **Water Intake** - Track hydration with streak badges
- 🍽️ **Meal Logging** - Recent meals with detailed breakdowns
- 📈 **Progress Analytics** - Weight trends and body measurements
- 🔍 **Food Discovery** - AI-powered meal suggestions
- 👤 **Profile Management** - Goals, settings, and preferences

## 🎨 Design System

### Color Palette

**Primary Colors**
- Primary: Indigo-500 (#6366F1)
- Secondary: Purple-500 (#8B5CF6)
- Accent: Pink-500 (#EC4899)

**Semantic Colors**
- Success: Emerald-500 (#10B981)
- Warning: Amber-500 (#F59E0B)
- Error: Red-500 (#EF4444)

### Responsive Breakpoints

- **Mobile**: < 600px (single column)
- **Tablet**: 600px - 1200px (2 columns, navigation rail)
- **Desktop**: 1200px - 1536px (3 columns, extended rail)
- **Wide**: ≥ 1536px (4 columns, max width 1280px)

### Typography

Uses **Inter** font family from Google Fonts:
- Headings: 600-700 weight
- Body: 400 weight
- Labels: 500 weight

## 📁 Project Structure

```
qalail/
├── lib/
│   ├── main.dart                    # App entry point
│   ├── theme/
│   │   └── app_theme.dart           # Theme configuration
│   ├── utils/
│   │   └── theme_provider.dart      # Theme state management
│   ├── screens/
│   │   ├── home/
│   │   │   └── home_screen.dart     # Responsive home dashboard
│   │   ├── onboarding/              # Onboarding flow
│   │   ├── log/                     # Food logging
│   │   ├── progress/                # Progress tracking
│   │   ├── discover/                # Meal planning
│   │   └── profile/                 # User profile
│   └── widgets/
│       ├── calorie_progress_ring.dart
│       ├── macro_bar.dart
│       ├── water_tracker.dart
│       └── meal_card.dart
├── assets/
│   ├── images/
│   └── fonts/
├── pubspec.yaml
└── README.md
```

## 🚀 Getting Started

### Prerequisites

- Flutter SDK ≥ 3.2.0
- Dart SDK ≥ 3.2.0
- An IDE (VS Code, Android Studio, or IntelliJ)

### Installation

1. **Clone the repository**
   ```bash
   cd /Users/eclipz/playground/git/qalail
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   # For mobile (iOS/Android)
   flutter run

   # For web
   flutter run -d chrome

   # For desktop (macOS)
   flutter run -d macos

   # For desktop (Windows)
   flutter run -d windows

   # For desktop (Linux)
   flutter run -d linux
   ```

### Development

**Enable hot reload**
- Press `r` in terminal for hot reload
- Press `R` for hot restart
- Press `q` to quit

**Run tests**
```bash
flutter test
```

**Analyze code**
```bash
flutter analyze
```

**Format code**
```bash
flutter format lib/
```

## 📦 Dependencies

### Core
- `flutter` - Flutter SDK
- `provider` - State management
- `google_fonts` - Typography (Inter font)

### UI & Visualization
- `fl_chart` - Charts and graphs
- `flutter_svg` - SVG support

### Utilities
- `intl` - Internationalization and formatting
- `shared_preferences` - Local data persistence

## 🎯 Responsive Layouts

### Mobile (< 600px)
- Single column layout
- Bottom navigation bar (5 tabs)
- Stacked content
- FAB for quick actions

### Tablet (600px - 1200px)
- 2-column grid layout
- Navigation rail (left side)
- Side-by-side content
- Larger touch targets

### Desktop (≥ 1200px)
- 3-4 column grid layout
- Extended navigation rail
- Maximum content width: 1280px
- Optimized for mouse/keyboard

## 🌓 Dark Mode

Dark mode is automatically enabled based on system preferences and can be toggled manually:

```dart
// Toggle theme
Provider.of<ThemeProvider>(context, listen: false).toggleTheme();

// Set specific theme
themeProvider.setThemeMode(ThemeMode.dark);  // or ThemeMode.light
```

Theme preference is persisted using `SharedPreferences`.

## 🎨 Custom Widgets

### CalorieProgressRing
Circular progress indicator with gradient stroke showing calorie consumption.

```dart
CalorieProgressRing(
  remaining: 1405,
  goal: 2150,
  consumed: 870,
  burned: 125,
)
```

### MacroBar
Horizontal progress bar with gradient for macronutrient tracking.

```dart
MacroBar(
  label: 'Protein',
  current: 42,
  goal: 161,
  gradient: LinearGradient(colors: [...]),
)
```

### WaterTracker
Water intake tracker with visual glass indicators and streak badge.

```dart
WaterTracker()
```

### MealCard
Display meal information with calorie badge and item list.

```dart
MealCard(
  mealType: 'Breakfast',
  calories: 420,
  items: ['Porridge', 'Banana', 'Honey'],
)
```

## 🔧 Configuration

### Theme Customization

Edit `lib/theme/app_theme.dart` to customize:
- Colors
- Typography
- Component styles
- Spacing
- Border radius

### Adding New Screens

1. Create screen file in appropriate folder
2. Import in `main.dart`
3. Add to navigation
4. Update routes if needed

## 📱 Platform Support

| Platform | Status |
|----------|--------|
| iOS | ✅ Supported |
| Android | ✅ Supported |
| Web | ✅ Supported |
| macOS | ✅ Supported |
| Windows | ✅ Supported |
| Linux | ✅ Supported |

## 🐛 Known Issues

- Font assets need to be added to `assets/fonts/`
- Some screens are placeholders (to be implemented)
- Charts require additional configuration

## 🛠️ Future Enhancements

- [ ] Complete all screen implementations
- [ ] Add animations and transitions
- [ ] Implement data persistence
- [ ] Add backend integration
- [ ] Food database API
- [ ] Barcode scanning
- [ ] Camera integration for food photos
- [ ] Push notifications
- [ ] Social features
- [ ] Export/import data
- [ ] Multi-language support

## 📄 License

This is a demonstration project for UI/UX design purposes.

## 🤝 Contributing

This is a prototype project. For production use:

1. Add comprehensive tests
2. Implement proper state management
3. Add error handling
4. Set up CI/CD
5. Implement analytics
6. Add crash reporting
7. Perform security audit

## 📞 Support

For questions or issues, please open an issue in the repository.

---

**Built with Flutter** 💙

Modern, responsive, and beautiful nutrition tracking.
