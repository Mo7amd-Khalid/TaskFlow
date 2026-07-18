import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_flow/core/di/di.dart';
import 'package:task_flow/core/utils/context_func.dart';
import 'package:task_flow/core/utils/padding.dart';
import 'package:task_flow/presentation/tabs/statistics/cubit/statistics_contract.dart';
import 'package:task_flow/presentation/tabs/statistics/cubit/statistics_cubit.dart';

import '../../../core/const/database_and_model.dart';
import '../../../core/const/keywords.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/white_spaces.dart';

class StatisticsView extends StatefulWidget {
  const StatisticsView({super.key});

  @override
  State<StatisticsView> createState() => _StatisticsViewState();
}

class _StatisticsViewState extends State<StatisticsView> {
  DurationOfTask _selectedDuration = DurationOfTask.day;
  final StatisticsCubit _statisticsCubit = getIt();

  @override
  void initState() {
    _statisticsCubit.doAction(GetTotalTimeOfCompleteTask(durationOfTask: _selectedDuration));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _statisticsCubit,
      child: BlocBuilder<StatisticsCubit, StatisticsState>(
        builder:(_,state) => SafeArea(
            child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children:
            [
              SizedBox(
                width: context.widthSize * 0.4,
                child: DropdownButtonFormField<DurationOfTask>(
                  alignment: Alignment.center,
                  initialValue: _selectedDuration,
                  items: DurationOfTask.values.map((category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Row(
                        children: [
                          Text(category.displayName,),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    _selectedDuration = value!;
                  },
                ),
              ),
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
                            state.totalHours.toString(),
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
                            state.totalMinutes.remainder(60).toString(),
                            style: context.textStyle.titleSmall!.copyWith(color: AppColors.black),
                          ),
                        ),
                        (context.heightSize *0.01).verticalSpace,
                        Text(AppKeywords.min)
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ).allPadding(12),
        )),
      ),
    );
  }
}
