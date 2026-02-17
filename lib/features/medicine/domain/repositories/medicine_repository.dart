import '../entities/medicine.dart';
import '../entities/history.dart';

abstract class MedicineRepository {
  Future<void> addMedicine(Medicine medicine);
  Future<List<Medicine>> getMedicines();

  Future<void> saveHistory(History history);
  Future<List<History>> getHistory({String? medicineId, DateTime? date});
}
