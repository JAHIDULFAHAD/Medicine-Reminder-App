import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicine_reminder_app/core/services/notification_service.dart';

import '../../domain/entities/history.dart';
import '../../domain/entities/medicine.dart';
import '../../domain/entities/medicine_time.dart';
import '../cubit/medicine_cubit.dart';

class MedicineCard extends StatelessWidget {
  final String title;
  final MedicineTime time;
  final List<Medicine> medicines;
  final Map<String, Map<MedicineTime, bool>> todayStatus;

  const MedicineCard({
    super.key,
    required this.title,
    required this.time,
    required this.medicines,
    required this.todayStatus,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MedicineCubit>();
    final filteredMeds = medicines
        .where((m) => m.times.contains(time))
        .toList();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            if (filteredMeds.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    "No medicine",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                itemCount: filteredMeds.length,
                itemBuilder: (context, index) {
                  final medicine = filteredMeds[index];

                  final bool? taken = todayStatus[medicine.id]?[time];
                  final bool isLocked = taken != null;

                  final String dropdownValue = taken == true
                      ? "Taken"
                      : "Missed";

                  return ListTile(
                    leading: Icon(isLocked ? Icons.lock : Icons.medication),
                    title: Text(medicine.name),
                    trailing: DropdownButton<String>(
                      value: dropdownValue,
                      items: const [
                        DropdownMenuItem(value: "Taken", child: Text("Taken")),
                        DropdownMenuItem(
                          value: "Missed",
                          child: Text("Missed"),
                        ),
                      ],
                      onChanged: isLocked
                          ? null
                          : (value) {
                              if (value == null) return;
                              NotificationService().showNotification(
                                title: medicine.name,
                                body: value,
                              );
                              cubit.saveHistory(
                                History(
                                  medicineId: medicine.id,
                                  date: DateTime(
                                    context
                                        .read<MedicineCubit>()
                                        .selectedDate
                                        .year,
                                    context
                                        .read<MedicineCubit>()
                                        .selectedDate
                                        .month,
                                    context
                                        .read<MedicineCubit>()
                                        .selectedDate
                                        .day,
                                  ),
                                  time: time,
                                  taken: value == "Taken" ? true : false,
                                ),
                              );
                            },
                      disabledHint: Text(
                        dropdownValue,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
