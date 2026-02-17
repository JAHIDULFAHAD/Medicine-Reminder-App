import 'package:hive/hive.dart';
import '../../domain/entities/history.dart';
import '../../domain/entities/medicine_time.dart';

part 'history_model.g.dart';

@HiveType(typeId: 1)
class HistoryModel extends History {
  @HiveField(0)
  final String medicineId;

  @HiveField(1)
  final DateTime date;

  @HiveField(2)
  final MedicineTime time;

  @HiveField(3)
  final bool taken;

  HistoryModel({
    required this.medicineId,
    required this.date,
    required this.time,
    required this.taken,
  }) : super(medicineId: medicineId, date: date, time: time, taken: taken);

  History toEntity() =>
      History(medicineId: medicineId, date: date, time: time, taken: taken);
}
