import 'package:task_flow/domain/models/onboarding_dm.dart';

import '../../../core/const/assets.dart';
import '../../../core/theme/app_colors.dart';

class OnboardingState {
  final int currentPage;
  final List<OnboardingDm> pages = [
    const OnboardingDm(
      imagePath: AppImages.onboarding1,
      indicatorColor: AppColors.primary
    ),
    const OnboardingDm(
      imagePath: AppImages.onboarding2,
     indicatorColor: AppColors.warning
    ),
    const OnboardingDm(
      imagePath: AppImages.onboarding3,
      indicatorColor: AppColors.success
    ),];

  OnboardingState({
    this.currentPage = 0,
  });

  bool get isLastPage => currentPage == pages.length - 1;

  OnboardingState copyWith({
    int? currentPage,
  }) {
    return OnboardingState(
      currentPage: currentPage ?? this.currentPage,
    );
  }
}

sealed class OnboardingAction {}

class OnPageChanged extends OnboardingAction {
  OnPageChanged(this.index);

  int index;
}

class GoToMainScreen extends OnboardingAction {}


sealed class OnboardingNavigation {}

class NavigateToMain extends OnboardingNavigation {}
