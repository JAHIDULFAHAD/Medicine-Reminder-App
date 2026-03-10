# DI Quick Reference Guide
## Medicine Reminder App - Dependency Injection

### 📦 Dependencies Added
```yaml
get_it: ^7.6.4
injectable: ^2.3.2
injectable_generator: ^2.4.1 (dev)
build_runner: ^2.4.6 (dev)
```

### 🔧 Common Commands

```bash
# Install dependencies
flutter pub get

# Generate DI code (one-time setup)
dart run build_runner build --delete-conflicting-outputs

# Watch for changes during development
dart run build_runner watch --delete-conflicting-outputs

# Clean build cache if issues occur
rm -rf .dart_tool/build
dart run build_runner build --delete-conflicting-outputs
```

### 📁 File Structure

```
lib/
├── core/
│   └── di/
│       ├── injection_container.dart          # Manual DI configuration
│       └── injection_container.config.dart   # Auto-generated (DO NOT EDIT)
├── features/
│   └── medicine/
│       ├── domain/
│       │   └── usecases/
│       │       ├── add_medicine.dart          # @injectable
│       │       ├── get_history.dart           # @injectable
│       │       ├── get_medicines.dart         # @injectable
│       │       ├── get_today_medicine_status.dart  # @injectable
│       │       └── save_history.dart         # @injectable
│       └── data/
│           ├── repositories/
│           │   └── medicine_repository_impl.dart   # @Injectable(as: MedicineRepository)
│           └── datasources/
│               └── hive_datasource.dart      # @injectable
└── app/
    └── medicine_reminder.dart               # Uses getIt<T>()
```

### 🎯 Usage Examples

#### 1. Adding Injectable to a Class

```dart
import 'package:injectable/injectable.dart';

@injectable
class MyService {
  // Constructor injection - dependencies resolved automatically
  MyService(this.dependency);
}
```

#### 2. Binding Implementation to Interface

```dart
@Injectable(as: MyRepository)
class MyRepositoryImpl implements MyRepository {
  MyRepositoryImpl(this.dataSource);
}
```

#### 3. Resolving Dependencies

```dart
import 'package:medicine_reminder_app/core/di/injection_container.dart';

// Get instance from container
final service = getIt<MyService>();

// Use in BlocProvider
BlocProvider(
  create: (_) => MyBloc(
    useCase: getIt<MyUseCase>(),
  ),
)
```

#### 4. Manual Registration (for third-party deps)

```dart
// In main.dart or configureDependencies()
getIt.registerSingleton<HiveBox>(myBox);
getIt.registerLazySingleton<ThirdPartyService>(() => ThirdPartyService());
```

### 🔍 Key Annotations

| Annotation | Purpose |
|------------|---------|
| `@injectable` | Register class for auto-injection |
| `@Injectable(as: T)` | Bind implementation to interface |
| `@factoryMethod` | Register factory method |
| `@singleton` | Register as singleton (one instance) |
| `@LazySingleton` | Register as lazy singleton |
| `@injectableInit` | Mark configureDependencies function |

### ⚙️ Configuration

**Injection Container** (`lib/core/di/injection_container.dart`):
```dart
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'injection_container.config.dart';

final getIt = GetIt.instance;

@injectableInit
void configureDependencies({String environment = 'prod'}) {
  getIt.init(environment: environment);
}
```

**Main App Initialization** (`lib/main.dart`):
```dart
void main() async {
  // ... other initialization ...
  
  // Register Hive boxes manually
  getIt.registerSingleton<Box<MedicineModel>>(medicineBox);
  getIt.registerSingleton<Box<HistoryModel>>(historyBox);
  
  // Configure DI
  configureDependencies();
  
  runApp(const MedicineReminder());
}
```

### 🐛 Troubleshooting

**Error: "The function '$initGetIt' isn't defined"**
```bash
# Solution: Run build_runner
dart run build_runner build --delete-conflicting-outputs
```

**Error: "depends on unregistered type"**
```dart
// Solution 1: Add @injectable to the class
@injectable
class MyClass { }

// Solution 2: Register manually
getIt.registerSingleton<MyClass>(MyClass());
```

**Warning: "Missing dependencies"**
```dart
// This is OK for manually registered deps (like Hive boxes)
// Just ensure they're registered before configureDependencies()
```

### ✅ Testing DI

```dart
test('should resolve dependencies correctly', () {
  // Get instance
  final useCase = getIt<AddMedicine>();
  
  // Verify it's not null
  expect(useCase, isNotNull);
  
  // Verify dependencies are injected
  expect(useCase.repository, isNotNull);
});
```

### 📊 Dependency Graph

```
MedicineCubit
├── AddMedicine
│   └── MedicineRepository (MedicineRepositoryImpl)
│       └── HiveDataSource
│           ├── Box<MedicineModel> (manual singleton)
│           └── Box<HistoryModel> (manual singleton)
├── SaveHistory
│   └── MedicineRepository (shared)
├── GetTodayMedicineStatus
│   └── MedicineRepository (shared)
├── GetMedicines
│   └── MedicineRepository (shared)
└── GetHistory
    └── MedicineRepository (shared)
```

---

**Need more details?** See `DI_IMPLEMENTATION_TASK.md` for the complete learning guide.