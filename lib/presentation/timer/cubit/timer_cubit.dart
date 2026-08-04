import 'dart:async';

import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:injectable/injectable.dart';
import 'package:task_flow/core/base/base_cubit.dart';
import 'package:task_flow/core/const/keywords.dart';
import 'package:task_flow/domain/mapper/convert_int_to_timer_string.dart';
import 'package:task_flow/domain/models/task_dm.dart';
import 'package:task_flow/domain/repository/repository.dart';
import 'package:task_flow/presentation/timer/cubit/timer_contract.dart';
import 'package:task_flow/services/local_notification_service.dart';

import '../../../services/task_handler.dart';

@injectable
class TimerCubit extends BaseCubit<TimerState, TimerActions, TimerNavigations>{
  TimerCubit(this._repo) : super(TimerState());

  final Repository _repo;
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
      case ActivateOrDeactivateTheTimer():
        _activateOrDeactivateTheTimer(action.value);
      case CancelReminderNotification():
        _cancelReminderNotification(action.task);

    }
  }

  void _setTimerValue(int plannedDuration, int? spentDuration) {
    int timerValue;
    timerValue = plannedDuration - (spentDuration ?? 0);
    double valueOfCircularIndicator = ((spentDuration??0) / plannedDuration);
    emit(state.copyWith(timerValue: timerValue, valueOfCircularIndicator: valueOfCircularIndicator));
  }

  void _playTimer(TaskDm task, Timer timer) async{
    if(state.timerValue > 0)
      {
        emit(state.copyWith(timerValue: (state.timerValue - 1000)));
        await FlutterForegroundTask.updateService(
          notificationTitle: task.title,
          notificationText: convertIntToTimerString(state.timerValue),
          callback: startCallback,

        );
        double valueOfCircularIndicator = 1 - (state.timerValue / task.plannedDuration);
        _setValueOfCircularIndicator(valueOfCircularIndicator);
      }
    else
      {
        _activateOrDeactivateTheTimer(false);
        emitNavigation(ShowSuccessDialog());
        TaskDm updatedTask = task.copyWith(
          status: AppKeywords.complete,
          spentDuration: task.plannedDuration,
        );
        _updateTask(task: updatedTask,);
        timer.cancel();
      }

  }

  void _pauseTimer(TaskDm task) {
    _activateOrDeactivateTheTimer(false);
    TaskDm updatedTask = task.copyWith(
        status: AppKeywords.pending,
        spentDuration: task.plannedDuration - state.timerValue
    );
    _updateTask(task: updatedTask,);
  }

  void _setValueOfCircularIndicator(double valueOfCircularIndicator) {
    emit(state.copyWith(valueOfCircularIndicator: valueOfCircularIndicator));
  }

  void _updateTask({required TaskDm task}) async{
    await _repo.updateTask(task);
  }

  void _activateOrDeactivateTheTimer(bool value) {
    emit(state.copyWith(isTimerActive: !state.isTimerActive));
  }

  void _cancelReminderNotification(TaskDm task) {
    LocalNotificationService.cancelNotification(task.id!);
    TaskDm updatedTask = task.copyWith(
      reminderNotification: false,
    );
    _updateTask(task: updatedTask);
  }

}