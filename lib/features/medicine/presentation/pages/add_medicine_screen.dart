import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  final List<int> dayOptions = [1, 3, 7, 14, 30];
  int? selectedDay;

  final Set<MedicineTime> selectedTimes = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Medicine'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: DropdownButtonFormField<String>(
              hint: Text('Select Medicine'),
              value: selectedMedicine,
              items: medicineList.map((med) {
                return DropdownMenuItem(value: med, child: Text(med));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedMedicine = value;
                });
              },
            ),
          ),

          if (selectedMedicine != null)
            Padding(
              padding: EdgeInsets.all(16),
              child: DropdownButtonFormField<int>(
                hint: Text('Select Days'),
                value: selectedDay,
                items: dayOptions.map((day) {
                  return DropdownMenuItem(value: day, child: Text('$day Days'));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedDay = value;
                  });
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
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                      });
                    },
                  ),
                ],
              ),
            ),
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
    );
  }

  Future<void> saveMedicine() async {
    if (selectedMedicine == null ||
        selectedDay == null ||
        selectedTimes.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select all fields'),
        ),
      );
      return;
    }

    final medicine = Medicine(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: selectedMedicine!,
      days: List.generate(selectedDay!, (index) => index + 1),
      times: selectedTimes.toList(),
    );

    context.read<MedicineCubit>().addMedicine(medicine);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Medicine added successfully')),
    );

    Navigator.pop(context);
  }

}
