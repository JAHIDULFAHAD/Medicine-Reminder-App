import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:medicine_reminder_app/features/medicine/domain/entities/history.dart';
import 'package:medicine_reminder_app/features/medicine/domain/entities/medicine_time.dart';
import 'package:medicine_reminder_app/features/medicine/domain/repositories/medicine_repository.dart';
import 'package:medicine_reminder_app/features/medicine/domain/usecases/get_today_medicine_status.dart';

import '../../../../core/di/setup_test_di.dart';

final getIt = GetIt.instance;

void main() {
  setUp(() {
    setupTestDI();
  });

  test('Today medicine status fetch test', () async {
    final repository = getIt<MedicineRepository>();
    final useCase = GetTodayMedicineStatus(repository);

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

    final status = await useCase(today);

    expect(status['med1']![MedicineTime.morning], true);
    expect(status['med1']![MedicineTime.noon], false);
    expect(status['med1']![MedicineTime.night], isNull);
  });
}
