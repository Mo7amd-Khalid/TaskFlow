import 'package:flutter/material.dart';
import 'package:task_flow/core/const/keywords.dart';

import '../../core/theme/app_colors.dart';
import '../../core/utils/context_func.dart';
import '../../core/utils/white_spaces.dart';

class DurationView extends StatelessWidget {
  const DurationView({super.key, required this.startDateAndTime, required this.endDateAndTime});

  final int startDateAndTime;
  final int endDateAndTime;

  @override
  Widget build(BuildContext context) {
    Duration durationOfTask = DateTime.fromMillisecondsSinceEpoch(endDateAndTime)
        .difference(
      DateTime.fromMillisecondsSinceEpoch(startDateAndTime),
    );
    return Row(
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
                  durationOfTask.inMinutes.remainder(60).toString(),
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
                  durationOfTask.inHours.remainder(24).toString(),
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
                  durationOfTask.inDays.toString(),
                  style: context.textStyle.titleSmall!.copyWith(color: AppColors.black),
                ),
              ),
              (context.heightSize *0.01).verticalSpace,
              Text(AppKeywords.days)
            ],
          ),
        ),
      ],
    );
  }
}
