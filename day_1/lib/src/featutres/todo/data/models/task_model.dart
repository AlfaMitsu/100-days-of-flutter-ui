class Task {
  String name;
  String time;
  String date;
  bool isCompleted;

  Task(
      {required this.name,
      required this.time,
      required this.date,
      this.isCompleted = false});
}
