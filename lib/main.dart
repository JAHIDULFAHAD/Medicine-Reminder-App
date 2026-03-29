import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:medicine_reminder_app/app/medicine_reminder.dart';
import 'package:medicine_reminder_app/core/di/injection_container.dart';
import 'features/medicine/data/models/history_model.dart';
import 'features/medicine/data/models/medicine_model.dart';
import 'features/medicine/domain/entities/medicine_time.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  Hive.registerAdapter(MedicineModelAdapter());
  Hive.registerAdapter(HistoryModelAdapter());
  Hive.registerAdapter(MedicineTimeAdapter());

  // Open Boxes
  await Hive.openBox<MedicineModel>('medicines_box');
  await Hive.openBox<HistoryModel>('history_box');

  // Configure Dependency Injection
  await configureDependencies();

  runApp(const MedicineReminder());
}
