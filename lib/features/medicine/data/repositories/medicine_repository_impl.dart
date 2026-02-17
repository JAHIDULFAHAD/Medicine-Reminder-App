import '../../domain/entities/medicine.dart';
import '../../domain/entities/history.dart';
import '../../domain/repositories/medicine_repository.dart';
import '../datasources/hive_datasource.dart';
import '../models/medicine_model.dart';
import '../models/history_model.dart';

class MedicineRepositoryImpl implements MedicineRepository {
  final HiveDataSource localDataSource;

  MedicineRepositoryImpl(this.localDataSource);

  @override
  Future<void> addMedicine(Medicine medicine) async {
    final model = MedicineModel(
      id: medicine.id,
      name: medicine.name,
      times: medicine.times,
      days: medicine.days,
    );
    await localDataSource.addMedicine(model);
  }

  @override
  Future<List<Medicine>> getMedicines() async {
    final models = await localDataSource.getMedicines();
    return models.map((e) => e.toEntity()).toList();
  }

  @override
  Future<void> saveHistory(History history) async {
    final model = HistoryModel(
      medicineId: history.medicineId,
      date: history.date,
      time: history.time,
      taken: history.taken,
    );
    await localDataSource.saveHistory(model);
  }

  @override
  Future<List<History>> getHistory({String? medicineId, DateTime? date}) async {
    final models = await localDataSource.getHistory(
      medicineId: medicineId,
      date: date,
    );
    return models.map((e) => e.toEntity()).toList();
  }
}
