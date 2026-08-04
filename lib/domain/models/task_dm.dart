import '../../core/const/database_and_model.dart';

class TaskDm {
  const TaskDm({
    this.id,
    required this.title,
    required this.description,
    required this.dueStartDate,
    required this.dueEndDate,
    this.completedAt,
    this.spentDuration,
    required this.plannedDuration,
    required this.priority,
    required this.category,
    required this.status,
    this.isDeleted = false,
    required this.reminderNotification,
    this.reminderTime,
  });

  final int? id;
  final String title;
  final String description;
  final int dueStartDate;
  final int dueEndDate;
  final int? completedAt;
  final int plannedDuration;
  final int? spentDuration;
  final Priority priority;
  final Category category;
  final String status;
  final bool isDeleted;
  final bool reminderNotification;
  final int? reminderTime;

  factory TaskDm.fromJson(Map<String, dynamic> json) {
    return TaskDm(
      id: json[ConstOfDatabase.idColumn],
      title: json[ConstOfDatabase.titleColumn] as String,
      description: json[ConstOfDatabase.descriptionColumn] as String,
      dueStartDate: json[ConstOfDatabase.dueStartDateColumn] as int,
      dueEndDate: json[ConstOfDatabase.dueEndDateColumn] as int,
      completedAt: json[ConstOfDatabase.completedAtColumn] as int?,
      spentDuration: json[ConstOfDatabase.spentDurationColumn] as int?,
      plannedDuration: json[ConstOfDatabase.plannedDurationColumn] as int,
      priority: Priority.values.byName(
        (json[ConstOfDatabase.priorityColumn] as String).toLowerCase(),
      ),
      category: Category.values.byName(
        (json[ConstOfDatabase.categoryColumn] as String).toLowerCase(),
      ),
      status: json[ConstOfDatabase.statusColumn] as String,
      isDeleted: (json[ConstOfDatabase.isDeletedColumn] as int?) == 1,
      reminderNotification:
          (json[ConstOfDatabase.reminderNotificationColumn] as int?) == 1,
      reminderTime: json[ConstOfDatabase.reminderTimeColumn] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      ConstOfDatabase.titleColumn: title,
      ConstOfDatabase.descriptionColumn: description,
      ConstOfDatabase.dueStartDateColumn: dueStartDate,
      ConstOfDatabase.dueEndDateColumn: dueEndDate,
      ConstOfDatabase.completedAtColumn: completedAt,
      ConstOfDatabase.spentDurationColumn: spentDuration,
      ConstOfDatabase.plannedDurationColumn: plannedDuration,
      ConstOfDatabase.priorityColumn: priority.displayName,
      ConstOfDatabase.categoryColumn: category.displayName,
      ConstOfDatabase.statusColumn: status,
      ConstOfDatabase.isDeletedColumn: isDeleted == true ? 1 : 0,
      ConstOfDatabase.reminderNotificationColumn: reminderNotification == true
          ? 1
          : 0,
      ConstOfDatabase.reminderTimeColumn: reminderTime,
    };
  }

  TaskDm copyWith({
    String? title,
    String? description,
    int? dueStartDate,
    int? dueEndDate,
    int? completedAt,
    int? spentDuration,
    int? plannedDuration,
    Priority? priority,
    Category? category,
    String? status,
    bool? isDeleted,
    bool? reminderNotification,
    int? reminderTime,
  }) {
    return TaskDm(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      dueStartDate: dueStartDate ?? this.dueStartDate,
      dueEndDate: dueEndDate ?? this.dueEndDate,
      completedAt: completedAt ?? this.completedAt,
      spentDuration: spentDuration ?? this.spentDuration,
      plannedDuration: plannedDuration ?? this.plannedDuration,
      priority: priority ?? this.priority,
      category: category ?? this.category,
      status: status ?? this.status,
      isDeleted: isDeleted ?? this.isDeleted,
      reminderNotification: reminderNotification ?? this.reminderNotification,
      reminderTime: reminderTime ?? this.reminderTime,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is TaskDm &&
            id == other.id &&
            title == other.title &&
            description == other.description &&
            dueStartDate == other.dueStartDate &&
            dueEndDate == other.dueEndDate &&
            completedAt == other.completedAt &&
            spentDuration == other.spentDuration &&
            plannedDuration == other.plannedDuration &&
            priority == other.priority &&
            category == other.category &&
            status == other.status &&
            isDeleted == other.isDeleted &&
            reminderNotification == other.reminderNotification &&
            reminderTime == other.reminderTime;
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    description,
    dueStartDate,
    dueEndDate,
    completedAt,
    spentDuration,
    plannedDuration,
    priority,
    category,
    status,
    isDeleted,
    reminderNotification,
    reminderTime
  );
}
