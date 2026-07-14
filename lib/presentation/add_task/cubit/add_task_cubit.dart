import 'package:injectable/injectable.dart';
import 'package:task_flow/core/base/base_cubit.dart';
import 'package:task_flow/core/base/results.dart';
import 'package:task_flow/domain/models/task_dm.dart';
import 'package:task_flow/domain/repository/repository.dart';
import 'package:task_flow/presentation/add_task/cubit/add_task_contract.dart';


@injectable
class AddTaskCubit extends BaseCubit<AddTaskState, AddTaskActions, AddTaskNavigation>{
  AddTaskCubit(this._repo) : super(AddTaskState());

  final Repository _repo;

  @override
  Future<void> doAction(AddTaskActions action) async{
    switch(action) {
      case AddNewTask():
        addNewTask(action.newTask);
    }
  }

  void addNewTask(TaskDm newTask) async{
    emitNavigation(ShowLoadingDialog());
    var response = await _repo.addTask(newTask);
    switch(response) {
      case Success<void>():
        emitNavigation(ShowSuccessDialog(message: response.message!));
      case Failure<void>():
        emitNavigation(ShowErrorDialog(message: response.message!));
    }

  }


}