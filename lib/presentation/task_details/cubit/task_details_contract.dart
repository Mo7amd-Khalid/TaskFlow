import 'package:task_flow/domain/models/task_dm.dart';

class TaskDetailsState {}

sealed class TaskDetailsActions {}
class GoToTimerScreen extends TaskDetailsActions{
  TaskDm task;
  GoToTimerScreen({required this.task});
}

sealed class TaskDetailsNavigation {}
class NavigateToTimerScreen extends TaskDetailsNavigation{
  TaskDm task;
  NavigateToTimerScreen({required this.task});
}
