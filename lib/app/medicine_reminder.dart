import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicine_reminder_app/app/router/app_router.dart';
import 'package:medicine_reminder_app/core/di/injection_container.dart';
import '../features/medicine/presentation/cubit/medicine_cubit.dart';

class MedicineReminder extends StatelessWidget {
  const MedicineReminder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<MedicineCubit>()..loadData(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter,
      ),
    );
  }
}
