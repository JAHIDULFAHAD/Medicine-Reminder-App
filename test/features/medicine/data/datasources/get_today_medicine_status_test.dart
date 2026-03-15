import 'package:flutter_test/flutter_test.dart';
import 'package:medicine_reminder_app/features/medicine/domain/entities/history.dart';
import 'package:medicine_reminder_app/features/medicine/domain/entities/medicine_time.dart';
import 'package:medicine_reminder_app/features/medicine/domain/repositories/medicine_repository.dart';
import 'package:medicine_reminder_app/features/medicine/domain/usecases/get_today_medicine_status.dart';

import '../../domain/repositories/InMemoryMedicineRepository.dart';

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

      await repository.saveHistory(
        History(
          medicineId: 'med1',
          date: today,
          time: MedicineTime.morning,
          taken: true,
        ),
      );

      await repository.saveHistory(
        History(
          medicineId: 'med1',
          date: today,
          time: MedicineTime.noon,
          taken: false,
        ),
      );

      final result = await useCase(today);

      expect(result['med1']![MedicineTime.morning], true);
      expect(result['med1']![MedicineTime.noon], false);
      expect(result['med1']![MedicineTime.night], isNull);
    });

    test('Should return empty map if no history today', () async {
      final today = DateTime.now();

      final result = await useCase(today);

      expect(result, {});
    });
  });
}
