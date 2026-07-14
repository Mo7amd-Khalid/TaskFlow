import 'package:flutter/material.dart';
import 'package:task_flow/core/const/keywords.dart';

import '../../core/theme/app_colors.dart';
import '../../core/utils/context_func.dart';

class CountOfTasks extends StatelessWidget {
  const CountOfTasks({
    super.key,
    required this.countOfAllTasks,
    required this.countOfCompleteTasks,
    required this.countOfPendingTasks,
  });

  final int countOfAllTasks;
  final int countOfCompleteTasks;
  final int countOfPendingTasks;
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.primaryLight.withAlpha(100)
            ),
            child: Column(
              spacing: 5,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  countOfAllTasks.toString(),
                  style: context.textStyle.displaySmall!.copyWith(color: AppColors.primary, fontWeight: FontWeight.w900),
                ),
                Text(
                  "Tasks",
                  style: context.textStyle.bodyLarge!.copyWith(color: AppColors.primary, fontWeight: FontWeight.w900),

                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.success.withAlpha(50)
            ),
            child: Column(
              spacing: 5,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  countOfCompleteTasks.toString(),
                  style: context.textStyle.displaySmall!.copyWith(color: AppColors.success, fontWeight: FontWeight.w900),
                ),
                Text(
                  AppKeywords.complete,
                  style: context.textStyle.bodyLarge!.copyWith(color: AppColors.success, fontWeight: FontWeight.w900),

                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.warning.withAlpha(50)
            ),
            child: Column(
              spacing: 5,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  countOfPendingTasks.toString(),
                  style: context.textStyle.displaySmall!.copyWith(color: AppColors.warning, fontWeight: FontWeight.w900),
                ),
                Text(
                  AppKeywords.pending,
                  style: context.textStyle.bodyLarge!.copyWith(color: AppColors.warning, fontWeight: FontWeight.w900),

                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
