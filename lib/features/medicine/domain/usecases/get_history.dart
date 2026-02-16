import '../entities/history.dart';
import '../repositories/medicine_repository.dart';

class GetHistory {
  final MedicineRepository repository;

  GetHistory(this.repository);

  Future<List<History>> call({String? medicineId, DateTime? date}) async {
    return await repository.getHistory(medicineId: medicineId, date: date);
  }
}
