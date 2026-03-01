import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/medicine.dart';
import '../../domain/entities/medicine_time.dart';
import '../cubit/medicine_cubit.dart';

class AddMedicineScreen extends StatefulWidget {
  const AddMedicineScreen({super.key});

  @override
  State<AddMedicineScreen> createState() => _AddMedicineScreenState();
}

class _AddMedicineScreenState extends State<AddMedicineScreen> {
  final List<String> medicineList = [
    'Paracetamol',
    'Vitamin C',
    'Aspirin',
    'Antibiotic',
  ];
  String? selectedMedicine;

  int? selectedDay;

  final Set<MedicineTime> selectedTimes = {};

  final _formKey = GlobalKey<FormState>();

  bool showTimeError = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Medicine'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: DropdownButtonFormField<String>(
                hint: Text('Select Medicine'),
                value: selectedMedicine,
                items: medicineList.map((med) {
                  return DropdownMenuItem(value: med, child: Text(med));
                }).toList(),
                validator: (value) {
                  if (value == null) {
                    return "Please select a medicine";
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    selectedMedicine = value;
                    selectedDay = null;
                  });
                },
              ),
            ),

            if (selectedMedicine != null)
              Padding(
                padding: EdgeInsets.all(16),
                child: Builder(
                  builder: (context) {
                    final days = context
                        .read<MedicineCubit>()
                        .getDaysForMedicine(selectedMedicine!);
                    return DropdownButtonFormField<int>(
                      hint: Text('Select Days'),
                      value: selectedDay,
                      items: days.map((day) {
                        return DropdownMenuItem(
                          value: day,
                          child: Text('$day Days'),
                        );
                      }).toList(),
                      validator: (value) {
                        if (value == null) {
                          return "Please select days";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          selectedDay = value;
                        });
                      },
                    );
                  },
                ),
              ),

            if (selectedDay != null)
              Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Select Times',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    CheckboxListTile(
                      title: Text('Morning'),
                      value: selectedTimes.contains(MedicineTime.morning),
                      onChanged: (val) {
                        setState(() {
                          if (val == true) {
                            selectedTimes.add(MedicineTime.morning);
                          } else {
                            selectedTimes.remove(MedicineTime.morning);
                          }
                        });
                      },
                    ),

                    CheckboxListTile(
                      title: Text('Afternoon'),
                      value: selectedTimes.contains(MedicineTime.noon),
                      onChanged: (val) {
                        setState(() {
                          if (val == true) {
                            selectedTimes.add(MedicineTime.noon);
                          } else {
                            selectedTimes.remove(MedicineTime.noon);
                          }
                        });
                      },
                    ),

                    CheckboxListTile(
                      title: Text('Night'),
                      value: selectedTimes.contains(MedicineTime.night),
                      onChanged: (val) {
                        setState(() {
                          if (val == true) {
                            selectedTimes.add(MedicineTime.night);
                          } else {
                            selectedTimes.remove(MedicineTime.night);
                          }
                          showTimeError = false;
                        });
                      },
                    ),
                    if (showTimeError)
                      Padding(
                        padding: EdgeInsetsGeometry.only(left: 12),
                        child: Text(
                          "Please select at least on time",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                  ],
                ),
              ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: FilledButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.teal),
                  ),
                  onPressed: () {
                    saveMedicine();
                  },
                  child: Text('Save', style: TextStyle(fontSize: 16)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> saveMedicine() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    if (selectedTimes.isEmpty) {
      setState(() {
        showTimeError = true;
      });
      return;
    }
    final date = context.read<MedicineCubit>().selectedDate;
    final medicine = Medicine(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: selectedMedicine!,
      createdAt: DateTime(date.year, date.month, date.day),
      days: List.generate(selectedDay!, (index) => index + 1),
      times: selectedTimes.toList(),
    );

    context.read<MedicineCubit>().addMedicine(medicine);

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Medicine added successfully')));

    context.pop();
  }
}
