import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:task_flow/core/base/base_cubit.dart';
import 'package:task_flow/core/const/keywords.dart';
import 'package:task_flow/domain/models/task_dm.dart';
import 'package:task_flow/domain/repository/repository.dart';
import 'package:task_flow/presentation/timer/cubit/timer_contract.dart';

@injectable
class TimerCubit extends BaseCubit<TimerState, TimerActions, TimerNavigations>{
  TimerCubit(this._repo) : super(TimerState());

  Repository _repo;
  @override
  Future<void> doAction(TimerActions action) async{
    switch(action)
    {
      case SetTimerValue():
        _setTimerValue(action.plannedDuration, action.spentDuration);
      case PlayTimer():
        _playTimer(action.task,action.timer);
      case PauseTimer():
        _pauseTimer(action.task);
      case SetValueOfCircularIndicator():
        _setValueOfCircularIndicator(action.valueOfCircularIndicator);
    }
  }

  void _setTimerValue(int plannedDuration, int? spentDuration) {
    int timerValue;
    timerValue = plannedDuration - (spentDuration ?? 0);
    double valueOfCircularIndicator = ((spentDuration??0) / plannedDuration);
    emit(state.copyWith(timerValue: timerValue, valueOfCircularIndicator: valueOfCircularIndicator));
  }

  void _playTimer(TaskDm task, Timer timer) {
    if(state.timerValue > 0)
      {
        emit(state.copyWith(isTimerActive: true, timerValue: (state.timerValue - 1000)));
        double valueOfCircularIndicator = 1 - (state.timerValue / task.plannedDuration);
        _setValueOfCircularIndicator(valueOfCircularIndicator);
      }
    else
      {
        emit(state.copyWith(isTimerActive: false));
        emitNavigation(ShowSuccessDialog());
        _updateTask(
          task: task,
          status: AppKeywords.complete,
          spentDuration: task.plannedDuration,
        );
        timer.cancel();
      }

  }

  void _pauseTimer(TaskDm task) {
    emit(state.copyWith(isTimerActive: false));
    _updateTask(
        task: task,
        status: AppKeywords.pending,
        spentDuration: task.plannedDuration - state.timerValue);
  }

  void _setValueOfCircularIndicator(double valueOfCircularIndicator) {
    emit(state.copyWith(valueOfCircularIndicator: valueOfCircularIndicator));
  }

  void _updateTask({required TaskDm task, required String status, required int spentDuration}) async{
    TaskDm newTask = task.copyWith(
      status: status,
      completedAt: DateTime.now().millisecondsSinceEpoch,
      spentDuration: spentDuration,
    );
    await _repo.updateTask(newTask);
  }

}