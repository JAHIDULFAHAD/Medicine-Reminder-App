import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicine_reminder_app/app/router/app_router.dart';
import 'package:medicine_reminder_app/features/medicine/domain/repositories/medicine_repository.dart';
import 'package:medicine_reminder_app/features/medicine/domain/usecases/add_medicine.dart';
import 'package:medicine_reminder_app/features/medicine/domain/usecases/get_history.dart';
import 'package:medicine_reminder_app/features/medicine/domain/usecases/get_medicines.dart';
import 'package:medicine_reminder_app/features/medicine/domain/usecases/get_today_medicine_status.dart';
import 'package:medicine_reminder_app/features/medicine/domain/usecases/save_history.dart';
import 'package:medicine_reminder_app/features/medicine/presentation/cubit/medicine_cubit.dart';

import '../core/services/notification_service.dart';

class MedicineReminder extends StatelessWidget {
  const MedicineReminder({super.key, required this.repository});

  final MedicineRepository repository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MedicineCubit(
        addMedicineUseCase: AddMedicine(repository),
        saveHistoryUseCase: SaveHistory(repository),
        getTodayStatusUseCase: GetTodayMedicineStatus(repository),
        getMedicinesUseCase: GetMedicines(repository),
        getHistoryUseCase: GetHistory(repository),
        notificationService: NotificationService(),
      ),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter,
      ),
    );
  }
}
