import 'package:injectable/injectable.dart';
import 'package:task_flow/core/base/base_cubit.dart';
import 'package:task_flow/core/base/results.dart';
import 'package:task_flow/core/utils/resources.dart';
import 'package:task_flow/domain/models/task_dm.dart';
import 'package:task_flow/domain/repository/repository.dart';
import 'package:task_flow/presentation/task_details/cubit/task_details_contract.dart';

@injectable
class TaskDetailsCubit extends BaseCubit<TaskDetailsState,TaskDetailsActions,TaskDetailsNavigation>{
  TaskDetailsCubit(this._repo) : super(TaskDetailsState());

  final Repository _repo;
  @override
  Future<void> doAction(TaskDetailsActions action) async{
    switch(action) {
      case GoToTimerScreen():
        _goToTimerScreen(action.task);
      case GetTaskDetails():
        _getTaskDetails(action.taskId);
      case GoToEditScreen():
        _goToEditScreen(action.task);
    }
  }

  void _goToTimerScreen(TaskDm task) async{
   emitNavigation(NavigateToTimerScreen(task: task));
  }

  void _getTaskDetails(int id) async{
    emit(state.copyWith(task: Resources.loading()));
    var response = await _repo.getTaskPerId(id);
    switch(response) {
      case Success<TaskDm>():
        emit(state.copyWith(task: Resources.success(data: response.data)));
      case Failure<TaskDm>():
        emit(state.copyWith(task: Resources.failure(exception: response.exception,message: response.message)));
    }
  }

  void _goToEditScreen(TaskDm task) {
    emitNavigation(NavigateToEditScreen(task: task));
  }


}