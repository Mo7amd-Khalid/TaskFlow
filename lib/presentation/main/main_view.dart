import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_flow/core/const/keywords.dart';
import 'package:task_flow/core/di/di.dart';
import 'package:task_flow/core/routes/routes.dart';
import 'package:task_flow/presentation/main/cubit/main_contract.dart';
import 'package:task_flow/presentation/main/cubit/main_cubit.dart';

import '../../core/theme/app_colors.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {

  final MainCubit _cubit = getIt();

  @override
  void initState() {
    super.initState();
    _cubit.navigation.listen((event){
      switch(event) {
        case NavigateToAddTaskScreen():
          Navigator.pushNamed(context, Routes.addOrEditTaskViews);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: BlocBuilder<MainCubit, MainStates>(
        builder:(_, state) => Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: (){
              _cubit.doAction(GoToAddTaskScreen());
            },isExtended: true,
            shape:  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(500),
                side: BorderSide(
                  color: AppColors.white,
                  width: 4,
                )
            ),
            child: Icon(Icons.add),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          body: state.screens[state.currentPageIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (int index){
              _cubit.doAction(ChangePage(currentIndex: index));
            },
            currentIndex: state.currentPageIndex,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: AppKeywords.home),
              BottomNavigationBarItem(icon: Icon(Icons.calendar_month_rounded), label: AppKeywords.calender),
              BottomNavigationBarItem(icon: Icon(Icons.home,color: Colors.transparent,), label: "",),
              BottomNavigationBarItem(icon: Icon(Icons.bar_chart_outlined), label: AppKeywords.statistics),
              BottomNavigationBarItem(icon: Icon(Icons.person_2_outlined), label: AppKeywords.profile),
            ],
          ),
        ),
      ),
    );
  }
}
