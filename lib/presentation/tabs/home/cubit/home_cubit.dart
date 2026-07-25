import 'package:injectable/injectable.dart';
import 'package:task_flow/core/base/base_cubit.dart';
import 'package:task_flow/core/base/results.dart';
import 'package:task_flow/core/const/keywords.dart';
import 'package:task_flow/core/utils/resources.dart';
import 'package:task_flow/domain/models/task_dm.dart';
import 'package:task_flow/domain/repository/repository.dart';
import 'package:task_flow/presentation/tabs/home/cubit/home_contract.dart';

@singleton
class HomeCubit extends BaseCubit<HomeStates, HomeActions, HomeNavigation> {
  HomeCubit(this._repo) : super(HomeStates());

  final Repository _repo;

  @override
  Future<void> doAction(HomeActions action) async {
    switch (action) {
      case GoToTaskDetailsScreen():
        _goT0TaskDetailsScreen(action.task);
      case GetTasks():
        _getTasks();
      case DeleteTask():
        _deleteTask(action.task);
    }
  }

  void _goT0TaskDetailsScreen(TaskDm task) {
    emitNavigation(NavigateToTaskDetailsScreen(task));
  }

  void _getTasks() async {
    emit(state.copyWith(tasks: Resources.loading()));
    var response = await _repo.getTasksWithoutDeleted();
    switch (response) {
      case Success<List<TaskDm>>():
        int pendingTasks = 0;
        int completedTasks = 0;
        for (TaskDm task in response.data!) {
          if (task.status == AppKeywords.pending) {
            pendingTasks++;
          } else {
            completedTasks++;
          }
        }
        emit(
          state.copyWith(
            completeTasks: completedTasks,
            pendingTasks: pendingTasks,
            tasks: Resources.success(data: response.data),
          ),
        );
      case Failure<List<TaskDm>>():
        emit(
          state.copyWith(
            tasks: Resources.failure(
              exception: response.exception,
              message: response.message,
            ),
          ),
        );
    }
  }

  void _deleteTask(TaskDm task) async {
    TaskDm newTask = task.copyWith(
      isDeleted: true,
    );
    var response = await _repo.updateTask(newTask);
    switch (response) {
      case Success<void>():
        _getTasks();
        emitNavigation(ShowSuccessDialog(message: response.message!));
      case Failure<void>():
        emitNavigation(ShowErrorDialog(message: response.message!));
    }
  }
}
