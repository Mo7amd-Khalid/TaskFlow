import '../../core/const/database_and_model.dart';

class TaskDm {
  const TaskDm({
    this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.priority,
    required this.category,
    required this.status,
  });

  final int? id;
  final String title;
  final String description;
  final int dueDate;
  final Priority priority;
  final Category category;
  final String status;

  factory TaskDm.fromJson(Map<String, dynamic> json) {
    return TaskDm(
      id: json[ConstOfDatabase.idColumn],
      title: json[ConstOfDatabase.titleColumn] as String,
      description: json[ConstOfDatabase.descriptionColumn] as String,
      dueDate: json[ConstOfDatabase.dueDateColumn] as int,
      priority: Priority.values.byName(
        (json[ConstOfDatabase.priorityColumn] as String).toLowerCase(),
      ),
      category: Category.values.byName(
        (json[ConstOfDatabase.categoryColumn] as String).toLowerCase(),
      ),
      status: json[ConstOfDatabase.statusColumn] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      ConstOfDatabase.titleColumn: title,
      ConstOfDatabase.descriptionColumn: description,
      ConstOfDatabase.dueDateColumn: dueDate,
      ConstOfDatabase.priorityColumn: priority.displayName,
      ConstOfDatabase.categoryColumn: category.displayName,
      ConstOfDatabase.statusColumn: status,
    };
  }

  TaskDm copyWith({
    String? title,
    String? description,
    int? dueDate,
    int? dueTime,
    Priority? priority,
    Category? category,
    String? status,
  }) {
    return TaskDm(
      title: title ?? this.title,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      priority: priority ?? this.priority,
      category: category ?? this.category,
      status: status ?? this.status,
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
            priority == other.priority &&
            category == other.category &&
            status == other.status;
  }

  @override
  int get hashCode =>
      Object.hash(id, title, description, dueDate, priority, category, status);
}

