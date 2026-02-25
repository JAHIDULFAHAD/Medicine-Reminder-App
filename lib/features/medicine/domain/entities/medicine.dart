import 'medicine_time.dart';

class Medicine {
  final String id;
  final String name;
  final DateTime createdAt;
  final List<MedicineTime> times; // morning, noon, night
  final List<int> days; // how many days

  Medicine({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.times,
    required this.days,
  });
}
