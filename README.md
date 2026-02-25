# Kalory Help — Calorie & Nutrition Tracker

A privacy-first nutrition tracking app built with Flutter. All core features work fully offline with no accounts, no analytics, and no data collection.

## Features

- **Calorie & Macro Tracking** — Log meals with calories, protein, carbs, and fat from a built-in food database
- **Custom Foods** — Save your own foods for quick reuse
- **Hydration Tracking** — Track daily water intake with animated wave UI
- **Recipe Discovery** — Browse 30+ curated recipes filtered by meal type and diet
- **Progress & Insights** — Calorie trends, nutrition averages, Kalory Score, and streaks
- **Smart Goals** — Personalized targets using the Mifflin-St Jeor equation
- **Data Export & Deletion** — Export as JSON or delete everything with one tap
- **Bilingual** — Full English and Arabic support with RTL layout
- **Responsive** — Adaptive layouts for mobile, tablet, and desktop
- **Dark Mode** — System-aware with manual toggle
- **Encrypted Profile** — AES-256 encrypted profile data with key stored in iOS Keychain

## Getting Started

### Prerequisites

- Flutter SDK >= 3.2.0
- Xcode (for iOS)

### Run

```bash
flutter pub get
flutter run
```

### Test

```bash
flutter test
```

## Tech Stack

- **State Management:** Provider
- **Local Storage:** Hive (profile box AES-encrypted via flutter_secure_storage)
- **Localization:** Flutter gen-l10n with ARB files
- **UI:** Material 3, Inter font, custom widgets (activity rings, hydration wave, Kalory Score)

## Platforms

| Platform | Status |
|----------|--------|
| iOS      | Supported |
| Android  | Supported |
| Web      | Supported |

## Privacy

All data stays on the user's device. No cloud sync, no accounts, no analytics, no ads. See the [privacy policy](https://kalory.help/privacy.html).

## License

Copyright 2026 Kalory Help. All rights reserved.
