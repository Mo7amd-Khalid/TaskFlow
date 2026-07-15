import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:task_flow/core/base/base_cubit.dart';
import 'package:task_flow/domain/models/task_dm.dart';
import 'package:task_flow/presentation/tabs/home/cubit/home_cubit.dart';

import 'calendar_contract.dart';

@injectable
class CalendarCubit extends BaseCubit<CalendarState, CalendarActions, CalendarNavigation>{
  CalendarCubit(this._homeCubit) : super(CalendarState());
  final HomeCubit _homeCubit;

  @override
  Future<void> doAction(CalendarActions action) async{
    switch(action){
      case ChangeSelectedDate():
        _changeSelectedDate(action.date);
      case GoToTaskDetailsScreen():
        _goToTaskDetailsScreen(action.task);
    }
  }

  void _changeSelectedDate(DateTime date) {

    List<TaskDm> tasksPerSelectedDay = [];
    
    _homeCubit.state.tasks.data!.forEach((task) {
      if(DateUtils.isSameDay(date, DateTime.fromMillisecondsSinceEpoch(task.dueStartDate)))
        {
          tasksPerSelectedDay.add(task);
        }
    });

    emit(state.copyWith(tasksPerSelectedDay: tasksPerSelectedDay, selectedDate: date));


  }

  void _goToTaskDetailsScreen(TaskDm task) {
    emitNavigation(NavigateToTaskDetailsScreen(task: task));
  }


}