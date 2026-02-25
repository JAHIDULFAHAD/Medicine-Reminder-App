import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicine_reminder_app/features/medicine/presentation/cubit/medicine_cubit.dart';

import '../../domain/entities/history.dart';
import '../../domain/entities/medicine.dart';
import '../cubit/medicine_state.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  Map<String, List<History>> _groupHistory(List<History> histories) {
    final Map<String, List<History>> grouped = {};

    histories.sort((a, b) => a.date.compareTo(b.date));
    for (var history in histories) {
      final dateKey =
          '${history.date.year}-${history.date.month}-${history.date.day}';
      grouped.putIfAbsent(dateKey, () => []);
      grouped[dateKey]!.add(history);
    }
    return grouped;
  }

  Map<String, Medicine> _medicineCache(List<Medicine> medicines) {
    final Map<String, Medicine> medicineCache = {};
    for (var medicine in medicines) {
      medicineCache[medicine.id] = medicine;
    }
    return medicineCache;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MedicineCubit, MedicineState>(
        builder: (context, state) {
          if (state is MedicineLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is MedicineLoaded) {
            final groupedHistory = _groupHistory(state.histories);
            final medicineCache = _medicineCache(state.medicines);

            if (groupedHistory.isEmpty) {
              return const Center(child: Text('No history found.'));
            }

            final today = DateTime.now();
            final todayKey = '${today.year}-${today.month}-${today.day}';

            return ListView.builder(
              itemCount: groupedHistory.length,
              itemBuilder: (context, index) {
                final dateKey = groupedHistory.keys.elementAt(index);
                final histories = groupedHistory[dateKey]!;
                final isToday = dateKey == todayKey;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      color: isToday
                          ? Colors.teal.withOpacity(0.25)
                          : Colors.grey.shade200,
                      child: Center(
                        child: Text(
                          isToday ? 'Today' : dateKey,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: histories.length,
                      itemBuilder: (context, index) {
                        final history = histories[index];
                        final medicine = medicineCache[history.medicineId];
                        return Card(
                          child: ListTile(
                            leading: Icon(
                              history.taken ? Icons.check_circle : Icons.cancel,
                              color: history.taken ? Colors.green : Colors.red,
                            ),
                            title: Text(medicine!.name),
                            subtitle: Text(history.time.name),
                            trailing: Text(
                              history.taken ? 'Taken' : 'Missed',
                              style: TextStyle(
                                color: history.taken
                                    ? Colors.green
                                    : Colors.red,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
            );
          }
          return const Center(child: Text("Loading..."));
        },
      ),
    );
  }
}
