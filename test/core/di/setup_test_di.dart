import 'package:get_it/get_it.dart';
import 'package:medicine_reminder_app/features/medicine/domain/repositories/medicine_repository.dart';

import '../../features/medicine/domain/repositories/InMemoryMedicineRepository.dart';

final getIt = GetIt.instance;

void setupTestDI() {
  getIt.reset();

  getIt.registerLazySingleton<MedicineRepository>(
    () => InMemoryMedicineRepository(),
  );
}
