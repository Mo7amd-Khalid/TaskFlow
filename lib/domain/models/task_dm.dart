import 'package:task_flow/core/const/database_and_model.dart';

class TaskDm {
  const TaskDm({
    this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.dueTime,
    required this.priority,
  });

  final int? id;
  final String title;
  final String description;
  final int dueDate;
  final int dueTime;
  final Priority priority;

  factory TaskDm.fromJson(Map<String, dynamic> json) {
    return TaskDm(
      id: json[ConstOfDatabase.idColumn],
      title: json[ConstOfDatabase.titleColumn] as String,
      description: json[ConstOfDatabase.descriptionColumn] as String,
      dueDate: json[ConstOfDatabase.dueDateColumn] as int,
      dueTime: json[ConstOfDatabase.dueTimeColumn] as int,
      priority: Priority.values.byName(
        json[ConstOfDatabase.priorityColumn] as String,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      ConstOfDatabase.titleColumn : title,
      ConstOfDatabase.descriptionColumn: description,
      ConstOfDatabase.dueDateColumn: dueDate,
      ConstOfDatabase.dueTimeColumn: dueTime,
      ConstOfDatabase.priorityColumn: priority.name,
    };
  }

  TaskDm copyWith({
    String? title,
    String? description,
    int? dueDate,
    int? dueTime,
    Priority? priority,
  }) {
    return TaskDm(
      title: title ?? this.title,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      dueTime: dueTime ?? this.dueTime,
      priority: priority ?? this.priority,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is TaskDm &&
            id == other.id &&
            title == other.title &&
            description == other.description &&
            dueDate == other.dueDate &&
            dueTime == other.dueTime &&
            priority == other.priority;
  }

  @override
  int get hashCode =>
      Object.hash(id, title, description, dueDate, dueTime, priority);
}
