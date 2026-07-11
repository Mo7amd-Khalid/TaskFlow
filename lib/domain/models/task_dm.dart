import 'package:task_flow/core/const/database_and_model.dart';

class TaskDm {
  const TaskDm({
    this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.priority,
  });

  final int? id;
  final String title;
  final String description;
  final int dueDate;
  final Priority priority;

  factory TaskDm.fromJson(Map<String, dynamic> json) {
    return TaskDm(
      id: json[ConstOfDatabase.idColumn],
      title: json[ConstOfDatabase.titleColumn] as String,
      description: json[ConstOfDatabase.descriptionColumn] as String,
      dueDate: json[ConstOfDatabase.dueDateColumn] as int,
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
            priority == other.priority;
  }

  @override
  int get hashCode =>
      Object.hash(id, title, description, dueDate, priority);

}

final List<TaskDm> dummyTasks = [
  TaskDm(
    id: 1,
    title: 'Complete UI Design',
    description: 'Finish the home screen and task details screen.',
    dueDate: DateTime(2026, 7, 15, 9, 0).millisecondsSinceEpoch,
    priority: Priority.high,
  ),
  TaskDm(
    id: 2,
    title: 'Team Meeting',
    description: 'Discuss project progress and upcoming sprint.',
    dueDate: DateTime(2026, 7, 15, 11, 30).millisecondsSinceEpoch,
    priority: Priority.medium,
  ),
  TaskDm(
    id: 3,
    title: 'Read Flutter Documentation',
    description: 'Review state management best practices.',
    dueDate: DateTime(2026, 7, 16, 2, 0).millisecondsSinceEpoch,
    priority: Priority.low,
  ),
  TaskDm(
    id: 4,
    title: 'Workout',
    description: 'Go to the gym for a full-body workout.',
    dueDate: DateTime(2026, 7, 16, 18, 0).millisecondsSinceEpoch,
    priority: Priority.medium,
  ),
  TaskDm(
    id: 5,
    title: 'Buy Groceries',
    description: 'Milk, eggs, bread, vegetables, and fruits.',
    dueDate: DateTime(2026, 7, 17, 17, 30).millisecondsSinceEpoch,
    priority: Priority.low,
  ),
  TaskDm(
    id: 6,
    title: 'Fix Login Bug',
    description: 'Resolve authentication issue in production.',
    dueDate: DateTime(2026, 7, 18, 10, 0).millisecondsSinceEpoch,
    priority: Priority.high,
  ),
  TaskDm(
    id: 7,
    title: 'Prepare Presentation',
    description: 'Create slides for the weekly client meeting.',
    dueDate: DateTime(2026, 7, 19, 13, 0).millisecondsSinceEpoch,
    priority: Priority.high,
  ),
  TaskDm(
    id: 8,
    title: 'Clean Workspace',
    description: 'Organize desk and remove unnecessary items.',
    dueDate: DateTime(2026, 7, 20, 16, 0).millisecondsSinceEpoch,
    priority: Priority.low,
  ),
  TaskDm(
    id: 9,
    title: 'Update Dependencies',
    description: 'Upgrade Flutter packages to the latest versions.',
    dueDate: DateTime(2026, 7, 21, 9, 30).millisecondsSinceEpoch,
    priority: Priority.medium,
  ),
  TaskDm(
    id: 10,
    title: 'Review Pull Requests',
    description: 'Review and merge pending GitHub pull requests.',
    dueDate: DateTime(2026, 7, 22, 15, 30).millisecondsSinceEpoch,
    priority: Priority.high,
  ),
];