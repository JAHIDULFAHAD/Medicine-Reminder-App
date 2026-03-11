import 'package:injectable/injectable.dart';

import '../entities/history.dart';
import '../repositories/medicine_repository.dart';

@injectable
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
