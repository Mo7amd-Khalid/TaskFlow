
import 'dart:async';

import 'package:task_flow/domain/models/task_dm.dart';

class TimerState {
  bool isTimerActive;
  double valueOfCircularIndicator;
  int timerValue;

  TimerState({this.isTimerActive = false, this.timerValue = 0, this.valueOfCircularIndicator = 0});

  TimerState copyWith({
    bool? isTimerActive,
    int? timerValue,
    double? valueOfCircularIndicator,
  })
  {
    return TimerState(
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
