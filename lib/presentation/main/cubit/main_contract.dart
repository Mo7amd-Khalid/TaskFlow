import 'package:flutter/cupertino.dart';
import 'package:task_flow/presentation/tabs/calender/calender_view.dart';
import 'package:task_flow/presentation/tabs/home/home_view.dart';
import 'package:task_flow/presentation/tabs/profile/profile_view.dart';
import 'package:task_flow/presentation/tabs/statistics/statistics_view.dart';

class MainStates{
  List<Widget> screens = [
    HomeView(),
    CalenderView(),
    Center(child: Text("Fake button"),),
    StatisticsView(),
    ProfileView(),
  ];

  int currentPageIndex;
  MainStates({this.currentPageIndex = 0});

  MainStates copyWith({int? currentPageIndex}){
    return MainStates(currentPageIndex: currentPageIndex ?? this.currentPageIndex);
  }
}

sealed class MainActions{}
class ChangePage extends MainActions{
  int currentIndex;
  ChangePage({required this.currentIndex});
}
class GoToAddTaskScreen extends MainActions{}


sealed class MainNavigation{}
class NavigateToAddTaskScreen extends MainNavigation{}