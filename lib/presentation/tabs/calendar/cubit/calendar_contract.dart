import 'package:task_flow/domain/models/task_dm.dart';

class CalendarState {
  DateTime? selectedDate = DateTime.now();
  List<TaskDm>? tasksPerSelectedDay;

  CalendarState({
    this.selectedDate,
    this.tasksPerSelectedDay,
  });

  CalendarState copyWith({
    DateTime? selectedDate,
    List<TaskDm>? tasksPerSelectedDay,
  }) {
    return CalendarState(
      selectedDate: selectedDate ?? this.selectedDate,
      tasksPerSelectedDay: tasksPerSelectedDay ?? this.tasksPerSelectedDay,
    );
  }
}

sealed class CalendarActions {}
class ChangeSelectedDate extends CalendarActions {
  DateTime date;

  ChangeSelectedDate({required this.date});
}
class GoToTaskDetailsScreen extends CalendarActions {
  int taskId;
  GoToTaskDetailsScreen({required this.taskId});
}

sealed class CalendarNavigation {}
class NavigateToTaskDetailsScreen extends CalendarNavigation {
  int taskId;
  NavigateToTaskDetailsScreen({required this.taskId});
}
