import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicine_reminder_app/core/services/notification_service.dart';
import 'package:medicine_reminder_app/features/medicine/presentation/widgets/medicine_card.dart';
import 'package:timezone/timezone.dart' as tz;
import '../../domain/entities/medicine_time.dart';
import '../cubit/medicine_cubit.dart';
import '../cubit/medicine_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<MedicineCubit>().loadData();
      context.read<MedicineCubit>().refreshNotifications();
    });
  }

  @override
  Widget build(BuildContext context) {
    final notificationService = NotificationService();
    return Scaffold(
      body: BlocBuilder<MedicineCubit, MedicineState>(
        builder: (context, state) {
          if (state is MedicineLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is MedicineLoaded) {
            final medicineCubit = context.read<MedicineCubit>();
            final selectedDate = medicineCubit.selectedDate;
            final medicines = state.medicines.where((m) {
              return medicineCubit.isMedicineActive(m, selectedDate);
            }).toList();
            final todayStatus = state.todayStatus;

            if (medicines.isEmpty) {
              return const Center(child: Text('No medicines found.'));
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  MedicineCard(
                    title: 'Morning',
                    time: MedicineTime.morning,
                    medicines: medicines,
                    todayStatus: todayStatus,
                  ),
                  MedicineCard(
                    title: 'Noon',
                    time: MedicineTime.noon,
                    medicines: medicines,
                    todayStatus: todayStatus,
                  ),
                  MedicineCard(
                    title: 'Night',
                    time: MedicineTime.night,
                    medicines: medicines,
                    todayStatus: todayStatus,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      final newDate = DateTime(
                        2025,
                        2,
                        27,
                      ).subtract(Duration(days: 1));
                      context.read<MedicineCubit>().changeSelectedDate(newDate);
                    },

                    child: Text("Go to Test Date"),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await notificationService.scheduleTestNotification();
                    },
                    child: const Text("Test Schedule"),
                  ),
                ],
              ),
            );
          }

          return const Center(child: Text("Loading..."));
        },
      ),
    );
  }
}
