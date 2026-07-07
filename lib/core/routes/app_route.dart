import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:task_flow/core/routes/routes.dart';
import 'package:task_flow/presentation/main/main_view.dart';
import 'package:task_flow/presentation/onboarding/onboarding_view.dart';

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

      default:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) =>
              const Scaffold(body: Center(child: Text('404 - Page Not Found'))),
        );
    }
  }
}
