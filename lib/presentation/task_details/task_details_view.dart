import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_flow/core/const/keywords.dart';
import 'package:task_flow/core/di/di.dart';
import 'package:task_flow/core/routes/routes.dart';
import 'package:task_flow/core/theme/app_colors.dart';
import 'package:task_flow/core/utils/context_func.dart';
import 'package:task_flow/core/utils/padding.dart';
import 'package:task_flow/core/utils/resources.dart';
import 'package:task_flow/core/utils/time_and_date.dart';
import 'package:task_flow/core/utils/white_spaces.dart';
import 'package:task_flow/presentation/shared_widgets/duration_view.dart';
import 'package:task_flow/presentation/shared_widgets/priority_widget.dart';
import 'package:task_flow/presentation/task_details/cubit/task_details_contract.dart';
import 'package:task_flow/presentation/task_details/cubit/task_details_cubit.dart';

class TaskDetailsView extends StatefulWidget {
  const TaskDetailsView({super.key ,required this.taskId});

  final int taskId;

  @override
  State<TaskDetailsView> createState() => _TaskDetailsViewState();
}

class _TaskDetailsViewState extends State<TaskDetailsView> {
  final TaskDetailsCubit _cubit = getIt();

  @override
  void initState() {
    _cubit.doAction(GetTaskDetails(taskId: widget.taskId));
    _cubit.navigation.listen((event)async{
      if(!mounted) {
        return;
      }
      switch(event) {
        case NavigateToTimerScreen():
          {
            var response = await Navigator.pushNamed(context, Routes.timerView, arguments: event.task);
            if(response == true)
              {
                _cubit.doAction(GetTaskDetails(taskId: widget.taskId));
              }
          }
        case NavigateToEditScreen():
          Navigator.pushNamed(context, Routes.addOrEditTaskViews, arguments: event.task);
      }
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: BlocBuilder<TaskDetailsCubit, TaskDetailsState>(
        builder:(_,state) {
          return Scaffold(
          appBar: AppBar(
            title: Text(AppKeywords.taskDetails),
            centerTitle: true,
          ),
          body: SafeArea(
            bottom: true,
            child: switch(state.task.state) {
              States.initial || States.loading => Center(child: CircularProgressIndicator(),),
              States.success => Column(
                spacing: context.heightSize*0.03,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // task title
                  Row(
                    children: [
                      Text(
                        state.task.data!.title,
                        style: context.textStyle.titleLarge,
                      ),
                      Spacer(),
                      Text(state.task.data!.status),
                      5.horizontalSpace,
                      Icon(Icons.check_circle_outline, color: state.task.data!.status == AppKeywords.pending? AppColors.black : AppColors.success,)
                    ],
                  ),
                  // category
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: state.task.data!.category.color.withAlpha(30),
                        ),
                        child: Row(
                            spacing: 5,
                            children:[
                              CircleAvatar(radius: 5, backgroundColor: state.task.data!.category.color,),
                              Text(state.task.data!.category.displayName, style: context.textStyle.bodySmall!.copyWith(
                                  fontWeight: FontWeight.w900,
                                  color: state.task.data!.category.color
                              )),
                            ]
                        ),
                      ),
                    ],
                  ),
                  // description
                  Text(
                    state.task.data!.description,
                    style: context.textStyle.bodyMedium,),
                  //date
                  Text(
                    AppKeywords.plannedStart,
                    style: context.textStyle.titleSmall!.copyWith(color: AppColors.black),),
                  Row(
                    children: [
                      Icon(Icons.date_range_outlined),
                      (context.widthSize * 0.02).horizontalSpace,
                      Text(
                        DateTime.fromMillisecondsSinceEpoch(state.task.data!.dueStartDate).getDate(),
                        style: context.textStyle.titleSmall,
                      ),
                      Spacer(),
                      Icon(Icons.access_time_outlined),
                      (context.widthSize * 0.02).horizontalSpace,
                      Text(
                        DateTime.fromMillisecondsSinceEpoch(state.task.data!.dueStartDate).getTime(),
                        style: context.textStyle.titleSmall,
                      )
                    ],
                  ).horizontalPadding(context.widthSize*0.02),

                  Text(
                    AppKeywords.plannedEnd,
                    style: context.textStyle.titleSmall!.copyWith(color: AppColors.black),),
                  Row(
                    children: [
                      Icon(Icons.date_range_outlined),
                      (context.widthSize * 0.02).horizontalSpace,
                      Text(
                        DateTime.fromMillisecondsSinceEpoch(state.task.data!.dueEndDate).getDate(),
                        style: context.textStyle.titleSmall,
                      ),
                      Spacer(),
                      Icon(Icons.access_time_outlined),
                      (context.widthSize * 0.02).horizontalSpace,
                      Text(
                        DateTime.fromMillisecondsSinceEpoch(state.task.data!.dueEndDate).getTime(),
                        style: context.textStyle.titleSmall,
                      )
                    ],
                  ).horizontalPadding(context.widthSize*0.02),


                  Row(
                    children: [
                      Icon(Icons.timer_outlined),
                      (context.widthSize * 0.02).horizontalSpace,
                      Text(
                        "Duration",
                        style: context.textStyle.titleSmall!.copyWith(color: AppColors.black),),
                    ],
                  ),
                  DurationView(
                    durationOfTask: state.task.data!.plannedDuration,
                  ),

                  //priority
                  Row(
                    children: [
                      Icon(Icons.star_border_purple500),
                      5.horizontalSpace,
                      Text(
                        AppKeywords.priority,
                        style: context.textStyle.titleSmall!.copyWith(color: AppColors.black),),
                      Spacer(),
                      PriorityWidget(priority: state.task.data!.priority,)
                    ],
                  ),
                  //actions
                  Spacer(),
                  if(state.task.data!.status == AppKeywords.pending)
                    Row(
                      spacing: 10,
                      children: [
                        Expanded(child: OutlinedButton(onPressed: (){
                          _cubit.doAction(GoToEditScreen(task: state.task.data!));
                        }, child: Text(AppKeywords.edit))),
                        Expanded(child: FilledButton(onPressed: (){
                          _cubit.doAction(GoToTimerScreen(task: state.task.data!));
                        }, child: Text(AppKeywords.start)))
                      ],
                    ),
                ],
              ).allPadding(12),
              States.failure => Center(child: Text(state.task.message!),),
            },
          ),
        );
        },
      ),
    );
  }
}
