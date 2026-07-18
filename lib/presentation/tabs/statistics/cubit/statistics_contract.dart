import 'package:task_flow/core/const/database_and_model.dart';

class StatisticsState {
  int totalMinutes;
  int totalHours;

  StatisticsState({this.totalHours = 0, this.totalMinutes = 0});

  StatisticsState copyWith({int? totalMinutes, int? totalHours}){
    return StatisticsState(
        totalHours: totalHours ?? this.totalHours,
        totalMinutes: totalMinutes ?? this.totalMinutes);
  }
}

sealed class StatisticsActions {}
class GetTotalTimeOfCompleteTask extends StatisticsActions{
  DurationOfTask durationOfTask;
  GetTotalTimeOfCompleteTask({required this.durationOfTask});
}

sealed class StatisticsNavigation {}