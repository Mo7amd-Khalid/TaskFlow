import 'package:task_flow/domain/models/onboarding_dm.dart';

import '../../../core/const/assets.dart';
import '../../../core/const/keywords.dart';

class OnboardingState {
  final int currentPage;
  final List<OnboardingDm> pages = [
    const OnboardingDm(
      imagePath: AppImages.onboarding1,
      title: AppKeywords.onboardingTitle1,
      description: AppKeywords.onboardingDescription1,
    ),
    const OnboardingDm(
      imagePath: AppImages.onboarding2,
      title: AppKeywords.onboardingTitle2,
      description: AppKeywords.onboardingDescription2,
    ),
    const OnboardingDm(
      imagePath: AppImages.onboarding3,
      title: AppKeywords.onboardingTitle3,
      description: AppKeywords.onboardingDescription3,
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
