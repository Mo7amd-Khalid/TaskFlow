import 'package:flutter/material.dart';
import 'package:task_flow/core/const/database_and_model.dart';
import 'package:task_flow/core/utils/context_func.dart';

class PriorityWidget extends StatelessWidget {
  const PriorityWidget({super.key,required this.priority});

  final Priority priority;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: priority.color.withAlpha(50),
      ),
      child: Center(
        child: Text(priority.displayName, style: context.textStyle.bodySmall!.copyWith(
          fontWeight: FontWeight.w900,
          color: priority.color
        )),
      ),
    );
  }
}

