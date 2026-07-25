import 'package:injectable/injectable.dart';
import 'package:task_flow/core/base/base_cubit.dart';
import 'package:task_flow/core/base/results.dart';
import 'package:task_flow/core/const/database_and_model.dart';
import 'package:task_flow/core/const/keywords.dart';
import 'package:task_flow/core/utils/resources.dart';
import 'package:task_flow/core/utils/time_and_date.dart';
import 'package:task_flow/domain/models/task_dm.dart';
import 'package:task_flow/domain/repository/repository.dart';
import 'package:task_flow/presentation/tabs/statistics/cubit/statistics_contract.dart';

@injectable
class StatisticsCubit
    extends
        BaseCubit<StatisticsState, StatisticsActions, StatisticsNavigation> {
  StatisticsCubit(this._repo) : super(StatisticsState());

  final Repository _repo;

  @override
  Future<void> doAction(StatisticsActions action) async {
    switch (action) {
      case GetTotalSpentTimeOfTasks():
        _getTotalTimeOfCompleteTask(action.durationOfTask, action.tasks);
      case GetAllTasks():
        getAllTasks();
      case ChangeDurationOfTask():
        _changeDurationOfTask(action.newDuration);
      case GetCompleteTasksPercentage():
        _getCompleteTasksPercentage(action.duration, action.tasks);
      case GetCategoryStatistics():
        _getCategoryStatistics(action.duration, action.tasks);
    }
  }

  void getAllTasks() async {
    emit(state.copyWith(allTasks: Resources.loading()));
    var response = await _repo.getAllTasks();
    switch (response) {
      case Success<List<TaskDm>>():
        // make all statistics
        _getTotalTimeOfCompleteTask(state.durationOfTask, response.data!);
        _getCategoryStatistics(state.durationOfTask, response.data!);
        _getCompleteTasksPercentage(state.durationOfTask, response.data!);
        emit(state.copyWith(allTasks: Resources.success(data: response.data)));
      case Failure<List<TaskDm>>():
        emit(
          state.copyWith(
            allTasks: Resources.failure(
              exception: response.exception,
              message: response.message,
            ),
          ),
        );
    }
  }

  void _changeDurationOfTask(DurationOfTask newDuration) {
    emit(state.copyWith(durationOfTask: newDuration));
    _getTotalTimeOfCompleteTask(state.durationOfTask, state.allTasks.data!);
    _getCategoryStatistics(state.durationOfTask, state.allTasks.data!);
    _getCompleteTasksPercentage(state.durationOfTask, state.allTasks.data!);
  }

  void _getTotalTimeOfCompleteTask(DurationOfTask duration, List<TaskDm>? tasks) {
    int totalDuration = 0;
    for (TaskDm task in tasks??[]) {
      DateTime? completedAt = DateTime.fromMillisecondsSinceEpoch(
        task.completedAt??0,
      );
      switch (duration) {
        case DurationOfTask.day:
          {
            if (completedAt.isSameDateByDay()) {
              totalDuration += task.spentDuration!;
            }
          }
        case DurationOfTask.month:
          {
            if (completedAt.isSameDateByMonth()) {
              totalDuration += task.spentDuration!;
            }
          }
        case DurationOfTask.year:
          {
            if (completedAt.isSameDateByYear()) {
              totalDuration += task.spentDuration!;
            }
          }
      }
    }
    Duration totalTime = Duration(milliseconds: totalDuration);
    emit(
      state.copyWith(
        totalHours: totalTime.inHours,
        totalMinutes: totalTime.inMinutes.remainder(60),
      ),
    );
  }

  void _getCompleteTasksPercentage(DurationOfTask duration, List<TaskDm>? tasks) {
    int totalTasks = 0;
    int completeTodayTasks = 0;
    for (TaskDm task in tasks??[]) {
      DateTime? startDate = DateTime.fromMillisecondsSinceEpoch(
        task.dueStartDate,
      );
      switch (duration) {

        case DurationOfTask.day:
          {
            if (startDate.isSameDateByDay())
            {
              totalTasks++;
              if(task.status == AppKeywords.complete)
                {
                  completeTodayTasks++;
                }
            }
          }
        case DurationOfTask.month:
          {
            if (startDate.isSameDateByMonth())
            {
              totalTasks++;
              if(task.status == AppKeywords.complete)
              {
                completeTodayTasks++;
              }
            }
          }
        case DurationOfTask.year:
          {
            if (startDate.isSameDateByYear())
            {
              totalTasks++;
              if(task.status == AppKeywords.complete)
              {
                completeTodayTasks++;
              }
            }
          }
      }
    }

    if(totalTasks == 0)
      {
        emit(state.copyWith(todayTasksPercentage: 0, messageForCompletedTasks: AppKeywords.doNotHaveTasks));
      }
    else
      {
        emit(state.copyWith(
            todayTasksPercentage: (completeTodayTasks / totalTasks * 100).ceil(),
            messageForCompletedTasks: _getTodayTasksMessage((completeTodayTasks / totalTasks * 100).ceil())
        ));
      }



  }

  String _getTodayTasksMessage(int percentage){
    if (percentage == 100) {
      return AppKeywords.complete100percent;
    } else if (percentage >= 75) {
      return  AppKeywords.complete75percent;
    } else if (percentage >= 50) {
      return  AppKeywords.complete50percent;
    } else if (percentage >= 25) {
      return  AppKeywords.complete25percent;
    } else {
      return  AppKeywords.complete0percent;
    }
  }
  void _getCategoryStatistics(DurationOfTask duration, List<TaskDm>? allTasks) {
    int countOfTasks = 0;
    Map<String, int> categoryStatistics = {};
    for(TaskDm task in allTasks??[])
    {
      switch(duration) {
        case DurationOfTask.day:
          if(DateTime.fromMillisecondsSinceEpoch(task.dueStartDate).isSameDateByDay())
            {
              categoryStatistics[task.category.displayName] =
                  (categoryStatistics[task.category.displayName]??0) + 1;
              countOfTasks++;
            }
        case DurationOfTask.month:
          if(DateTime.fromMillisecondsSinceEpoch(task.dueStartDate).isSameDateByMonth())
          {
            categoryStatistics[task.category.displayName] =
                (categoryStatistics[task.category.displayName]??0) + 1;
            countOfTasks++;
          }
        case DurationOfTask.year:
          if(DateTime.fromMillisecondsSinceEpoch(task.dueStartDate).isSameDateByYear())
          {
            categoryStatistics[task.category.displayName] =
                (categoryStatistics[task.category.displayName]??0) + 1;
            countOfTasks++;
          }
      }
    }
    for (var category in Category.values)
    {
      if(countOfTasks == 0)
        {
          countOfTasks = 1;
        }
      categoryStatistics[category.displayName] =
          ((categoryStatistics[category.displayName]??0)/ countOfTasks * 100).ceil();
    }
    emit(state.copyWith(categoryStatistics: categoryStatistics));
  }
}
