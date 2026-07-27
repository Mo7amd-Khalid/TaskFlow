import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_flow/core/routes/app_route.dart';
import 'package:task_flow/core/theme/app_theme.dart';
import 'package:task_flow/presentation/main/cubit/main_contract.dart';
import 'package:task_flow/presentation/main/cubit/main_cubit.dart';

import 'core/const/sharedPreferencesKeys.dart';
import 'core/di/di.dart';
import 'core/routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  final SharedPreferences preferences = getIt();
  bool onboarding =
      preferences.getBool(SharedPreferencesKeys.onboardingKey) ?? false;
  final MainCubit mainCubit = getIt();
  mainCubit.doAction(GetAppData());
  runApp(MyApp(onboarding: onboarding,));
}

class MyApp extends StatelessWidget {
  MyApp({super.key, required this.onboarding});

  final bool onboarding;
  final MainCubit _mainCubit = getIt();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _mainCubit,
      child: BlocBuilder<MainCubit, MainStates>(
        builder: (_, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            darkTheme: AppTheme.darkTheme,
            theme: AppTheme.lightTheme,
            themeMode: state.themeMode,
            onGenerateRoute: AppRouter.generateRoute,
            initialRoute: onboarding
                ? Routes.mainViews
                : Routes.onboardingViews,
          );
        },
      ),
    );
  }
}
