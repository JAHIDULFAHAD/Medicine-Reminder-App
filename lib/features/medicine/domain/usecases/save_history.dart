import '../entities/history.dart';
import '../repositories/medicine_repository.dart';

class SaveHistory {
  final MedicineRepository repository;

  SaveHistory(this.repository);

  Future<void> call(History history) async {
    try {
      await repository.saveHistory(history);
    } catch (e) {
      throw Exception("Failed to save history");
    }
  }
}
