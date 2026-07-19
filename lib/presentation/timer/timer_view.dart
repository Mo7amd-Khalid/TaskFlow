import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_flow/core/const/keywords.dart';
import 'package:task_flow/core/di/di.dart';
import 'package:task_flow/core/routes/routes.dart';
import 'package:task_flow/core/theme/app_colors.dart';
import 'package:task_flow/core/utils/context_func.dart';
import 'package:task_flow/core/utils/padding.dart';
import 'package:task_flow/core/utils/time_and_date.dart';
import 'package:task_flow/domain/models/task_dm.dart';
import 'package:task_flow/presentation/shared_widgets/app_dialogs.dart';
import 'package:task_flow/presentation/timer/cubit/timer_contract.dart';
import 'package:task_flow/presentation/timer/cubit/timer_cubit.dart';

import '../../core/utils/white_spaces.dart';

class TimerView extends StatefulWidget {
  const TimerView({super.key, required this.task});

  final TaskDm task;

  @override
  State<TimerView> createState() => _TimerViewState();
}

class _TimerViewState extends State<TimerView> {
  late Timer timer = Timer.periodic(Duration(),(_){});

  final TimerCubit _timerCubit = getIt();

  @override
  void initState() {
    _timerCubit.doAction(SetTimerValue(
        plannedDuration: widget.task.plannedDuration,
        spentDuration: widget.task.spentDuration));
    _timerCubit.navigation.listen((event){
      if(!mounted) {
        return;
      }
      switch(event) {
        case ShowSuccessDialog():
          AppDialogs.actionDialog(context: context,
          title: AppKeywords.congrats,
          content: AppKeywords.taskIsCompleted,
            posActionTitle: AppKeywords.ok,
            posAction: (){
            Navigator.pushNamedAndRemoveUntil(context, Routes.mainViews, (_) => false);
            }
          );
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _timerCubit,
      child: BlocBuilder<TimerCubit, TimerState>(
        builder: (_, state) => Scaffold(
          appBar: AppBar(
            title: Text(AppKeywords.timerTask),
            centerTitle: true,
            leading: IconButton(onPressed: (){
              Navigator.pop(context,true);
            }, icon: Icon(Icons.arrow_back)),
          ),
          body: SingleChildScrollView(
              child: Column(
                spacing: 20,
                children:
                [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppColors.white,
                    ),
                    child: Row(
                      spacing: 5,
                      children: [
                        Expanded(
                          child: Column(
                            spacing: 5,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.task.title,style: context.textStyle.titleMedium,),
                              Text(
                                widget.task.description,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: context.textStyle.titleSmall,),
                            ],
                          ),
                        ),
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
                      ],
                    ).allPadding(8),
                  ),
                  Row(
                    spacing: 5,
                    children: [
                      Expanded(child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: AppColors.white,
                        ),
                        child: Column(
                          spacing: 5,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              spacing: 5,
                              children: [
                                Icon(Icons.calendar_month_outlined),
                                Text(AppKeywords.plannedStart),
                              ],
                            ),
                            Text(
                                DateTime.fromMillisecondsSinceEpoch(widget.task.dueStartDate).getFullDateAndTime(),
                              style: context.textStyle.bodyMedium!.copyWith(color: AppColors.black),
                            )
                          ],
                        ),
                      )),
                      Expanded(child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: AppColors.white,
                        ),
                        child: Column(
                          spacing: 5,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              spacing: 5,
                              children: [
                                Icon(Icons.calendar_month_outlined),
                                Text(AppKeywords.plannedEnd),
                              ],
                            ),
                            Text(
                                DateTime.fromMillisecondsSinceEpoch(widget.task.dueEndDate).getFullDateAndTime(),
                              style: context.textStyle.bodyMedium!.copyWith(color: AppColors.black),
                            )
                          ],
                        ),
                      )),

                    ],
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        height: context.heightSize *0.38,
                        width: context.widthSize * 0.8,
                        child: CircularProgressIndicator(
                          value: state.valueOfCircularIndicator,
                          strokeWidth: 8,
                          backgroundColor: Colors.grey.shade800,
                          strokeCap: StrokeCap.round,
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                           AppKeywords.taskDuration,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          12.verticalSpace,
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: AppColors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        Duration(milliseconds: state.timerValue).inHours.toString(),
                                        style: context.textStyle.titleSmall!.copyWith(color: AppColors.black),
                                      ),
                                    ),
                                    (context.heightSize *0.01).verticalSpace,
                                    Text(AppKeywords.hours)
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: AppColors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        Duration(milliseconds: state.timerValue).inMinutes.remainder(60).toString(),
                                        style: context.textStyle.titleSmall!.copyWith(color: AppColors.black),
                                      ),
                                    ),
                                    (context.heightSize *0.01).verticalSpace,
                                    Text(AppKeywords.min)
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: AppColors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        Duration(milliseconds: state.timerValue).inSeconds.remainder(60).toString(),
                                        style: context.textStyle.titleSmall!.copyWith(color: AppColors.black),
                                      ),
                                    ),
                                    (context.heightSize *0.01).verticalSpace,
                                    Text(AppKeywords.seconds)
                                  ],
                                ),
                              ),
                            ],
                          ).horizontalPadding(context.widthSize * 0.12),

                        ],
                      )
                    ],
                  ),
                  Row(
                    spacing: 10,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: (){
                            if(state.isTimerActive)
                              {
                                timer.cancel();
                                _timerCubit.doAction(PauseTimer(task: widget.task));
                              }
                            else
                              {
                                _timerCubit.doAction(ActivateOrDeactivateTheTimer(value: true));
                                timer = Timer.periodic(Duration(seconds: 1), (timer) {
                                  _timerCubit.doAction(PlayTimer(task: widget.task, timer: timer));
                                });
                              }

                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 8
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: AppColors.primary,
                            ),
                            child: Column(
                              children: [
                                state.isTimerActive ? Icon(Icons.pause_circle,color: AppColors.white,) : Icon(Icons.play_circle_fill_outlined,color: AppColors.white,),
                                Text(state.isTimerActive ? AppKeywords.pause : AppKeywords.play,style: context.textStyle.bodySmall!.copyWith(color: AppColors.white),),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ).horizontalPadding(context.widthSize * 0.2),

                ],
              ).allPadding(12)),
        ),
      ),
    );
  }
  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
