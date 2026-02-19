import 'package:hive/hive.dart';

part 'medicine_time.g.dart';

@HiveType(typeId: 2)
enum MedicineTime {
  @HiveField(0)
  morning,

  @HiveField(1)
  noon,

  @HiveField(2)
  night,
}
