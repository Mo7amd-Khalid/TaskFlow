import 'package:task_flow/core/const/database_and_model.dart';
import 'package:task_flow/core/utils/resources.dart';
import 'package:task_flow/domain/models/task_dm.dart';

class StatisticsState {
  int totalMinutes;
  int totalHours;
  int todayTasksPercentage;
  String messageForCompletedTasks;
  Resources<List<TaskDm>> allTasks;
  Map<String, int> categoryStatistics;
  DurationOfTask durationOfTask;

  StatisticsState({
    this.totalHours = 0,
    this.totalMinutes = 0,
    this.todayTasksPercentage = 0,
    this.messageForCompletedTasks = "",
    this.categoryStatistics = const {},
    this.allTasks = const Resources.initial(),
    this.durationOfTask = DurationOfTask.day,
  });

  StatisticsState copyWith({
    int? totalMinutes,
    int? totalHours,
    int? todayTasksPercentage,
    String? messageForCompletedTasks,
    Resources<List<TaskDm>>? allTasks,
    Map<String, int>? categoryStatistics,
    DurationOfTask? durationOfTask,
  }) {
    return StatisticsState(
      totalHours: totalHours ?? this.totalHours,
      totalMinutes: totalMinutes ?? this.totalMinutes,
      todayTasksPercentage: todayTasksPercentage ?? this.todayTasksPercentage,
      messageForCompletedTasks:
          messageForCompletedTasks ?? this.messageForCompletedTasks,
      allTasks: allTasks ?? this.allTasks,
      categoryStatistics: categoryStatistics ?? this.categoryStatistics,
      durationOfTask: durationOfTask ?? this.durationOfTask,
    );
  }
}

sealed class StatisticsActions {}

class GetAllTasks extends StatisticsActions {}

class GetTotalSpentTimeOfTasks extends StatisticsActions {
  List<TaskDm> tasks;
  DurationOfTask durationOfTask;

  GetTotalSpentTimeOfTasks({required this.durationOfTask, required this.tasks});
}

class GetCompleteTasksPercentage extends StatisticsActions {
  DurationOfTask duration;
  List<TaskDm> tasks;

  GetCompleteTasksPercentage({required this.duration, required this.tasks});
}

class GetCategoryStatistics extends StatisticsActions {
  DurationOfTask duration;
  List<TaskDm> tasks;

  GetCategoryStatistics({required this.duration, required this.tasks});
}

class ChangeDurationOfTask extends StatisticsActions {
  DurationOfTask newDuration;

  ChangeDurationOfTask({required this.newDuration});
}

sealed class StatisticsNavigation {}
