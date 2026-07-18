import 'package:task_flow/core/utils/resources.dart';
import 'package:task_flow/domain/models/task_dm.dart';

class HomeStates{
  Resources<List<TaskDm>> tasks;
  int pendingTasks;
  int completedTasks;
  HomeStates({
    this.completedTasks = 0,
    this.pendingTasks = 0,
    this.tasks = const Resources.loading()
  });

  HomeStates copyWith({
    Resources<List<TaskDm>>? tasks,
    int? pendingTasks,
    int? completeTasks,
  }) {
    return HomeStates(
      tasks: tasks ?? this.tasks,
      pendingTasks: pendingTasks ?? this.pendingTasks,
      completedTasks: completeTasks ?? this.completedTasks,
    );
  }
}

sealed class HomeActions{}
class GoToTaskDetailsScreen extends HomeActions{
  TaskDm task;
  GoToTaskDetailsScreen(this.task);
}
class GetTasks extends HomeActions{}
class DeleteTask extends HomeActions{
  TaskDm task;
  DeleteTask(this.task);
}


sealed class HomeNavigation{}
class NavigateToTaskDetailsScreen extends HomeNavigation{
  TaskDm task;
  NavigateToTaskDetailsScreen(this.task);
}
class ShowSuccessDialog extends HomeNavigation{
  String message;
  ShowSuccessDialog({required this.message});
}
class ShowErrorDialog extends HomeNavigation{
  String message;
  ShowErrorDialog({required this.message});
}