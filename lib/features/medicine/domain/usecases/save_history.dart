import '../entities/history.dart';
import '../repositories/medicine_repository.dart';

class SaveHistory {
  final MedicineRepository repository;

  SaveHistory(this.repository);

  Future<void> call(History history) async {
    await repository.saveHistory(history);
  }
}
