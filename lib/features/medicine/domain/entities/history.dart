import 'medicine_time.dart';

class History {
  final String medicineId;
  final DateTime date;
  final MedicineTime time;
  final bool taken;

  History({
    required this.medicineId,
    required this.date,
    required this.time,
    required this.taken,
  });
}
