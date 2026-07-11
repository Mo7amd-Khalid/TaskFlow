import 'package:flutter/material.dart';
import 'package:task_flow/domain/models/task_dm.dart';

import '../../core/utils/context_func.dart';
import '../../core/utils/time_and_date.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({required this.taskItem, super.key});

  final TaskDm taskItem;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                taskItem.title,
                style: context.textStyle.titleLarge,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                taskItem.description,
                style: context.textStyle.titleSmall,
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
        ),
        Text(DateTime.fromMillisecondsSinceEpoch(taskItem.dueDate).getTime(),),
        IconButton(
          onPressed: (){},
          icon: Icon(Icons.star_border_purple500_outlined),
        )
      ],
    );
  }
}
