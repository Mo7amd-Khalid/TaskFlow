import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:task_flow/core/const/keywords.dart';
import 'package:task_flow/core/di/di.dart';
import 'package:task_flow/core/routes/routes.dart';
import 'package:task_flow/core/theme/app_colors.dart';
import 'package:task_flow/core/utils/padding.dart';
import 'package:task_flow/core/utils/time_and_date.dart';
import 'package:task_flow/presentation/main/cubit/main_contract.dart';
import 'package:task_flow/presentation/main/cubit/main_cubit.dart';
import 'package:task_flow/presentation/tabs/calendar/cubit/calendar_cubit.dart';

import '../../../core/utils/context_func.dart';
import '../../shared_widgets/task_item.dart';
import 'cubit/calendar_contract.dart';

class CalendarView extends StatefulWidget {
  const CalendarView({super.key});

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {

  final CalendarCubit _calendarCubit = getIt();

  @override
  void initState() {
    super.initState();
    _calendarCubit.doAction(ChangeSelectedDate(date: DateTime.now()));
    _calendarCubit.navigation.listen((event){
      switch(event) {
        case NavigateToTaskDetailsScreen():
          Navigator.pushNamed(context, Routes.taskDetailsViews, arguments: event.taskId);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _calendarCubit,
      child: BlocBuilder<CalendarCubit, CalendarState>(
        builder: (_, state) => SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TableCalendar(
                currentDay: state.selectedDate,
                firstDay: DateTime.now(),
                lastDay: DateTime(DateTime.now().year + 5),
                focusedDay: state.selectedDate!,
                onDaySelected: (_,date){
                  _calendarCubit.doAction(ChangeSelectedDate(date: date));
                },
                pageAnimationCurve: Curves.easeInOut,
                calendarStyle:  CalendarStyle(
                  todayDecoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: BoxDecoration(
                    color: Colors.deepPurple,
                    shape: BoxShape.circle,
                  ),
                ),
                headerStyle: const HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                ),
              ),
              Text(
                  state.selectedDate!.getDate(),
                style: context.textStyle.titleMedium,
              ).verticalPadding(8),
              BlocBuilder<MainCubit, MainStates>(
                builder: (_, mainState) => Expanded(
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: mainState.themeMode == ThemeMode.dark ? AppColors.backgroundDark : AppColors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: BoxBorder.all(
                            color: mainState.themeMode == ThemeMode.dark ? AppColors.outlineDark : AppColors.outlineLight,
                            width: 2
                        )
                    ),
                    child: state.tasksPerSelectedDay!.isNotEmpty ? ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (_, index) => TaskItem(
                          onTab: (){
                            _calendarCubit.doAction(GoToTaskDetailsScreen(taskId: state.tasksPerSelectedDay![index].id!));
                          },
                          taskItem: state.tasksPerSelectedDay![index],
                        ),
                        separatorBuilder: (_,_) => Divider(
                          height: context.heightSize *0.03,
                          thickness: 1,
                        ),
                        itemCount: state.tasksPerSelectedDay!.length) : Center(child: Text(
                      AppKeywords.emptyList,
                    ))
                  ),
                ),
              ),
            ],
          ).allPadding(12),
        ),
      ),
    );
  }
}
