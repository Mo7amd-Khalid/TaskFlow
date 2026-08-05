import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_flow/core/const/keywords.dart';
import 'package:task_flow/core/di/di.dart';
import 'package:task_flow/core/routes/routes.dart';
import 'package:task_flow/core/theme/app_colors.dart';
import 'package:task_flow/core/utils/context_func.dart';
import 'package:task_flow/core/utils/padding.dart';
import 'package:task_flow/core/utils/white_spaces.dart';
import 'package:task_flow/presentation/onboarding/cubit/onboarding_contract.dart';
import 'package:task_flow/presentation/onboarding/cubit/onboarding_cubit.dart';

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
              Expanded(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: context.widthSize * 0.95,
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: state.pages.length,
                        onPageChanged: (index){
                          _cubit.doAction(OnPageChanged(index));
                        },
                        itemBuilder: (context, index) {
                          return  Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(image: AssetImage(state.pages[index].imagePath),fit: BoxFit.fill)
                            ),
                          );
                        },
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: TextButton(
                        onPressed: () {
                          _cubit.doAction(GoToMainScreen());
                        },
                        child: Text(
                          AppKeywords.skip,
                          style: context.textStyle.titleSmall!.copyWith(
                            color: AppColors.black
                          )
                        ),
                      ),
                    ).horizontalPadding(8),
                    16.verticalSpace,
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: _PageIndicator(
                        count: state.pages.length,
                        currentIndex: state.currentPage,
                        color: state.pages[state.currentPage].indicatorColor,
                      ).verticalPadding(8),
                    ),
                  ],
                ),
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
    required this.color
  });

  final int count;
  final int currentIndex;
  final Color color;

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
                  ? color
                  : color.withValues(alpha: 0.25),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        );
      }),
    );
  }
}
