import 'package:hive/hive.dart';
import '../models/medicine_model.dart';
import '../models/history_model.dart';

class HiveDataSource {
  final Box<MedicineModel> medicineBox;
  final Box<HistoryModel> historyBox;

  HiveDataSource({
    required this.medicineBox,
    required this.historyBox,
  });

  Future<void> addMedicine(MedicineModel medicine) async {
    await medicineBox.put(medicine.id, medicine);
  }

  Future<List<MedicineModel>> getMedicines() async {
    return medicineBox.values.toList();
  }

  Future<void> saveHistory(HistoryModel history) async {
    final key =
        '${history.medicineId}-${history.date.toIso8601String()}-${history.time.index}';
    await historyBox.put(key, history);
  }

  Future<List<HistoryModel>> getHistory({
    String? medicineId,
    DateTime? date,
  }) async {
    return historyBox.values.where((h) {
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
