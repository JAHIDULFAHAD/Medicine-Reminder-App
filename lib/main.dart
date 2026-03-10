import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:medicine_reminder_app/app/medicine_reminder.dart';
import 'package:medicine_reminder_app/core/di/injection_container.dart';
import 'core/services/notification_service.dart';
import 'features/medicine/data/models/history_model.dart';
import 'features/medicine/data/models/medicine_model.dart';
import 'features/medicine/domain/entities/medicine_time.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize notification service
  await NotificationService().initialize();

  // Initialize Hive
  await Hive.initFlutter();

  // Register Adapters
  Hive.registerAdapter(MedicineModelAdapter());
  Hive.registerAdapter(HistoryModelAdapter());
  Hive.registerAdapter(MedicineTimeAdapter());

  // Open Boxes
  final medicineBox = await Hive.openBox<MedicineModel>('medicines_box');
  final historyBox = await Hive.openBox<HistoryModel>('history_box');

  // Register Hive boxes as singletons in DI container
  getIt.registerSingleton<Box<MedicineModel>>(medicineBox);
  getIt.registerSingleton<Box<HistoryModel>>(historyBox);

  // Configure Dependency Injection
  configureDependencies();

  runApp(const MedicineReminder());
}