import 'package:hive/hive.dart';
import '../models/medicine_model.dart';
import '../models/history_model.dart';

class HiveDataSource {
  static const String medicineBox = 'medicines';
  static const String historyBox = 'history';

  Future<void> addMedicine(MedicineModel medicine) async {
    final box = await Hive.openBox<MedicineModel>(medicineBox);
    await box.put(medicine.id, medicine);
  }

  Future<List<MedicineModel>> getMedicines() async {
    final box = await Hive.openBox<MedicineModel>(medicineBox);
    return box.values.toList();
  }

  Future<void> saveHistory(HistoryModel history) async {
    final box = await Hive.openBox<HistoryModel>(historyBox);
    final key =
        '${history.medicineId}-${history.date.toIso8601String()}-${history.time.index}';
    await box.put(key, history);
  }

  Future<List<HistoryModel>> getHistory({
    String? medicineId,
    DateTime? date,
  }) async {
    final box = await Hive.openBox<HistoryModel>(historyBox);
    final list = box.values.toList();

    return list.where((h) {
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
