import 'package:hive/hive.dart';
import '../models/medicine_model.dart';
import '../models/history_model.dart';

class HiveDataSource {
  final Box<MedicineModel> medicineBox;
  final Box<HistoryModel> historyBox;

  HiveDataSource({required this.medicineBox, required this.historyBox});

  Future<void> addMedicine(MedicineModel medicine) async {
    try {
      await medicineBox.put(medicine.id, medicine);

      print("Saved medicine: ${medicine.name}");
      print("Total in box: ${medicineBox.length}");
    } catch (e) {
      print("Hive Add Medicine Error: $e");
      throw Exception("Failed to save medicine");
    }
  }

  Future<List<MedicineModel>> getMedicines() async {
    try {
      return medicineBox.values.toList();
    } catch (e) {
      print("Hive Read Medicine Error: $e");
      return [];
    }
  }

  Future<void> saveHistory(HistoryModel history) async {
    try {
      final key =
          '${history.medicineId}-${history.date.toIso8601String()}-${history.time.index}';

      await historyBox.put(key, history);
    } catch (e) {
      print("Hive Save History Error: $e");
      throw Exception("Failed to save history");
    }
  }

  Future<List<HistoryModel>> getHistory({
    String? medicineId,
    DateTime? date,
  }) async {
    try {
      return historyBox.values.where((h) {
        final matchId = medicineId == null || h.medicineId == medicineId;

        final matchDate =
            date == null ||
            (h.date.year == date.year &&
                h.date.month == date.month &&
                h.date.day == date.day);

        return matchId && matchDate;
      }).toList();
    } catch (e) {
      print("Hive Get History Error: $e");
      return [];
    }
  }
}
