import 'package:injectable/injectable.dart';
import 'package:task_flow/core/base/base_cubit.dart';
import 'package:task_flow/core/base/results.dart';
import 'package:task_flow/domain/models/task_dm.dart';
import 'package:task_flow/domain/repository/repository.dart';

import 'add_or_edit_task_contract.dart';

@injectable
class AddOrEditTaskCubit
    extends
        BaseCubit<
          AddOrEditTaskState,
          AddOrEditTaskActions,
          AddOrEditTaskNavigation
        > {
  AddOrEditTaskCubit(this._repo) : super(AddOrEditTaskState());

  final Repository _repo;

  @override
  Future<void> doAction(AddOrEditTaskActions action) async {
    switch (action) {
      case AddNewTask():
        addNewTask(action.newTask);
      case UpdateTask():
        _updateTask(action.updatedTask);
    }
  }

  void addNewTask(TaskDm newTask) async {
    emitNavigation(ShowLoadingDialog());
    var response = await _repo.addTask(newTask);
    switch (response) {
      case Success<void>():
        emitNavigation(ShowSuccessDialog(message: response.message!));
      case Failure<void>():
        emitNavigation(ShowErrorDialog(message: response.message!));
    }
  }

  void _updateTask(TaskDm updatedTask) async {
    emitNavigation(ShowLoadingDialog());
    if ((updatedTask.plannedDuration - (updatedTask.spentDuration ?? 0)).isNegative) {
      emitNavigation(
        ShowErrorDialog(
          message:
              "If you need to update the planned date of this task to this, You already completed this task.",
        ),
      );
    }
    else
      {
        var response = await _repo.updateTask(updatedTask);
        switch (response) {
          case Success<void>():
            emitNavigation(ShowSuccessDialog(message: response.message!));
          case Failure<void>():
            emitNavigation(ShowErrorDialog(message: response.message!));
        }
      }

  }
}
