import 'package:task_flow/domain/models/task_dm.dart';

class AddTaskState {}

sealed class AddTaskActions {}
class AddNewTask extends AddTaskActions {
  TaskDm newTask;
  AddNewTask({required this.newTask});
}

sealed class AddTaskNavigation {}
class ShowLoadingDialog extends AddTaskNavigation {}
class ShowSuccessDialog extends AddTaskNavigation {
  String message;
  ShowSuccessDialog({required this.message});
}
class ShowErrorDialog extends AddTaskNavigation {
  String message;
  ShowErrorDialog({required this.message});
}