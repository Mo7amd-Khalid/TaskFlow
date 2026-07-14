import 'dart:ui';

import '../theme/app_colors.dart';

enum Priority {
  low('Low', AppColors.success),
  medium('Medium', AppColors.warning),
  high('High', AppColors.error);

  const Priority(this.displayName, this.color);

  final String displayName;
  final Color color;
}

enum Category {
  work('Work', AppColors.primary),
  personal('Personal', AppColors.success),
  study('Study', AppColors.warning),
  shopping('Shopping', AppColors.error);

  const Category(this.displayName, this.color);

  final String displayName;
  final Color color;
}


abstract class ConstOfDatabase {
  static const String tasksTable = "tasksTable";
  static const String titleColumn = "titleColumn";
  static const String descriptionColumn = "descriptionColumn";
  static const String dueDateColumn = "dueDateColumn";
  static const String dueTimeColumn = "dueTimeColumn";
  static const String priorityColumn = "priorityColumn";
  static const String categoryColumn = "categoryColumn";
  static const String statusColumn = "statusColumn";
  static const String idColumn = "idColumn";
}