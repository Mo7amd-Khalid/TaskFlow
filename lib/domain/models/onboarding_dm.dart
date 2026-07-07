import 'package:task_flow/core/const/assets.dart';
import 'package:task_flow/core/const/keywords.dart';

class OnboardingDm {
  const OnboardingDm({
    required this.imagePath,
    required this.title,
    required this.description,
  });

  final String imagePath;
  final String title;
  final String description;

  static List<OnboardingDm> get pages => [
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
        ),
      ];
}
