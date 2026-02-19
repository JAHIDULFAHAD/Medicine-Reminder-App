import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/history.dart';
import '../../domain/entities/medicine.dart';
import '../../domain/entities/medicine_time.dart';
import 'package:flutter/material.dart';

import '../cubit/medicine_cubit.dart';

class MedicineCard extends StatefulWidget {
  final String title;
  final List<Medicine> medicines;
  final Map<String, bool> todayStatus; // medicineId -> taken status

  const MedicineCard({
    super.key,
    required this.title,
    required this.medicines,
    required this.todayStatus,
  });

  @override
  State<MedicineCard> createState() => _MedicineCardState();
}

class _MedicineCardState extends State<MedicineCard> {
  late Map<String, String> selectedStatus; // medicineId -> "Taken"/"Missed"/"Not Taken"

  @override
  void initState() {
    super.initState();
    selectedStatus = {};
    for (var med in widget.medicines) {
      selectedStatus[med.id] = widget.todayStatus[med.id]! ? "Taken" : "Not Taken";
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MedicineCubit>();

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),

            // Medicines list
            ...widget.medicines.map((medicine) {
              final status = selectedStatus[medicine.id]!;
              return ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.medication),
                title: Text(medicine.name),
                trailing: DropdownButton<String>(
                  value: status,
                  items: const [
                    DropdownMenuItem(value: "Taken", child: Text("Taken")),
                    DropdownMenuItem(value: "Missed", child: Text("Missed")),
                    DropdownMenuItem(value: "Not Taken", child: Text("Not Taken")),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedStatus[medicine.id] = value!;
                    });

                    // Save to cubit
                    cubit.saveHistory(
                      History(
                        medicineId: medicine.id,
                        date: DateTime.now(),
                        taken: value == "Taken" ? true : false,
                        time: _getTimeFromTitle(widget.title), // morning/noon/night
                      ),
                    );
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
MedicineTime _getTimeFromTitle(String title) {
  switch (title.toLowerCase()) {
    case "morning":
      return MedicineTime.morning;
    case "noon":
      return MedicineTime.noon;
    case "night":
      return MedicineTime.night;
    default:
      return MedicineTime.morning;
  }
}