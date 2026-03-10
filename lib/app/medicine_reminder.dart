import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicine_reminder_app/app/router/app_router.dart';
import 'package:medicine_reminder_app/core/di/injection_container.dart';
import 'package:medicine_reminder_app/features/medicine/domain/usecases/add_medicine.dart';
import 'package:medicine_reminder_app/features/medicine/domain/usecases/get_history.dart';
import 'package:medicine_reminder_app/features/medicine/domain/usecases/get_medicines.dart';
import 'package:medicine_reminder_app/features/medicine/domain/usecases/get_today_medicine_status.dart';
import 'package:medicine_reminder_app/features/medicine/domain/usecases/save_history.dart';
import 'package:medicine_reminder_app/features/medicine/presentation/cubit/medicine_cubit.dart';

class MedicineReminder extends StatelessWidget {
  const MedicineReminder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MedicineCubit(
        addMedicineUseCase: getIt<AddMedicine>(),
        saveHistoryUseCase: getIt<SaveHistory>(),
        getTodayStatusUseCase: getIt<GetTodayMedicineStatus>(),
        getMedicinesUseCase: getIt<GetMedicines>(),
        getHistoryUseCase: getIt<GetHistory>(),
      ),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter,
      ),
    );
  }
}
