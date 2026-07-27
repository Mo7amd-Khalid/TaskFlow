import 'package:flutter/material.dart';
import 'package:task_flow/presentation/tabs/calendar/calendar_view.dart';
import 'package:task_flow/presentation/tabs/home/home_view.dart';
import 'package:task_flow/presentation/tabs/profile/profile_view.dart';
import 'package:task_flow/presentation/tabs/statistics/statistics_view.dart';

class MainStates{
  List<Widget> screens = [
    HomeView(),
    CalendarView(),
    Center(child: Text("Fake button"),),
    StatisticsView(),
    ProfileView(),
  ];
  ThemeMode? themeMode;
  String profileImage;
  String name;

  int currentPageIndex;
  MainStates({this.currentPageIndex = 0, this.themeMode, this.profileImage = "", this.name = ""});

  MainStates copyWith({
    int? currentPageIndex,
    String? profileImage,
    String? name,
    ThemeMode? themeMode,
  }){
    return MainStates(
      profileImage: profileImage ?? this.profileImage,
      name: name ?? this.name,
        currentPageIndex: currentPageIndex ?? this.currentPageIndex,
        themeMode: themeMode ?? this.themeMode
    );
  }
}

sealed class MainActions{}
class ChangePage extends MainActions{
  int currentIndex;
  ChangePage({required this.currentIndex});
}
class ChangeThemeMode extends MainActions{
  BuildContext context;
  ThemeMode mode;
  ChangeThemeMode({required this.context, required this.mode});
}
class GetAppData extends MainActions{}
class ChangeProfileImage extends MainActions{
  BuildContext context;
  ChangeProfileImage({required this.context});
}
class ChangeName extends MainActions{
  String name;
  BuildContext context;
  ChangeName({required this.context, required this.name});
}
class GoToAddTaskScreen extends MainActions{}


sealed class MainNavigation{}
class NavigateToAddTaskScreen extends MainNavigation{}