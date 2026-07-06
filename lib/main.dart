import 'package:flutter/material.dart';
import 'package:task_flow/core/routes/app_route.dart';
import 'package:task_flow/core/theme/app_theme.dart';

import 'core/di/di.dart';
import 'core/routes/routes.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: AppTheme.darkTheme,
      theme: AppTheme.lightTheme,
      themeMode: ThemeMode.light,
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: Routes.mainViews,
    );
  }
}
