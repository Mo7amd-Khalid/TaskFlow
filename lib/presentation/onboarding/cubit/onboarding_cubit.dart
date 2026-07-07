import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_flow/core/base/base_cubit.dart';
import 'package:task_flow/core/const/sharedPreferencesKeys.dart';
import 'package:task_flow/presentation/onboarding/cubit/onboarding_contract.dart';

@injectable
class OnboardingCubit
    extends BaseCubit<OnboardingState, OnboardingAction, OnboardingNavigation> {
  OnboardingCubit(this._preferences) : super(OnboardingState());

  final SharedPreferences _preferences;
  @override
  Future<void> doAction(OnboardingAction action) async {
    switch (action) {
      case OnPageChanged():
        onPageChanged(action.index);
      case GoToMainScreen():
        goToMainScreen();
    }
  }

  void onPageChanged(int index) {
    emit(state.copyWith(currentPage: index));
  }

  void goToMainScreen() async{
    await _preferences.setBool(SharedPreferencesKeys.onboardingKey, true);
    emitNavigation(NavigateToMain());
  }


}
