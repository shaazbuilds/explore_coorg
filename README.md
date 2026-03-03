# 🌿 Coorg Explorer

> **Discover the Scotland of India** — Your pocket travel guide to Kodagu, Karnataka.

Coorg Explorer is a Flutter travel app that helps you explore the best of Coorg — from misty hill trails and cascading waterfalls to local heritage sites and coffee plantations.

---

## 📱 Screenshots

<!-- Add your screenshots here -->

|             Splash Screen              |              Introduction              |     Home      |
| :------------------------------------: | :------------------------------------: | :-----------: |
| ![Splash](assets/images/splash_bg.png) | ![Intro](assets/images/screen_one.png) | _Coming soon_ |

---

## ✨ Features

- **Onboarding Flow** — Beautiful 4-page introduction walkthrough with smooth page transitions and animated indicators
- **Smart Navigation** — Remembers if the user has completed onboarding; skips intro on repeat visits
- **Splash Screen** — Animated fade-in splash with background scenery
- **Skip & Resume** — Users can skip or complete the intro at any time
- **Offline Ready** — Core content available without an internet connection _(coming soon)_
- **Explore Coorg** — Discover landmarks, trails, waterfalls, and local culture _(coming soon)_

---

## 🚀 Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) `>=3.0.0`
- Dart `>=3.0.0`
- Android Studio / VS Code with Flutter extension

### Installation

1. **Clone the repository**

   ```bash
   git clone https://github.com/your-username/explore_coorg.git
   cd explore_coorg
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

---

## 🗂️ Project Structure

```
lib/
├── main.dart
├── home_page.dart
├── screens/
│   ├── splash_screen.dart
│   └── intro/
│       ├── intro_page_controller.dart   # PageView + nav controls
│       ├── intro_screen_one.dart
│       ├── intro_screen_two.dart
│       ├── intro_page_three.dart
│       └── intro_page_four.dart
├── widgets/
│   └── intro_page_template.dart         # Reusable intro page widget
├── services/
│   └── preferences_service.dart         # SharedPreferences helper
└── theme/
    └── app_colors.dart                  # App color palette
```

---

## 📦 Dependencies

| Package                                                                   | Purpose                                  |
| ------------------------------------------------------------------------- | ---------------------------------------- |
| [`shared_preferences`](https://pub.dev/packages/shared_preferences)       | Persist intro seen state across sessions |
| [`smooth_page_indicator`](https://pub.dev/packages/smooth_page_indicator) | Animated page indicator dots             |

---

## 🎨 Theme

The app uses a nature-inspired color palette drawn from Coorg's landscapes:

| Token                       | Usage                           |
| --------------------------- | ------------------------------- |
| `AppColors.backgroundDark`  | Primary text, buttons           |
| `AppColors.backgroundLight` | Light backgrounds, overlay text |
| `AppColors.pureWhite`       | Scaffold backgrounds            |
| `AppColors.accent`          | Highlights, loader, accent line |

---

## 🔄 App Flow

```
Launch
  └── SplashScreen (3s)
        ├── hasSeenIntro = true  →  HomePage
        └── hasSeenIntro = false →  IntroPageController
                                        ├── IntroScreenOne
                                        ├── IntroScreenTwo
                                        ├── IntroPageThree
                                        └── IntroPageFour
                                              └── "Get Started" → HomePage
```

---

## 🛠️ Development Notes

- The intro seen state is stored via `SharedPreferences` using the key `intro_seen`
- Call `PreferencesService.markIntroAsSeen()` only on intro completion or skip — not on open — so users aren't stuck mid-flow
- All intro pages use the shared `IntroPageTemplate` widget for consistent styling
- The `IntroPageController` handles skip visibility, dot indicators, and the Next → Get Started button morph animation

---

## 🤝 Contributing

Contributions are welcome! Please open an issue first to discuss what you'd like to change.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/your-feature`)
3. Commit your changes (`git commit -m 'Add your feature'`)
4. Push to the branch (`git push origin feature/your-feature`)
5. Open a Pull Request

---

## 📄 License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

<p align="center">Made with ❤️ for Coorg</p>
