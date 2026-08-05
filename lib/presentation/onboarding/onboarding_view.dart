import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_flow/core/const/keywords.dart';
import 'package:task_flow/core/di/di.dart';
import 'package:task_flow/core/routes/routes.dart';
import 'package:task_flow/core/theme/app_colors.dart';
import 'package:task_flow/core/utils/padding.dart';
import 'package:task_flow/core/utils/white_spaces.dart';
import 'package:task_flow/presentation/onboarding/cubit/onboarding_contract.dart';
import 'package:task_flow/presentation/onboarding/cubit/onboarding_cubit.dart';
import 'package:task_flow/presentation/shared_widgets/onboarding_page.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  late final PageController _pageController;
  final OnboardingCubit _cubit = getIt();

  @override
  void initState() {
    _pageController = PageController();
    _cubit.navigation.listen((event){
      switch(event) {
        case NavigateToMain():
          Navigator.pushReplacementNamed(context, Routes.mainViews);
      }
    });
    super.initState();

  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(OnboardingCubit cubit, int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    cubit.doAction(OnPageChanged(index));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _cubit,
      child: BlocBuilder<OnboardingCubit, OnboardingState>(
        builder: (_, state) => Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    _cubit.doAction(GoToMainScreen());
                  },
                  child: Text(
                    AppKeywords.skip,
                    style: TextStyle(
                      color: AppColors.textSecondaryLight,
                      fontFamily: AppColors.fontFamily,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ).horizontalPadding(8),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: state.pages.length,
                  onPageChanged: (index){
                    _cubit.doAction(OnPageChanged(index));
                  },
                  itemBuilder: (context, index) {
                    return OnboardingPage(page: state.pages[index]);
                  },
                ),
              ),
              16.verticalSpace,
              _PageIndicator(
                count: state.pages.length,
                currentIndex: state.currentPage,
              ),
              32.verticalSpace,
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => {
                    if(state.isLastPage)
                      {
                        _cubit.doAction(GoToMainScreen())
                      }
                    else
                    {
                    _onPageChanged(_cubit, state.currentPage+1)
                    }

                  },
                  child: Text(
                    state.isLastPage
                        ? AppKeywords.getStarted
                        : AppKeywords.next,
                  ),
                ),
              ).horizontalPadding(24),
              24.verticalSpace,
            ],
          ),
        ),
      ),)
    );
  }
}


class _PageIndicator extends StatelessWidget {
  const _PageIndicator({
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
