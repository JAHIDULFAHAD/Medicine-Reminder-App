import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicine_reminder_app/core/services/notification_service.dart';
import 'package:medicine_reminder_app/features/medicine/presentation/widgets/medicine_card.dart';
import '../../domain/entities/medicine_time.dart';
import '../cubit/medicine_cubit.dart';
import '../cubit/medicine_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final NotificationService notificationService;

  @override
  void initState() {
    super.initState();

    notificationService = NotificationService();
    Future.delayed(const Duration(milliseconds: 200), () {
      if (!mounted) return;

      context.read<MedicineCubit>().loadData();
      context.read<MedicineCubit>().refreshNotifications();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MedicineCubit, MedicineState>(
        buildWhen: (previous, current) {
          return current is MedicineLoading || current is MedicineLoaded;
        },
        builder: (context, state) {
          if (state is MedicineLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is MedicineLoaded) {
            final medicineCubit = context.read<MedicineCubit>();
            final selectedDate = medicineCubit.selectedDate;
            final medicines = medicineCubit.getActiveMedicines(
              selectedDate,
              state.medicines,
            );
            final todayStatus = state.todayStatus;

            if (medicines.isEmpty) {
              return const Center(child: Text('No medicines found.'));
            }

            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              addAutomaticKeepAlives: true,
              padding: const EdgeInsets.all(16),
              itemCount: 5,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return MedicineCard(
                    title: 'Morning',
                    time: MedicineTime.morning,
                    medicines: medicines,
                    todayStatus: todayStatus,
                  );
                }

                if (index == 1) {
                  return MedicineCard(
                    title: 'Noon',
                    time: MedicineTime.noon,
                    medicines: medicines,
                    todayStatus: todayStatus,
                  );
                }

                if (index == 2) {
                  return MedicineCard(
                    title: 'Night',
                    time: MedicineTime.night,
                    medicines: medicines,
                    todayStatus: todayStatus,
                  );
                }

                if (index == 3) {
                  return ElevatedButton(
                    onPressed: () {
                      final newDate = DateTime.now().subtract(
                        const Duration(days: 1),
                      );

                      context.read<MedicineCubit>().changeSelectedDate(newDate);
                    },
                    child: const Text("Go to Test Date"),
                  );
                }

                if (index == 4) {
                  return ElevatedButton(
                    onPressed: () {
                      Future.microtask(scheduleMedicineTask);
                    },
                    child: const Text("Test Schedule"),
                  );
                }

                return const SizedBox();
              },
            );
          }

          return const Center(child: Text("Loading..."));
        },
      ),
    );
  }

  Future<void> scheduleMedicineTask() async {
    await notificationService.scheduleTestNotification();
  }
}
