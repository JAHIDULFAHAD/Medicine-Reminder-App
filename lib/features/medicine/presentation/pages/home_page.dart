import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicine_reminder_app/features/medicine/presentation/widgets/medicine_card.dart';
import '../../domain/entities/medicine_time.dart';
import '../cubit/medicine_cubit.dart';
import '../cubit/medicine_state.dart';
import '../../domain/entities/history.dart';
import '../../domain/entities/medicine.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MedicineCubit, MedicineState>(
      builder: (context, state) {
        if (state is MedicineLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is MedicineLoaded) {
          final medicines = state.medicines;
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
                )
              ],
            ),
          );
        }

        return const Center(child: Text("Loading..."));
      },
    );
  }
}
