# 🚀 Getting Started with Qaleel Flutter App

Your modern, responsive nutrition tracking app is ready!

## ✅ What's Installed

- ✅ Flutter 3.41.0 (latest stable)
- ✅ Dart SDK
- ✅ Chrome (web development)
- ✅ All dependencies installed
- ✅ App running at `http://localhost:8080`

## 🎨 Modern Design Features

### Colors (No NHS Branding!)
- **Primary**: Indigo #6366F1 💜
- **Secondary**: Purple #8B5CF6 🟣
- **Accent**: Pink #EC4899 💗
- **Beautiful gradients** throughout

### Responsive Breakpoints
- **Mobile** (<600px): Single column, bottom nav
- **Tablet** (600-1200px): 2 columns, navigation rail
- **Desktop** (1200-1536px): 3 columns, extended rail
- **Wide** (≥1536px): 4 columns, max 1280px content

## 🏃 Running the App

### Currently Running
The app is already running in Chrome at:
```
http://localhost:8080
```

### Start Fresh
```bash
cd /Users/eclipz/playground/git/qalail
flutter run -d chrome
```

### Hot Reload (While Running)
Press in terminal:
- `r` - Hot reload (instant changes)
- `R` - Hot restart (full reload)
- `q` - Quit app

## 📱 Run on Different Platforms

### Web (Chrome)
```bash
flutter run -d chrome
```

### macOS Desktop
```bash
flutter run -d macos
```

### Windows Desktop (if on Windows)
```bash
flutter run -d windows
```

### Linux Desktop (if on Linux)
```bash
flutter run -d linux
```

### iOS (requires Xcode)
```bash
# First install Xcode from App Store
flutter run -d ios
```

### Android (requires Android Studio)
```bash
# First install Android Studio
flutter run -d android
```

## 🛠️ Making Changes

### 1. Edit Code
Open any file in `lib/` folder:
```bash
# Example: Change colors
code lib/theme/app_theme.dart

# Example: Edit home screen
code lib/screens/home/home_screen.dart
```

### 2. Save & Hot Reload
- Save the file
- Press `r` in terminal
- See changes instantly!

### 3. Add New Widgets
```dart
// In lib/widgets/my_widget.dart
import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Hello'),
    );
  }
}
```

## 🎨 Customizing Colors

Edit `lib/theme/app_theme.dart`:

```dart
// Change primary color
static const Color primary = Color(0xFF6366F1); // Indigo

// Change to blue:
static const Color primary = Color(0xFF3B82F6); // Blue

// Change to green:
static const Color primary = Color(0xFF10B981); // Emerald

// Change to orange:
static const Color primary = Color(0xFFF97316); // Orange
```

## 📐 Testing Responsive Layouts

### In Chrome DevTools
1. Press `F12` to open DevTools
2. Click device toolbar icon (top-left)
3. Select different devices:
   - iPhone SE (375px) → Mobile view
   - iPad (768px) → Tablet view
   - Desktop (1920px) → Desktop view

### Watch It Adapt
- **< 600px**: Bottom navigation, single column
- **600-1200px**: Navigation rail appears, 2 columns
- **≥ 1200px**: Extended rail, 3-4 columns

## 🌓 Dark Mode

Toggle dark mode:
1. Click sun/moon icon (top-right)
2. Or automatically follows system preference

Change default theme in `main.dart`:
```dart
themeMode: ThemeMode.dark,  // Always dark
themeMode: ThemeMode.light, // Always light
themeMode: ThemeMode.system, // Follow system (default)
```

## 🏗️ Build for Production

### Web
```bash
flutter build web
# Output: build/web/
# Deploy to any web host
```

### macOS App
```bash
flutter build macos --release
# Output: build/macos/Build/Products/Release/
```

### Windows App
```bash
flutter build windows --release
# Output: build/windows/runner/Release/
```

## 📦 Add New Dependencies

### Example: Add animations
```bash
# Add to pubspec.yaml
flutter pub add animations

# Then use in code:
import 'package:animations/animations.dart';
```

### Example: Add icons
```bash
flutter pub add font_awesome_flutter

# Use in code:
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
```

## 🐛 Troubleshooting

### App won't start
```bash
# Clean build
flutter clean
flutter pub get
flutter run -d chrome
```

### Port already in use
```bash
# Use different port
flutter run -d chrome --web-port=8081
```

### Dependencies issue
```bash
# Reset dependencies
rm pubspec.lock
flutter pub get
```

## 📚 Learn More

### Flutter Docs
- Official docs: https://docs.flutter.dev
- Widget catalog: https://docs.flutter.dev/ui/widgets
- Cookbook: https://docs.flutter.dev/cookbook

### Video Tutorials
- Flutter YouTube: https://www.youtube.com/c/flutterdev
- The Net Ninja: https://www.youtube.com/playlist?list=PL4cUxeGkcC9jLYyp2Aoh6hcWuxFDX6PBJ

### Community
- Flutter Discord: https://discord.gg/flutter
- Stack Overflow: https://stackoverflow.com/questions/tagged/flutter
- Reddit: https://reddit.com/r/flutterdev

## 🎯 Next Steps

1. ✅ **App is running** - Check it out in Chrome
2. 📝 **Customize colors** - Edit `app_theme.dart`
3. 🎨 **Add features** - Implement remaining screens
4. 📱 **Test responsive** - Resize browser window
5. 🌓 **Try dark mode** - Toggle theme button
6. 🚀 **Build for production** - `flutter build web`

## 📂 Project Structure

```
qalail/
├── lib/
│   ├── main.dart                    # Entry point & navigation
│   ├── theme/
│   │   └── app_theme.dart           # Colors & theme
│   ├── utils/
│   │   └── theme_provider.dart      # Dark mode state
│   ├── screens/
│   │   └── home/
│   │       └── home_screen.dart     # Home dashboard
│   └── widgets/
│       ├── calorie_progress_ring.dart
│       ├── macro_bar.dart
│       ├── water_tracker.dart
│       └── meal_card.dart
├── web/                             # Web platform files
├── macos/                           # macOS platform files
├── windows/                         # Windows platform files
├── linux/                           # Linux platform files
├── pubspec.yaml                     # Dependencies
└── README.md                        # Documentation
```

## 🎨 Key Files to Edit

| File | What to Change |
|------|----------------|
| `lib/theme/app_theme.dart` | Colors, fonts, theme |
| `lib/screens/home/home_screen.dart` | Home screen layout |
| `lib/widgets/*.dart` | Reusable components |
| `lib/main.dart` | Navigation, routing |
| `pubspec.yaml` | Dependencies, assets |

---

## 🚀 You're All Set!

Your Flutter app is running at: **http://localhost:8080**

Press `r` for hot reload, `q` to quit.

Happy coding! 💜
