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

  Future<void> saveMedicine() async {
    if (!_formKey.currentState!.validate()) return;

    if (selectedTimes.isEmpty) {
      setState(() => showTimeError = true);
      return;
    }

    final cubit = context.read<MedicineCubit>();
    final date = cubit.selectedDate;

    if (selectedDay == null) return;

    final medicine = Medicine(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: selectedMedicine!,
      createdAt: DateTime(date.year, date.month, date.day),
      days: List.generate(selectedDay!, (index) => index + 1),
      times: selectedTimes.toList(),
    );

    await cubit.addMedicine(medicine);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Medicine added successfully')),
    );

    context.pop();
  }

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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                hint: const Text('Select Medicine'),
                value: selectedMedicine,
                items: medicineList.map((med) {
                  return DropdownMenuItem(value: med, child: Text(med));
                }).toList(),
                validator: (value) =>
                    value == null ? "Please select a medicine" : null,
                onChanged: (value) {
                  setState(() {
                    selectedMedicine = value;
                    selectedDay = null;
                  });
                },
              ),

              const SizedBox(height: 16),

              if (selectedMedicine != null)
                Builder(
                  builder: (context) {
                    final days = context
                        .read<MedicineCubit>()
                        .getDaysForMedicine(selectedMedicine!);

                    return DropdownButtonFormField<int>(
                      hint: const Text('Select Days'),
                      value: selectedDay,
                      items: days.map((day) {
                        return DropdownMenuItem(
                          value: day,
                          child: Text('$day Days'),
                        );
                      }).toList(),
                      validator: (value) =>
                          value == null ? "Please select days" : null,
                      onChanged: (value) {
                        setState(() => selectedDay = value);
                      },
                    );
                  },
                ),

              const SizedBox(height: 16),

              if (selectedDay != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Select Times',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    CheckboxListTile(
                      title: const Text('Morning'),
                      value: selectedTimes.contains(MedicineTime.morning),
                      onChanged: (val) {
                        setState(() {
                          val == true
                              ? selectedTimes.add(MedicineTime.morning)
                              : selectedTimes.remove(MedicineTime.morning);
                          showTimeError = false;
                        });
                      },
                    ),

                    CheckboxListTile(
                      title: const Text('Afternoon'),
                      value: selectedTimes.contains(MedicineTime.noon),
                      onChanged: (val) {
                        setState(() {
                          val == true
                              ? selectedTimes.add(MedicineTime.noon)
                              : selectedTimes.remove(MedicineTime.noon);
                        });
                      },
                    ),

                    CheckboxListTile(
                      title: const Text('Night'),
                      value: selectedTimes.contains(MedicineTime.night),
                      onChanged: (val) {
                        setState(() {
                          val == true
                              ? selectedTimes.add(MedicineTime.night)
                              : selectedTimes.remove(MedicineTime.night);

                          showTimeError = false;
                        });
                      },
                    ),

                    if (showTimeError)
                      const Padding(
                        padding: EdgeInsets.only(left: 12),
                        child: Text(
                          "Please select at least one time",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                  ],
                ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: FilledButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.teal),
                  ),
                  onPressed: saveMedicine,
                  child: const Text('Save', style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
