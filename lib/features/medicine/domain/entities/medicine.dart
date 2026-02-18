import 'medicine_time.dart';

class Medicine {
  final String id;
  final String name;
  final List<MedicineTime> times; // morning, noon, night
  final List<int> days; // how many days

  Medicine({
    required this.id,
    required this.name,
    required this.times,
    required this.days,
  });
}
