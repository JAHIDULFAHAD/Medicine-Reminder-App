import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    final selectedDate = cubit.selectedDate;
    final notificationService = cubit.notificationService;

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
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Center(
                  child: Text(
                    "No medicine",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: filteredMeds.length,
                itemBuilder: (context, index) {
                  final medicine = filteredMeds[index];

                  final taken = todayStatus[medicine.id]?[time];

                  final isLocked = taken != null;

                  final dropdownValue = taken == true ? "Taken" : "Missed";

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

                              Future.microtask(() {
                                notificationService.showNotification(
                                  title: medicine.name,
                                  body: value,
                                );

                                cubit.saveHistory(
                                  History(
                                    medicineId: medicine.id,
                                    date: DateTime(
                                      selectedDate.year,
                                      selectedDate.month,
                                      selectedDate.day,
                                    ),
                                    time: time,
                                    taken: value == "Taken",
                                  ),
                                );
                              });
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
