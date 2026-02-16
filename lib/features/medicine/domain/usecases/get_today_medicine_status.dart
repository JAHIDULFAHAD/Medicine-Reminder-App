import '../entities/medicine_time.dart';
import '../repositories/medicine_repository.dart';

class GetTodayMedicineStatus {
  final MedicineRepository repository;

  GetTodayMedicineStatus(this.repository);

  Future<Map<String, Map<MedicineTime, bool>>> call() async {
    final today = DateTime.now();
    final historyList = await repository.getHistory(date: today);

    // Map: medicineId -> {time -> taken}
    final Map<String, Map<MedicineTime, bool>> result = {};

    for (var history in historyList) {
      result.putIfAbsent(history.medicineId, () => {});
      result[history.medicineId]![history.time] = history.taken;
    }

    return result;
  }
}
