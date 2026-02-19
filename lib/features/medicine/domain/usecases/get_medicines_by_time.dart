import '../entities/medicine.dart';
import '../entities/medicine_time.dart';
import 'get_medicines.dart';

class GetMedicinesByTime {
  final GetMedicines getMedicines;

  GetMedicinesByTime(this.getMedicines);

  Future<List<Medicine>> call(MedicineTime time) async {
    final medicines = await getMedicines();

    return medicines
        .where((medicine) => medicine.times.contains(time))
        .toList();
  }
}
