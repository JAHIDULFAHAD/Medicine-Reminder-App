import 'package:injectable/injectable.dart';

import '../entities/medicine.dart';
import '../repositories/medicine_repository.dart';

@injectable
class GetMedicines {
  final MedicineRepository repository;

  GetMedicines(this.repository);

  Future<List<Medicine>> call() async {
    try {
      return await repository.getMedicines();
    } catch (e) {
      return [];
    }
  }
}
