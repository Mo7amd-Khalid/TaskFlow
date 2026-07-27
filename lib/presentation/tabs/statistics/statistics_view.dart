import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_flow/core/di/di.dart';
import 'package:task_flow/core/utils/context_func.dart';
import 'package:task_flow/core/utils/padding.dart';
import 'package:task_flow/core/utils/resources.dart';
import 'package:task_flow/presentation/main/cubit/main_contract.dart';
import 'package:task_flow/presentation/main/cubit/main_cubit.dart';
import 'package:task_flow/presentation/shared_widgets/category_percentage_item.dart';
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
  final StatisticsCubit _statisticsCubit = getIt();

  @override
  void initState() {
    _statisticsCubit.doAction(GetAllTasks());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _statisticsCubit,
      child: BlocBuilder<StatisticsCubit, StatisticsState>(
        builder: (_, state) => SafeArea(
          child: switch(state.allTasks.state) {
            States.initial || States.loading => Center(child: CircularProgressIndicator(),),
            States.success =>  SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: context.heightSize * 0.02,
                children: [
                  // title
                  Text(
                    AppKeywords.statistics,
                    style: context.textStyle.titleLarge,
                  ),

                  // duration of task
                  SizedBox(
                    width: context.widthSize * 0.3,
                    child: DropdownButtonFormField<DurationOfTask>(
                      alignment: Alignment.center,
                      initialValue: state.durationOfTask,
                      items: DurationOfTask.values.map((category) {
                        return DropdownMenuItem(
                          value: category,
                          child: Row(children: [Text(category.displayName)]),
                        );
                      }).toList(),
                      onChanged: (value) {
                        _statisticsCubit.doAction(
                          ChangeDurationOfTask(newDuration: value!),
                        );
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
                                style: context.textStyle.titleSmall!.copyWith(
                                  color: AppColors.black,
                                ),
                              ),
                            ),
                            (context.heightSize * 0.01).verticalSpace,
                            Text(AppKeywords.hours),
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
                                style: context.textStyle.titleSmall!.copyWith(
                                  color: AppColors.black,
                                ),
                              ),
                            ),
                            (context.heightSize * 0.01).verticalSpace,
                            Text(AppKeywords.min),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // completion task percentage
                  Text(
                    AppKeywords.completionTaskPercentage,
                    style: context.textStyle.titleMedium,
                  ),
                  BlocBuilder<MainCubit, MainStates>(
                    builder: (_,mainState) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      spacing: 10,
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              width: context.widthSize * 0.26,
                              height: context.heightSize * 0.12,
                              child: CircularProgressIndicator(
                                value: state.todayTasksPercentage / 100,
                                strokeWidth: 8,
                                backgroundColor: Colors.grey,
                              ),
                            ),
                            Text(
                              "${state.todayTasksPercentage.toString()}%",
                              style: context.textStyle.bodyLarge
                            ),
                          ],
                        ),
                        Expanded(
                          child: Text(
                              state.messageForCompletedTasks,
                            style: context.textStyle.titleSmall!.copyWith(
                              color: mainState.themeMode == ThemeMode.dark ? AppColors.white : AppColors.black,)
                          ),
                        )
                      ],
                    ),
                  ),

                  // tasks by category
                  Text(
                    AppKeywords.tasksByCategory,
                    style: context.textStyle.titleMedium,),
                  BlocBuilder<MainCubit, MainStates>(
                    builder:(_,mainState) => Container(
                      decoration: BoxDecoration(
                        color: mainState.themeMode == ThemeMode.dark ? AppColors.backgroundDark : AppColors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: context.heightSize * 0.2,
                      child: Row(
                        children: [
                          Expanded(
                            child: PieChart(
                              PieChartData(
                                centerSpaceRadius: 40,
                                sectionsSpace: 2,
                                sections: state.categoryStatistics.keys.map((String category) => PieChartSectionData(
                                    value: state.categoryStatistics[category]?.toDouble(),
                                    color: Category.values.firstWhere((element) => element.displayName == category).color,
                                    radius: 25,
                                    showTitle: false
                                ),).toList(),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: state.categoryStatistics.keys.map((String category) =>
                                  Expanded(
                                    child: CategoryPercentageItem(
                                        color: Category.values.firstWhere((element) => element.displayName == category).color,
                                        title: category,
                                        percentage: state.categoryStatistics[category].toString()),
                                  )).toList(),
                            ).allPadding(12),
                          )
                        ],
                      ),
                    ),
                  ),

                  // info for statistics
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 5,
                    children: [
                      Icon(Icons.info_outline_rounded, size: context.widthSize *0.06,),
                      Expanded(
                        child: Text(
                            AppKeywords.infoForStatistics,
                          style: context.textStyle.titleSmall!.copyWith(
                            color: Colors.grey
                          )
                        ),
                      )
                    ],
                  )
                ],
              ).allPadding(12),
            ),
            States.failure => Center(child: Text(state.allTasks.message!),),
          },
        ),
      ),
    );
  }
}
