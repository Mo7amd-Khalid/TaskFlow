import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:task_flow/core/routes/routes.dart';
import 'package:task_flow/domain/models/task_dm.dart';
import 'package:task_flow/presentation/add_or_edit_task/add_or_edit_task_view.dart';
import 'package:task_flow/presentation/main/main_view.dart';
import 'package:task_flow/presentation/onboarding/onboarding_view.dart';
import 'package:task_flow/presentation/timer/timer_view.dart';

import '../../presentation/task_details/task_details_view.dart';

abstract class AppRouter {
  static Route generateRoute(RouteSettings settings) {
    if (kDebugMode) {
      print('Navigating to: ${settings.name}');
    }

    final uri = Uri.parse(settings.name ?? '/');

    switch (uri.path) {
      case Routes.onboardingViews:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const OnboardingView(),
        );
      case Routes.mainViews:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MainView(),
        );
      case Routes.addOrEditTaskViews:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => AddOrEditTaskView(
            task: settings.arguments as TaskDm?,
          ),
        );
      case Routes.taskDetailsViews:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => TaskDetailsView(
            taskId: settings.arguments as int
          ),
        );
      case Routes.timerView:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => TimerView(
              task: settings.arguments as TaskDm
          ),
        );
      default:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) =>
              const Scaffold(body: Center(child: Text('404 - Page Not Found'))),
        );
    }
  }
}
