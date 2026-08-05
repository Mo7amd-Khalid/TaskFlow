import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:task_flow/core/theme/app_colors.dart';
import 'package:task_flow/core/utils/context_func.dart';
import 'package:task_flow/core/utils/white_spaces.dart';
import 'package:task_flow/presentation/main/cubit/main_contract.dart';
import 'package:task_flow/presentation/main/cubit/main_cubit.dart';

class TaskItemShimmer extends StatelessWidget {
  const TaskItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainStates>(
      builder: (_, mainState) => Shimmer.fromColors(
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
                      color: mainState.themeMode == ThemeMode.dark ? AppColors.backgroundDark : AppColors.white,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  12.verticalSpace,
                  Container(
                    width: context.widthSize * 0.2,
                    height: context.heightSize*0.03,
                    decoration: BoxDecoration(
                      color: mainState.themeMode == ThemeMode.dark ? AppColors.backgroundDark : AppColors.white,
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
                color: mainState.themeMode == ThemeMode.dark ? AppColors.backgroundDark : AppColors.white,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}