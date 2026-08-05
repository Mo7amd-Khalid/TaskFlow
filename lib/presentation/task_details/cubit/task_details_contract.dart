import 'package:task_flow/core/utils/resources.dart';
import 'package:task_flow/domain/models/task_dm.dart';

class TaskDetailsState {
  Resources<TaskDm> task;
  TaskDetailsState({this.task = const Resources.initial()});

  TaskDetailsState copyWith({
    Resources<TaskDm>? task,
  }) {
    return TaskDetailsState(
      task: task ?? this.task,
    );
  }
}

sealed class TaskDetailsActions {}
class GetTaskDetails extends TaskDetailsActions{
  int taskId;
  GetTaskDetails({required this.taskId});
}
class GoToTimerScreen extends TaskDetailsActions{
  TaskDm task;
  GoToTimerScreen({required this.task});
}
class GoToEditScreen extends TaskDetailsActions{
  TaskDm task;
  GoToEditScreen({required this.task});
}

sealed class TaskDetailsNavigation {}
class NavigateToTimerScreen extends TaskDetailsNavigation{
  TaskDm task;
  NavigateToTimerScreen({required this.task});
}
class NavigateToEditScreen extends TaskDetailsNavigation{
  TaskDm task;
  NavigateToEditScreen({required this.task});
}
