import 'package:flutter/material.dart';
import 'package:task_flow/core/const/keywords.dart';
import 'package:task_flow/core/theme/app_colors.dart';
import 'package:task_flow/core/utils/white_spaces.dart';
import 'package:task_flow/domain/models/task_dm.dart';

import '../../core/utils/context_func.dart';
import '../../core/utils/time_and_date.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({required this.taskItem,required this.onTab, super.key});

  final TaskDm taskItem;
  final Function() onTab;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTab,
      child: Row(
        children: [
          Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                taskItem.title,
                style: context.textStyle.titleMedium,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: taskItem.category.color.withAlpha(30),
                ),
                child: Center(
                  child: Text(
                      taskItem.category.displayName,
                      style: context.textStyle.bodySmall!.copyWith(
                      fontWeight: FontWeight.w900,
                      color: taskItem.category.color
                  ),
                  ),
                ),
              )
            ],
          ),
          Spacer(),
          Column(
            children: [
              Text(DateTime.fromMillisecondsSinceEpoch(taskItem.dueStartDate).getFullDateAndTime(),),
              Text(AppKeywords.to),
              Text(DateTime.fromMillisecondsSinceEpoch(taskItem.dueEndDate).getFullDateAndTime(),),

            ],
          ),
          (context.widthSize * 0.02).horizontalSpace,
          Icon(Icons.check_circle_outline, color: taskItem.status == AppKeywords.pending? AppColors.black : AppColors.success,)
        ],
      ),
    );
  }
}
