import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:medicine_reminder_app/features/medicine/presentation/pages/home_page.dart';

import 'features/medicine/data/datasources/hive_datasource.dart';
import 'features/medicine/data/models/history_model.dart';
import 'features/medicine/data/models/medicine_model.dart';
import 'features/medicine/data/repositories/medicine_repository_impl.dart';
import 'features/medicine/domain/entities/medicine_time.dart';
import 'features/medicine/domain/repositories/medicine_repository.dart';
import 'features/medicine/domain/usecases/add_medicine.dart';
import 'features/medicine/domain/usecases/get_history.dart';
import 'features/medicine/domain/usecases/get_medicines.dart';
import 'features/medicine/domain/usecases/get_medicines_by_time.dart';
import 'features/medicine/domain/usecases/get_today_medicine_status.dart';
import 'features/medicine/domain/usecases/save_history.dart';
import 'features/medicine/presentation/cubit/medicine_cubit.dart';
import 'features/medicine/presentation/pages/tab_bar _screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

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

  runApp(MyApp(repository: repository));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.repository});

  final MedicineRepository repository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MedicineCubit(
        addMedicineUseCase: AddMedicine(repository),
        saveHistoryUseCase: SaveHistory(repository),
        getTodayStatusUseCase: GetTodayMedicineStatus(repository),
        getMedicinesUseCase: GetMedicines(repository),
        getMedicinesByTime: GetMedicinesByTime(GetMedicines(repository)),
        getHistoryUseCase: GetHistory(repository),
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: TabBarScreen(),
      ),
    );
  }
}
