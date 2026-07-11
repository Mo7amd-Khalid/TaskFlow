import 'package:flutter/material.dart';
import 'package:task_flow/core/theme/app_colors.dart';
import 'package:task_flow/core/utils/context_func.dart';
import 'package:task_flow/core/utils/padding.dart';
import 'package:task_flow/domain/models/task_dm.dart';

import '../../shared_widgets/count_of_tasks.dart';
import '../../shared_widgets/task_item.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        spacing: context.heightSize * 0.03,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Hi 👋",
                style: context.textStyle.headlineSmall,
              ),
            ],
          ),
          CountOfTasks(countOfAllTasks: 10, countOfCompleteTasks: 5, countOfPendingTasks: 5,),
          Text(
            "Today`s Tasks",
            style: context.textStyle.titleLarge,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(10),
                border: BoxBorder.all(
                  color: AppColors.outlineLight,
                  width: 2
                )
              ),
              child: ListView.separated(
                physics: BouncingScrollPhysics(),
                  itemBuilder: (_, index) => TaskItem(
                    taskItem: dummyTasks[index],
                  ),
                  separatorBuilder: (_,_) => Divider(
                    height: context.heightSize *0.03,
                    thickness: 1,
                  ),
                  itemCount: dummyTasks.length),
            ),
          )
        ],
      ).allPadding(12),
    );
  }
}
