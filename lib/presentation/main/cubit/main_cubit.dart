import 'package:injectable/injectable.dart';
import 'package:task_flow/core/base/base_cubit.dart';
import 'package:task_flow/presentation/main/cubit/main_contract.dart';


@injectable
class MainCubit extends BaseCubit<MainStates, MainActions, MainNavigation>{
  MainCubit() : super(MainStates());

  @override
  Future<void> doAction(MainActions action) async{
    switch(action) {
      case ChangePage():
        changePage(action.currentIndex);
      case GoToAddTaskScreen():
        goToAddTaskScreen();
    }
  }

  void changePage(int currentIndex) {
    if(currentIndex != 2)
      {
        emit(state.copyWith(currentPageIndex: currentIndex));
      }
  }

  void goToAddTaskScreen() {
    emitNavigation(NavigateToAddTaskScreen());
  }
}