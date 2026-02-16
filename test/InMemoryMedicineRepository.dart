import 'package:medicine_reminder_app/features/medicine/domain/entities/Medicine.dart';
import 'package:medicine_reminder_app/features/medicine/domain/entities/history.dart';
import 'package:medicine_reminder_app/features/medicine/domain/repositories/medicine_repository.dart';

class InMemoryMedicineRepository implements MedicineRepository {
  final List<Medicine> _medicines = [];
  final List<History> _history = [];

  @override
  Future<void> addMedicine(Medicine medicine) async {
    _medicines.add(medicine);
  }

  @override
  Future<List<Medicine>> getMedicines() async {
    return _medicines;
  }

  @override
  Future<void> saveHistory(History history) async {
    _history.add(history);
  }

  @override
  Future<List<History>> getHistory({String? medicineId, DateTime? date}) async {
    return _history.where((h) {
      final matchId = medicineId == null || h.medicineId == medicineId;
      final matchDate =
          date == null ||
          (h.date.year == date.year &&
              h.date.month == date.month &&
              h.date.day == date.day);
      return matchId && matchDate;
    }).toList();
  }
}
