class Medicine {
  final String id;
  final String name;
  final List<String> times; // morning, noon, night
  final int days; // how many days

  Medicine({
    required this.id,
    required this.name,
    required this.times,
    required this.days,
  });
}
