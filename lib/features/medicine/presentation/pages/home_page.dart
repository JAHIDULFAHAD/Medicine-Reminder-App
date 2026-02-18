import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/medicine_cubit.dart';
import '../cubit/medicine_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MedicineCubit>();
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: BlocBuilder<MedicineCubit, MedicineState>(
          builder: (context, state) {
            if (state is MedicineLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is MedicineLoaded) {
              final medicines = state.medicines;
              final todayStatus = state.todayStatus;

              if (medicines.isEmpty) {
                return Center(child: Text('No medicines found.'));
              }
              return ListView.builder(
                itemCount: medicines.length,
                itemBuilder: (context, index) {
                  final medicine = medicines[index];
                  final status = todayStatus[medicine.id];
                  return Card(
                    color: Colors.blueGrey,
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            spacing: 12,
                            children: [
                              Icon(Icons.medication),
                              Column(
                                spacing: 8,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    medicine.name,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          PopupMenuButton<String>(
                            icon: Icon(Icons.more_vert, color: Colors.white),
                            onSelected: (value) {
                              print('$value selected for item $index');
                            },
                            itemBuilder: (BuildContext context) => [
                              PopupMenuItem(
                                value: 'Taken',
                                child: Row(
                                  children: [
                                    Icon(Icons.check, color: Colors.green),
                                    SizedBox(width: 8),
                                    Text('Taken'),
                                  ],
                                ),
                              ),
                              PopupMenuItem(
                                value: 'Missed',
                                child: Row(
                                  children: [
                                    Icon(Icons.close, color: Colors.red),
                                    SizedBox(width: 8),
                                    Text('Missed'),
                                  ],
                                ),
                              ),
                              PopupMenuItem(
                                value: 'Not Taken',
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.remove_circle_outline,
                                      color: Colors.orange,
                                    ),
                                    SizedBox(width: 8),
                                    Text('Not Taken'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            return SizedBox();
          },
        ),
      ),
    );
  }
}
