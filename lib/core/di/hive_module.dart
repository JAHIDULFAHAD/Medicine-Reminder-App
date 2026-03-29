import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

import '../../features/medicine/data/models/medicine_model.dart';
import '../../features/medicine/data/models/history_model.dart';

@module
abstract class HiveModule {
  @lazySingleton
  Box<MedicineModel> get medicineBox =>
      Hive.box<MedicineModel>('medicines_box');

  @lazySingleton
  Box<HistoryModel> get historyBox => Hive.box<HistoryModel>('history_box');
}
