import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class PageIndicator extends StatelessWidget {
  const PageIndicator({super.key,
    required this.count,
    required this.currentIndex,
  });

  final int count;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (index) {
        final isActive = index == currentIndex;

        return GestureDetector(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            margin: const EdgeInsets.symmetric(horizontal: 4),
            height: 8,
            width: isActive ? 24 : 8,
            decoration: BoxDecoration(
              color: isActive
                  ? AppColors.primary
                  : AppColors.primary.withValues(alpha: 0.25),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        );
      }),
    );
  }
}
