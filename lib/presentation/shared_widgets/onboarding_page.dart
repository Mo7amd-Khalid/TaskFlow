import 'package:flutter/material.dart';
import 'package:task_flow/core/utils/context_func.dart';
import 'package:task_flow/core/utils/padding.dart';
import 'package:task_flow/core/utils/white_spaces.dart';
import 'package:task_flow/domain/models/onboarding_dm.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({
    super.key,
    required this.page,
  });

  final OnboardingDm page;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Image.asset(
            page.imagePath,
            fit: BoxFit.contain,
          ).horizontalPadding(32),
        ),
        24.verticalSpace,
        Text(
          page.title,
          textAlign: TextAlign.center,
          style: context.textStyle.headlineSmall,
        ).horizontalPadding(24),
        12.verticalSpace,
        Text(
          page.description,
          textAlign: TextAlign.center,
          style: context.textStyle.bodyMedium,
        ).horizontalPadding(32),
      ],
    );
  }
}
