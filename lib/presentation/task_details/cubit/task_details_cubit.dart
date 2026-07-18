import 'package:injectable/injectable.dart';
import 'package:task_flow/core/base/base_cubit.dart';
import 'package:task_flow/domain/models/task_dm.dart';
import 'package:task_flow/presentation/task_details/cubit/task_details_contract.dart';

@injectable
class TaskDetailsCubit extends BaseCubit<TaskDetailsState,TaskDetailsActions,TaskDetailsNavigation>{
  TaskDetailsCubit() : super(TaskDetailsState());


  @override
  Future<void> doAction(TaskDetailsActions action) async{
    switch(action) {
      case GoToTimerScreen():
        _goToTimerScreen(action.task);
    }
  }

  void _goToTimerScreen(TaskDm task) async{
   emitNavigation(NavigateToTimerScreen(task: task));
  }


}