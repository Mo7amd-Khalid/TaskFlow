import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_flow/core/const/keywords.dart';
import 'package:task_flow/core/di/di.dart';
import 'package:task_flow/core/routes/routes.dart';
import 'package:task_flow/core/theme/app_colors.dart';
import 'package:task_flow/core/utils/context_func.dart';
import 'package:task_flow/core/utils/padding.dart';
import 'package:task_flow/core/utils/time_and_date.dart';
import 'package:task_flow/core/utils/white_spaces.dart';
import 'package:task_flow/domain/models/task_dm.dart';
import 'package:task_flow/presentation/shared_widgets/duration_view.dart';
import 'package:task_flow/presentation/shared_widgets/priority_widget.dart';
import 'package:task_flow/presentation/task_details/cubit/task_details_contract.dart';
import 'package:task_flow/presentation/task_details/cubit/task_details_cubit.dart';

class TaskDetailsView extends StatefulWidget {
  const TaskDetailsView({super.key ,required this.task});

  final TaskDm task;

  @override
  State<TaskDetailsView> createState() => _TaskDetailsViewState();
}

class _TaskDetailsViewState extends State<TaskDetailsView> {
  final TaskDetailsCubit _cubit = getIt();

  @override
  void initState() {
    _cubit.navigation.listen((event){
      switch(event) {
        case NavigateToTimerScreen():
          Navigator.pushNamed(context, Routes.timerView, arguments: event.task);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: BlocBuilder<TaskDetailsCubit, TaskDetailsState>(
        builder:(_,state) => Scaffold(
          appBar: AppBar(),
          body: SafeArea(
            bottom: true,
            child: Column(
              spacing: context.heightSize*0.03,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // task title
                Row(
                  children: [
                    Text(
                      widget.task.title,
                      style: context.textStyle.titleLarge,
                    ),
                    Spacer(),
                    Text(widget.task.status),
                    5.horizontalSpace,
                    Icon(Icons.check_circle_outline, color: widget.task.status == AppKeywords.pending? AppColors.black : AppColors.success,)
                  ],
                ),
                // category
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: widget.task.category.color.withAlpha(30),
                      ),
                      child: Row(
                        spacing: 5,
                        children:[
                          CircleAvatar(radius: 5, backgroundColor: widget.task.category.color,),
                          Text(widget.task.category.displayName, style: context.textStyle.bodySmall!.copyWith(
                fontWeight: FontWeight.w900,
                color: widget.task.category.color
                )),
                        ]
                      ),
                    ),
                  ],
                ),
                // description
                Text(
                  widget.task.description,
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
                      DateTime.fromMillisecondsSinceEpoch(widget.task.dueStartDate).getDate(),
                      style: context.textStyle.titleSmall,
                    ),
                    Spacer(),
                    Icon(Icons.access_time_outlined),
                    (context.widthSize * 0.02).horizontalSpace,
                    Text(
                      DateTime.fromMillisecondsSinceEpoch(widget.task.dueStartDate).getTime(),
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
                      DateTime.fromMillisecondsSinceEpoch(widget.task.dueEndDate).getDate(),
                      style: context.textStyle.titleSmall,
                    ),
                    Spacer(),
                    Icon(Icons.access_time_outlined),
                    (context.widthSize * 0.02).horizontalSpace,
                    Text(
                      DateTime.fromMillisecondsSinceEpoch(widget.task.dueEndDate).getTime(),
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
                  durationOfTask: widget.task.plannedDuration,
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
                    PriorityWidget(priority: widget.task.priority,)
                  ],
                ),
                //actions
                Spacer(),
                if(widget.task.status == AppKeywords.pending)
                  Row(
                  spacing: 10,
                  children: [
                    Expanded(child: OutlinedButton(onPressed: (){}, child: Text(AppKeywords.edit))),
                    Expanded(child: FilledButton(onPressed: (){
                      _cubit.doAction(GoToTimerScreen(task: widget.task));
                    }, child: Text(AppKeywords.start)))
                  ],
                ),
              ],
            ).allPadding(12),
          ),
        ),
      ),
    );
  }
}
