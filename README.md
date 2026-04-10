<div align="center">

# 💊 Medicine Reminder App

*A cross-platform Flutter application for managing medication schedules with smart notifications*

[![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)](https://opensource.org/licenses/MIT)
[![Platform](https://img.shields.io/badge/platform-Android%20%7C%20iOS%20%7C%20Web%20%7C%20Desktop-green?style=for-the-badge)](#)

*Never miss a dose again! 🔔*

[📱 Download APK](#) • [🌐 Live Demo](#) • [📖 Documentation](#) • [🐛 Report Bug](https://github.com/your-username/medicine-reminder/issues) • [✨ Request Feature](https://github.com/your-username/medicine-reminder/issues)

---

## 📋 Table of Contents

- [✨ Features](#-features)
- [🏗️ Architecture](#️-architecture)
- [🛠️ Tech Stack](#️-tech-stack)
- [🚀 Quick Start](#-quick-start)
- [📱 Screenshots](#-screenshots)
- [🔧 Installation](#-installation)
- [📖 Usage](#-usage)
- [🧪 Testing](#-testing)
- [🏗️ Project Structure](#-project-structure)
- [🤝 Contributing](#-contributing)
- [📄 License](#-license)
- [🙏 Acknowledgments](#-acknowledgments)

---

## ✨ Features

### 🎯 Core Functionality
- **💊 Medicine Management** - Add, edit, and organize medications
- **⏰ Smart Scheduling** - Set custom intake times (morning, afternoon, night)
- **📅 Duration Tracking** - Specify medicine courses with start/end dates
- **🔔 Intelligent Notifications** - Automated reminders with customizable timing
- **📊 History Tracking** - Complete record of taken/missed medications
- **📱 Cross-Platform** - Works on Android, iOS, Web, Windows, macOS, Linux

### 🎨 User Experience
- **🌙 Clean UI** - Modern, intuitive interface
- **📊 Visual Analytics** - Charts and statistics for medication adherence
- **🔄 Offline First** - Works without internet connection
- **⚡ Fast & Responsive** - Optimized performance across all platforms
- **🎯 Accessibility** - Screen reader support and high contrast modes

### 🔧 Technical Features
- **🏗️ Clean Architecture** - Scalable, maintainable codebase
- **💾 Local Storage** - Hive database for reliable data persistence
- **🔄 State Management** - BLoC pattern for predictable state updates
- **🧩 Dependency Injection** - GetIt + Injectable for clean dependency management
- **🔔 Push Notifications** - Local notifications with timezone support

---

## 🏗️ Architecture

This project follows **Clean Architecture** principles with a **feature-driven** approach:

```
lib/
├── 📁 core/                    # Core services & utilities
│   ├── 🏗️ di/                 # Dependency injection setup
│   └── 🔧 services/           # Notification, storage services
├── 🧭 app/                     # Application layer
│   ├── 🏠 medicine_reminder.dart
│   └── 🧭 router/             # Navigation configuration
└── 🎯 features/               # Feature modules
    └── 💊 medicine/           # Medicine management feature
        ├── 💾 data/           # Data layer (Hive, repositories)
        ├── 🧠 domain/         # Business logic (entities, usecases)
        └── 🎨 presentation/   # UI layer (pages, widgets, BLoC)
```

### 🏛️ Design Principles

- **🎯 Single Responsibility** - Each class has one reason to change
- **🔄 Dependency Inversion** - High-level modules don't depend on low-level modules
- **🧩 Interface Segregation** - Clients depend only on methods they use
- **📦 Open/Closed** - Open for extension, closed for modification

---

## 🛠️ Tech Stack

### 🎨 Frontend
- **Flutter** - Cross-platform UI framework
- **Dart** - Programming language
- **Material Design** - UI component library

### 🔧 State Management & Architecture
- **BLoC/Cubit** - State management pattern
- **GetIt + Injectable** - Dependency injection
- **Clean Architecture** - Software architecture pattern

### 💾 Data & Storage
- **Hive** - Lightweight NoSQL database
- **Path Provider** - File system access

### 🔔 Notifications & Scheduling
- **Flutter Local Notifications** - Local push notifications
- **Timezone** - Timezone-aware scheduling

### 🧭 Navigation & Routing
- **Go Router** - Declarative routing

### 🧪 Development & Testing
- **Flutter Test** - Unit and widget testing
- **Build Runner** - Code generation
- **Flutter Lints** - Code quality

---

## 🚀 Quick Start

> Get up and running in under 5 minutes! ⚡

### 📋 Prerequisites

- **Flutter SDK** (3.8.1+)
- **Dart SDK** (included with Flutter)
- **Android Studio** / **VS Code** with Flutter extensions
- **Git** for version control

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

3. **Generate code** (for dependency injection & Hive adapters)
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. **Run the app**
   ```bash
   # Android
   flutter run

   # iOS (requires macOS + Xcode)
   flutter run --device-id=$(flutter devices | grep iphone | awk '{print $1}')

   # Web
   flutter run -d chrome

   # Desktop
   flutter run -d windows  # or linux/macos
   ```

### 🎯 First Time Setup

The app will automatically:
- ✅ Initialize local database
- ✅ Request notification permissions
- ✅ Set up timezone configuration
- ✅ Create default storage boxes

---

## 📱 Screenshots

<div align="center">

### 📱 Mobile Interface
| Home Screen | Add Medicine | History View |
|-------------|--------------|--------------|
| ![Home](https://via.placeholder.com/200x350/02569B/FFFFFF?text=Home+Screen) | ![Add](https://via.placeholder.com/200x350/02569B/FFFFFF?text=Add+Medicine) | ![History](https://via.placeholder.com/200x350/02569B/FFFFFF?text=History) |

### 🖥️ Desktop Interface
| Dashboard | Settings | Analytics |
|-----------|----------|-----------|
| ![Dashboard](https://via.placeholder.com/300x200/02569B/FFFFFF?text=Dashboard) | ![Settings](https://via.placeholder.com/300x200/02569B/FFFFFF?text=Settings) | ![Analytics](https://via.placeholder.com/300x200/02569B/FFFFFF?text=Analytics) |

</div>

---

## 🔧 Installation

### 📱 Platform-Specific Setup

#### Android
```bash
# Build APK
flutter build apk --release

# Build App Bundle
flutter build appbundle --release
```

#### iOS
```bash
# Requires macOS + Xcode
flutter build ios --release

# Open in Xcode for deployment
open ios/Runner.xcworkspace
```

#### Web
```bash
# Build for web
flutter build web --release

# Serve locally
flutter run -d chrome
```

#### Desktop
```bash
# Windows
flutter build windows --release

# Linux
flutter build linux --release

# macOS
flutter build macos --release
```

### 🔐 Permissions

The app requires the following permissions:

- **Notifications** - For medicine reminders
- **Storage** - For local data persistence
- **Exact Alarms** (Android 12+) - For precise timing

---

## 📖 Usage

### 💊 Adding a Medicine

1. **Tap the ➕ button** on the home screen
2. **Select medicine type** from dropdown (Paracetamol, Vitamin C, etc.)
3. **Choose duration** (7, 14, 21, or 30 days)
4. **Pick intake times** (Morning, Afternoon, Night)
5. **Save** - Notifications will be scheduled automatically!

### 📊 Viewing Your Schedule

- **Home Tab** - Today's active medicines by time
- **History Tab** - Past medication records
- **Mark as taken** - Tap medicine cards to log intake

### 🔔 Managing Notifications

- **Automatic scheduling** when medicines are added
- **Daily reminders** at specified times
- **Timezone aware** - adjusts automatically
- **Test notifications** available in debug mode

---

## 🧪 Testing

### 🏃‍♂️ Run Tests

```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Run integration tests
flutter test integration_test/
```

### 🐛 Debug Features

- **Test notifications** - Available in debug builds
- **Database inspection** - View stored data
- **State logging** - BLoC state changes in console

---

## 🏗️ Project Structure

```
medicine_reminder_app/
├── 📱 android/              # Android platform code
├── 🍎 ios/                  # iOS platform code
├── 🖥️ windows/              # Windows platform code
├── 🐧 linux/                # Linux platform code
├── 🍎 macos/                # macOS platform code
├── 🌐 web/                  # Web platform code
├── 📚 lib/                  # Main Flutter code
│   ├── 🏠 main.dart         # App entry point
│   ├── 🏗️ core/             # Core functionality
│   ├── 🎯 features/         # Feature modules
│   └── 🧭 app/              # App-level code
├── 🧪 test/                 # Unit tests
├── 📋 pubspec.yaml          # Dependencies
├── 🔧 analysis_options.yaml # Code analysis
└── 📖 README.md             # This file
```

### 📂 Key Directories

- **`core/`** - Shared services, utilities, and configurations
- **`features/`** - Feature-specific code (medicine management)
- **`app/`** - App-wide components (router, themes)
- **`data/`** - Data layer (repositories, models, datasources)
- **`domain/`** - Business logic (entities, usecases)
- **`presentation/`** - UI layer (pages, widgets, state management)

---

## 🤝 Contributing

We love your input! We want to make contributing to this project as easy and transparent as possible.

### 📝 How to Contribute

1. **Fork** the repo
2. **Create** a feature branch (`git checkout -b feature/amazing-feature`)
3. **Commit** your changes (`git commit -m 'Add amazing feature'`)
4. **Push** to the branch (`git push origin feature/amazing-feature`)
5. **Open** a Pull Request

### 🐛 Bug Reports & Feature Requests

- **🐛 Bug Report**: [Create an issue](https://github.com/your-username/medicine-reminder/issues/new?template=bug_report.md)
- **✨ Feature Request**: [Create an issue](https://github.com/your-username/medicine-reminder/issues/new?template=feature_request.md)

### 📋 Development Guidelines

- Follow **Clean Architecture** principles
- Write **tests** for new features
- Use **meaningful commit messages**
- Update **documentation** as needed
- Ensure **cross-platform compatibility**

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

### 🎯 Special Thanks

- **Flutter Team** - For the amazing cross-platform framework
- **Open Source Community** - For the incredible packages and tools
- **Contributors** - For helping improve this project

### 📚 Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [Dart Language Tour](https://dart.dev/guides/language/language-tour)
- [Clean Architecture Guide](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [BLoC Pattern](https://bloclibrary.dev/)

### 🏆 Badges

<div align="center">

[![Made with Flutter](https://img.shields.io/badge/Made%20with-Flutter-02569B.svg?style=for-the-badge&logo=flutter)](https://flutter.dev)
[![Made with Dart](https://img.shields.io/badge/Made%20with-Dart-0175C2.svg?style=for-the-badge&logo=dart)](https://dart.dev)
[![Open Source Love](https://img.shields.io/badge/Open%20Source-%E2%9D%A4-red.svg?style=for-the-badge)](https://github.com/your-username/medicine-reminder)

</div>

---

<div align="center">

**Built with ❤️ using Flutter**

*Helping people stay healthy, one reminder at a time* 💊

[⬆️ Back to Top](#-medicine-reminder-app)
