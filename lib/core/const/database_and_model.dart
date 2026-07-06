enum Priority {
  low,
  medium,
  high,
}
abstract class ConstOfDatabase {
  static const String tasksTable = "tasksTable";
  static const String titleColumn = "titleColumn";
  static const String descriptionColumn = "descriptionColumn";
  static const String dueDateColumn = "dueDateColumn";
  static const String dueTimeColumn = "dueTimeColumn";
  static const String priorityColumn = "priorityColumn";
  static const String idColumn = "idColumn";
}