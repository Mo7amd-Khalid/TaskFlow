import 'package:flutter/material.dart';
import 'package:task_flow/core/const/keywords.dart';

import '../../core/theme/app_colors.dart';
import '../../core/utils/context_func.dart';
import '../../core/utils/white_spaces.dart';

class DurationView extends StatelessWidget {
  const DurationView({super.key, required this.durationOfTask});


  final int durationOfTask;

  @override
  Widget build(BuildContext context) {
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
                  Duration(milliseconds: durationOfTask).inDays.toString(),
                  style: context.textStyle.titleSmall!.copyWith(color: AppColors.black),
                ),
              ),
              (context.heightSize *0.01).verticalSpace,
              Text(AppKeywords.days)
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
                  Duration(milliseconds: durationOfTask).inHours.remainder(24).toString(),
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
                  Duration(milliseconds: durationOfTask).inMinutes.remainder(60).toString(),
                  style: context.textStyle.titleSmall!.copyWith(color: AppColors.black),
                ),
              ),
              (context.heightSize *0.01).verticalSpace,
              Text(AppKeywords.min)
            ],
          ),
        ),
      ],
    );
  }
}
