import 'package:flutter_test/flutter_test.dart';
import 'package:medicine_reminder_app/features/medicine/domain/entities/medicine.dart';
import 'package:medicine_reminder_app/features/medicine/domain/entities/history.dart';
import 'package:medicine_reminder_app/features/medicine/domain/entities/medicine_time.dart';
import 'package:medicine_reminder_app/features/medicine/domain/repositories/medicine_repository.dart';
import 'package:medicine_reminder_app/features/medicine/domain/usecases/get_today_medicine_status.dart';

// Temporary InMemory Repository for testing
class InMemoryMedicineRepository implements MedicineRepository {
  final List<Medicine> _medicines = [];
  final List<History> _history = [];

  @override
  Future<void> addMedicine(Medicine medicine) async {
    _medicines.add(medicine);
  }

  @override
  Future<List<Medicine>> getMedicines() async => _medicines;

  @override
  Future<void> saveHistory(History history) async {
    _history.add(history);
  }

  @override
  Future<List<History>> getHistory({String? medicineId, DateTime? date}) async {
    return _history.where((h) {
      final matchId = medicineId == null || h.medicineId == medicineId;
      final matchDate = date == null ||
          (h.date.year == date.year &&
              h.date.month == date.month &&
              h.date.day == date.day);
      return matchId && matchDate;
    }).toList();
  }
}

void main() {
  group('GetTodayMedicineStatusUseCase Test', () {
    late MedicineRepository repository;
    late GetTodayMedicineStatus useCase;

    setUp(() {
      repository = InMemoryMedicineRepository();
      useCase = GetTodayMedicineStatus(repository);
    });

    test('Should return today medicine status correctly', () async {
      final today = DateTime.now();

      // Add medicine history
      await repository.saveHistory(History(
        medicineId: 'med1',
        date: today,
        time: MedicineTime.morning,
        taken: true,
      ));

      await repository.saveHistory(History(
        medicineId: 'med1',
        date: today,
        time: MedicineTime.noon,
        taken: false,
      ));

      final result = await useCase();

      expect(result['med1']![MedicineTime.morning], true);
      expect(result['med1']![MedicineTime.noon], false);
      expect(result['med1']![MedicineTime.night], isNull);
    });

    test('Should return empty map if no history today', () async {
      final result = await useCase();
      expect(result, {});
    });
  });
}
