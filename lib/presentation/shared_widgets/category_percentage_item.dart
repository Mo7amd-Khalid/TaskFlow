import 'package:flutter/material.dart';
import 'package:task_flow/core/utils/context_func.dart';
import 'package:task_flow/core/utils/white_spaces.dart';

class CategoryPercentageItem extends StatelessWidget {
  const CategoryPercentageItem({
    super.key,
    required this.color,
    required this.title,
    required this.percentage,
  });

  final Color color;
  final String title;
  final String percentage;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: context.widthSize * 0.03,
          height: context.heightSize * 0.02,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        (context.widthSize * 0.02).horizontalSpace,
        Expanded(child: Text(title)),
        Text("$percentage %"),
      ],
    );
  }
}
