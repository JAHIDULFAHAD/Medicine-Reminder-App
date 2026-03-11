import 'package:injectable/injectable.dart';

import '../entities/history.dart';
import '../repositories/medicine_repository.dart';

@injectable
class GetHistory {
  final MedicineRepository repository;

  GetHistory(this.repository);

  Future<List<History>> call({String? medicineId, DateTime? date}) async {
    try {
      return await repository.getHistory(medicineId: medicineId, date: date);
    } catch (e) {
      return [];
    }
  }
}
