import '../entities/Medicine.dart';
import '../repositories/medicine_repository.dart';

class GetMedicines {
  final MedicineRepository repository;

  GetMedicines(this.repository);

  Future<List<Medicine>> call() async {
    return await repository.getMedicines();
  }
}
