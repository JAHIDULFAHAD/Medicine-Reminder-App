import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:medicine_reminder_app/app/medicine_reminder.dart';
import 'core/services/notification_service.dart';
import 'features/medicine/data/datasources/hive_datasource.dart';
import 'features/medicine/data/models/history_model.dart';
import 'features/medicine/data/models/medicine_model.dart';
import 'features/medicine/data/repositories/medicine_repository_impl.dart';
import 'features/medicine/domain/entities/medicine_time.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize notification service
  await NotificationService().initialize();

  //Initialize Hive
  await Hive.initFlutter();

  // Register Adapters
  Hive.registerAdapter(MedicineModelAdapter());
  Hive.registerAdapter(HistoryModelAdapter());
  Hive.registerAdapter(MedicineTimeAdapter());

  // Open Boxes
  final medicineBox = await Hive.openBox<MedicineModel>('medicines_box');
  final historyBox = await Hive.openBox<HistoryModel>('history_box');

  // Create HiveDataSource
  final hiveDataSource = HiveDataSource(
    medicineBox: medicineBox,
    historyBox: historyBox,
  );

  // Repository implementation
  final repository = MedicineRepositoryImpl(hiveDataSource);

  runApp(MedicineReminder(repository: repository));
}
