import 'package:injectable/injectable.dart';

import '../entities/medicine.dart';
import '../repositories/medicine_repository.dart';

@injectable
class AddMedicine {
  final MedicineRepository repository;

  AddMedicine(this.repository);

  Future<void> call(Medicine medicine) async {
    try {
      await repository.addMedicine(medicine);
    } catch (e) {
      throw Exception("Failed to add medicine");
    }
  }
}
