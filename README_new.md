# 💊 Medicine Reminder App

*A cross-platform Flutter application for managing medication schedules with smart notifications*

[![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)](https://opensource.org/licenses/MIT)
[![Platform](https://img.shields.io/badge/platform-Android%20%7C%20iOS%20%7C%20Web%20%7C%20Desktop-green?style=for-the-badge)](#)

*Never miss a dose again!* 🔔

[📱 Download APK](#) • [🐛 Report Bug](https://github.com/your-username/medicine-reminder/issues) • [✨ Request Feature](https://github.com/your-username/medicine-reminder/issues)

---

## ✨ Features

### 🎯 Core Functionality
- **💊 Medicine Management** - Add medicines with custom dosages and schedules
- **⏰ Smart Scheduling** - Set intake times (morning, afternoon, night)
- **📅 Duration Tracking** - Specify treatment courses (7-30 days)
- **🔔 Intelligent Notifications** - Automated daily reminders
- **📊 History Tracking** - Complete record of medication adherence
- **📱 Cross-Platform** - Android, iOS, Web, Windows, macOS, Linux

### 🔧 Technical Features
- **🏗️ Clean Architecture** - Scalable, maintainable codebase
- **💾 Local Storage** - Hive database for offline functionality
- **🔄 BLoC State Management** - Predictable state updates
- **🧩 Dependency Injection** - GetIt + Injectable pattern
- **🔔 Local Notifications** - Timezone-aware scheduling

---

## 🚀 Quick Start

### 📋 Prerequisites
- Flutter SDK (3.8.1+)
- Dart SDK (included with Flutter)
- Android Studio / VS Code with Flutter extensions

### ⚡ Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/your-username/medicine-reminder.git
   cd medicine-reminder
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate code**
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

### 🎯 First Time Setup
The app automatically initializes the database and requests notification permissions on first launch.

---

## 📖 Usage

### 💊 Adding a Medicine
1. Tap the **➕ button** on the home screen
2. Select medicine type from dropdown
3. Choose duration (7, 14, 21, or 30 days)
4. Pick intake times (Morning/Afternoon/Night)
5. **Save** - Notifications scheduled automatically!

### 📊 Viewing Schedule
- **Home Tab** - Today's medicines organized by time
- **History Tab** - Past medication records by date

### 🔔 Notifications
- Automatic daily reminders at scheduled times
- Timezone-aware scheduling
- Test notifications available in debug mode

---

## 🏗️ Architecture

```
lib/
├── 🏠 main.dart              # App entry point
├── 🏗️ core/                  # Core services & DI
├── 🎯 features/medicine/     # Medicine feature module
│   ├── 💾 data/              # Hive models & repositories
│   ├── 🧠 domain/            # Business logic & entities
│   └── 🎨 presentation/      # UI & BLoC state management
└── 🧭 app/                   # App-level configuration
```

**Design Principles:**
- Clean Architecture with feature-driven structure
- Single Responsibility & Dependency Inversion
- BLoC pattern for state management
- Repository pattern for data abstraction

---

## 🛠️ Tech Stack

| Category | Technology |
|----------|------------|
| **Framework** | Flutter, Dart |
| **State Management** | BLoC/Cubit |
| **Database** | Hive + Hive Flutter |
| **DI** | GetIt + Injectable |
| **Navigation** | Go Router |
| **Notifications** | Flutter Local Notifications |
| **Development** | Build Runner, Flutter Lints |

---

## 🔧 Building

### Android
```bash
flutter build apk --release          # APK
flutter build appbundle --release    # App Bundle
```

### iOS
```bash
flutter build ios --release
```

### Web
```bash
flutter build web --release
```

### Desktop
```bash
flutter build windows --release  # Windows
flutter build linux --release    # Linux
flutter build macos --release    # macOS
```

---

## 🧪 Testing

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage

# Run integration tests
flutter test integration_test/
```

---

## 🤝 Contributing

1. **Fork** the repository
2. **Create** a feature branch (`git checkout -b feature/amazing-feature`)
3. **Commit** your changes (`git commit -m 'Add amazing feature'`)
4. **Push** to the branch (`git push origin feature/amazing-feature`)
5. **Open** a Pull Request

### 📋 Guidelines
- Follow Clean Architecture principles
- Write tests for new features
- Use meaningful commit messages
- Ensure cross-platform compatibility

---

## 📄 License

This project is licensed under the **MIT License** - see the [LICENSE](LICENSE) file for details.

```
MIT License

Copyright (c) 2024 Medicine Reminder App

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.
```

---

## 🙏 Acknowledgments

Built with ❤️ using [Flutter](https://flutter.dev)

**Special Thanks:**
- Flutter Team for the amazing framework
- Open source community for incredible packages

---

<div align="center">

**Helping people stay healthy, one reminder at a time** 💊

</div>