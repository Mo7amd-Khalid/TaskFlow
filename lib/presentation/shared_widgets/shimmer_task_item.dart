import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:task_flow/core/utils/context_func.dart';
import 'package:task_flow/core/utils/white_spaces.dart';

class TaskItemShimmer extends StatelessWidget {
  const TaskItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Container(
                  width: context.widthSize * 0.6,
                  height: context.heightSize*0.03,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                12.verticalSpace,
                Container(
                  width: context.widthSize * 0.2,
                  height: context.heightSize*0.03,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),

              ],
            ),
          ),
          Container(
            width: context.widthSize * 0.2,
            height: context.heightSize*0.03,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ],
      ),
    );
  }
}