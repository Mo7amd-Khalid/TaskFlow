
import 'dart:async';

import 'package:task_flow/core/utils/resources.dart';
import 'package:task_flow/domain/models/task_dm.dart';

class TimerState {
  Resources<TaskDm> task;
  bool isTimerActive;
  double valueOfCircularIndicator;
  int timerValue;

  TimerState({this.task = const Resources.initial(), this.isTimerActive = false, this.timerValue = 0, this.valueOfCircularIndicator = 0});

  TimerState copyWith({
    Resources<TaskDm>? task,
    bool? isTimerActive,
    int? timerValue,
    double? valueOfCircularIndicator,
  })
  {
    return TimerState(
        task: task ?? this.task,
        isTimerActive: isTimerActive ?? this.isTimerActive,
        timerValue: timerValue ?? this.timerValue,
        valueOfCircularIndicator: valueOfCircularIndicator ?? this.valueOfCircularIndicator
    );
  }

}

sealed class TimerActions{}
class SetTimerValue extends TimerActions{
  int plannedDuration;
  int? spentDuration;
  SetTimerValue({required this.plannedDuration, required this.spentDuration});
}
class SetValueOfCircularIndicator extends TimerActions{
  double valueOfCircularIndicator;
  SetValueOfCircularIndicator({required this.valueOfCircularIndicator});
}
class ActivateOrDeactivateTheTimer extends TimerActions{
  bool value;
  ActivateOrDeactivateTheTimer({required this.value});
}
class PlayTimer extends TimerActions{
  Timer timer;
  TaskDm task;
  PlayTimer({required this.task, required this.timer});
}
class PauseTimer extends TimerActions{
  TaskDm task;
  PauseTimer({required this.task});
}

sealed class TimerNavigations {}
class ShowSuccessDialog extends TimerNavigations{}
