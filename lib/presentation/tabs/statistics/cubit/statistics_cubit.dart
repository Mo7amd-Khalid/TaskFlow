import 'package:injectable/injectable.dart';
import 'package:task_flow/core/base/base_cubit.dart';
import 'package:task_flow/core/const/database_and_model.dart';
import 'package:task_flow/core/const/keywords.dart';
import 'package:task_flow/core/utils/time_and_date.dart';
import 'package:task_flow/domain/models/task_dm.dart';
import 'package:task_flow/presentation/tabs/home/cubit/home_cubit.dart';
import 'package:task_flow/presentation/tabs/statistics/cubit/statistics_contract.dart';

@injectable
class StatisticsCubit
    extends
        BaseCubit<StatisticsState, StatisticsActions, StatisticsNavigation> {
  StatisticsCubit(this._homeCubit) : super(StatisticsState());

  final HomeCubit _homeCubit;

  @override
  Future<void> doAction(StatisticsActions action) async {
    switch (action) {
      case GetTotalTimeOfCompleteTask():
        _getTotalTimeOfCompleteTask(action.durationOfTask);
    }
  }

  void _getTotalTimeOfCompleteTask(DurationOfTask duration) {
    int? totalMinutes;
    int? totalHours;
    switch (duration) {
      case DurationOfTask.day:
        {
          for(TaskDm task in _homeCubit.state.tasks.data!)
            {
              DateTime dueEndDate = DateTime.fromMillisecondsSinceEpoch(
                task.dueEndDate,
              );
              if (task.status == AppKeywords.complete &&
                  dueEndDate.isSameDateByDay()) {
                Duration duration = dueEndDate.difference(
                  DateTime.fromMillisecondsSinceEpoch(task.dueStartDate),
                );
                totalHours = duration.inHours;
                totalMinutes = duration.inMinutes;
              }
            }

        }
      case DurationOfTask.month:
        {
          _homeCubit.state.tasks.data!.map((task) {
            DateTime dueEndDate = DateTime.fromMillisecondsSinceEpoch(
              task.dueEndDate,
            );
            if (task.status == AppKeywords.complete &&
                dueEndDate.isSameDateByMonth())
            {
              Duration duration = dueEndDate.difference(
                DateTime.fromMillisecondsSinceEpoch(task.dueStartDate),
              );
              totalHours = duration.inHours;
              totalMinutes = duration.inMinutes;
            }
          });
        }
      case DurationOfTask.year:
        {
          _homeCubit.state.tasks.data!.map((task) {
            DateTime dueEndDate = DateTime.fromMillisecondsSinceEpoch(
              task.dueEndDate,
            );
            if( task.status == AppKeywords.complete &&
                dueEndDate.isSameDateByYear())
              {
                Duration duration = dueEndDate.difference(
                  DateTime.fromMillisecondsSinceEpoch(task.dueStartDate),
                );
                totalHours = duration.inHours;
                totalMinutes = duration.inMinutes;
              }
          });
        }
    }

    emit(state.copyWith(totalHours: totalHours, totalMinutes: totalMinutes));
  }
}
