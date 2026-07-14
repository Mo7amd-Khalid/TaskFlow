import 'package:flutter/material.dart';
import 'package:task_flow/core/const/keywords.dart';
import 'package:task_flow/core/theme/app_colors.dart';
import 'package:task_flow/core/utils/context_func.dart';
import 'package:task_flow/core/utils/padding.dart';
import 'package:task_flow/core/utils/time_and_date.dart';
import 'package:task_flow/core/utils/white_spaces.dart';
import 'package:task_flow/domain/models/task_dm.dart';
import 'package:task_flow/presentation/shared_widgets/priority_widget.dart';

class TaskDetailsView extends StatelessWidget {
  const TaskDetailsView({super.key ,required this.task});

  final TaskDm task;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  task.title,
                  style: context.textStyle.titleLarge,
                ),
                Spacer(),
                Icon(Icons.star, color: AppColors.warning,)
              ],
            ),
            // category
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: task.category.color.withAlpha(30),
                  ),
                  child: Row(
                    spacing: 5,
                    children:[
                      CircleAvatar(radius: 5, backgroundColor: task.category.color,),
                      Text(task.category.displayName, style: context.textStyle.bodySmall!.copyWith(
            fontWeight: FontWeight.w900,
            color: task.category.color
            )),
                    ]
                  ),
                ),
              ],
            ),
            // description
            Text(
              task.description,
              style: context.textStyle.bodyMedium,),
            //date
            Row(
              children: [
                Icon(Icons.date_range_outlined),
                5.horizontalSpace,
                Text(AppKeywords.date),
                Spacer(),
                Text(
                  DateTime.fromMillisecondsSinceEpoch(task.dueDate).getDate(),
                  style: context.textStyle.titleSmall,
                )
              ],
            ),
            //time
            Row(
              children: [
                Icon(Icons.access_time_outlined),
                5.horizontalSpace,
                Text(AppKeywords.time),
                Spacer(),
                Text(
                  DateTime.fromMillisecondsSinceEpoch(task.dueDate).getTime(),
                  style: context.textStyle.titleSmall,
                )
              ],
            ),
            //priority
            Row(
              children: [
                Icon(Icons.star_border_purple500),
                5.horizontalSpace,
                Text(AppKeywords.priority),
                Spacer(),
                PriorityWidget(priority: task.priority,)
              ],
            ),
            //actions
            Spacer(),
            Row(
              spacing: 10,
              children: [
                Expanded(child: OutlinedButton(onPressed: (){}, child: Text(AppKeywords.edit))),
                Expanded(child: FilledButton(onPressed: (){}, child: Text(AppKeywords.markAsComplete)))
              ],
            ),
          ],
        ).allPadding(12),
      ),
    );
  }
}
