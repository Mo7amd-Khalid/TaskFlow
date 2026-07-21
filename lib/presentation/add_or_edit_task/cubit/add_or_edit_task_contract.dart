import 'package:task_flow/domain/models/task_dm.dart';

class AddOrEditTaskState {}

sealed class AddOrEditTaskActions {}
class AddNewTask extends AddOrEditTaskActions {
  TaskDm newTask;
  AddNewTask({required this.newTask});
}
class UpdateTask extends AddOrEditTaskActions {
  TaskDm updatedTask;
  UpdateTask({required this.updatedTask});
}

sealed class AddOrEditTaskNavigation {}
class ShowLoadingDialog extends AddOrEditTaskNavigation {}
class ShowSuccessDialog extends AddOrEditTaskNavigation {
  String message;
  ShowSuccessDialog({required this.message});
}
class ShowErrorDialog extends AddOrEditTaskNavigation {
  String message;
  ShowErrorDialog({required this.message});
}