import 'package:flutter_test/flutter_test.dart';
import 'package:medicine_reminder_app/features/medicine/domain/entities/history.dart';
import 'package:medicine_reminder_app/features/medicine/domain/entities/medicine_time.dart';
import 'package:medicine_reminder_app/features/medicine/domain/usecases/get_today_medicine_status.dart';

import 'InMemoryMedicineRepository.dart';


void main() {
  test('Today medicine status fetch test', () async {
    final repository = InMemoryMedicineRepository(); // temporary in-memory repo
    final useCase = GetTodayMedicineStatus(repository);

    final today = DateTime.now();

    // Add some history
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

    final status = await useCase();

    expect(status['med1']![MedicineTime.morning], true);
    expect(status['med1']![MedicineTime.noon], false);
    expect(status['med1']![MedicineTime.night], isNull);
  });
}
