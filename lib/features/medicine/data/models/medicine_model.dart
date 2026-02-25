import 'package:hive/hive.dart';
import '../../domain/entities/medicine.dart';
import '../../domain/entities/medicine_time.dart';

part 'medicine_model.g.dart';

@HiveType(typeId: 0)
class MedicineModel extends Medicine {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final DateTime createdAt;

  @HiveField(3)
  final List<MedicineTime> times;

  @HiveField(4)
  final List<int> days;

  MedicineModel({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.times,
    required this.days,
  }) : super(
         id: id,
         name: name,
         createdAt: createdAt,
         times: times,
         days: days,
       );

  Medicine toEntity() => Medicine(
    id: id,
    name: name,
    createdAt: createdAt,
    times: times,
    days: days,
  );
}
