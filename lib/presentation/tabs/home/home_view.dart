import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_flow/core/const/keywords.dart';
import 'package:task_flow/core/di/di.dart';
import 'package:task_flow/core/routes/routes.dart';
import 'package:task_flow/core/theme/app_colors.dart';
import 'package:task_flow/core/utils/context_func.dart';
import 'package:task_flow/core/utils/padding.dart';
import 'package:task_flow/core/utils/resources.dart';
import 'package:task_flow/presentation/main/cubit/main_cubit.dart';
import 'package:task_flow/presentation/tabs/home/cubit/home_contract.dart';
import 'package:task_flow/presentation/tabs/home/cubit/home_cubit.dart';

import '../../main/cubit/main_contract.dart';
import '../../shared_widgets/shimmer_task_item.dart';
import '../../shared_widgets/task_item.dart';
import '../../shared_widgets/today_overview.dart';
import '../../shared_widgets/today_overview_shimmer.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeCubit _cubit = getIt();
  final MainCubit _mainCubit = getIt();
  late final StreamSubscription _navigationSubscription;


  @override
  void initState() {
    super.initState();
    _cubit.doAction(GetTasks());
    _navigationSubscription = _cubit.navigation.listen((event){
      if(!mounted) {
        return;
      }
      switch(event) {
        case NavigateToTaskDetailsScreen():
          Navigator.pushNamed(context, Routes.taskDetailsViews, arguments: event.task.id);
        case ShowSuccessDialog():
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                duration: Duration(seconds: 2),
                behavior: SnackBarBehavior.floating,
                backgroundColor: AppColors.success.withAlpha(80),
                content: Text(AppKeywords.taskDeletedSuccessfully),
              ),
            );
        case ShowErrorDialog():
          ScaffoldMessenger.of(context)..hideCurrentSnackBar()
              ..showSnackBar(
            SnackBar(
                duration: Duration(seconds: 2),
                behavior: SnackBarBehavior.floating,
                backgroundColor: AppColors.success.withAlpha(80),
                content: Text('Something went wrong')
            ),
          );
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: BlocBuilder<HomeCubit, HomeStates>(
        builder: (_,state) => SafeArea(
          child: Column(
            spacing: context.heightSize * 0.03,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                spacing: 5,
                children: [
                  if(_mainCubit.state.profileImage.isNotEmpty)
                    CircleAvatar(
                    radius: context.widthSize *0.05,
                    backgroundImage:FileImage(File(_mainCubit.state.profileImage)),
                  ),
                  Text(
                    "Hi ${_mainCubit.state.name.isEmpty ? "" : _mainCubit.state.name.split(" ")[0]}, 👋",
                    style: context.textStyle.headlineSmall,
                  ),
                ],
              ),
              Text(
                AppKeywords.todayOverview,
                style: context.textStyle.titleMedium!.copyWith(fontWeight: FontWeight.bold),
              ),
              switch(state.tasks.state) {
                States.initial || States.loading => TodayOverviewShimmer(),

                States.success => CountOfTasks(countOfAllTasks: state.tasks.data!.length, countOfCompleteTasks: state.completedTasks, countOfPendingTasks: state.pendingTasks,),

                States.failure => Center(child: Text(state.tasks.message!)),
              },
              Text(
                AppKeywords.tasks,
                style: context.textStyle.titleMedium!.copyWith(fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: BlocBuilder<MainCubit, MainStates>(
                  builder: (_, mainState) => Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: mainState.themeMode == ThemeMode.dark ? AppColors.backgroundDark : AppColors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: BoxBorder.all(
                        color: AppColors.outlineLight,
                        width: 2
                      )
                    ),
                    child: switch(state.tasks.state) {
                      States.initial || States.loading => ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemCount: 6,
                        itemBuilder: (_, __) => const TaskItemShimmer(),
                        separatorBuilder: (_, __) => Divider(
                          height: context.heightSize * 0.03,
                          thickness: 1,
                        ),
                      ),
                      States.success => state.tasks.data!.isNotEmpty ?
                      ListView.separated(
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (_, index) => Dismissible(
                            direction: DismissDirection.endToStart,
                            key: ValueKey(state.tasks.data![index].id),
                            background: Container(
                              color: Colors.transparent,
                            ),
                            secondaryBackground: Container(
                              color: Colors.red,
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: const Icon(Icons.delete, color: Colors.white),
                            ),

                            confirmDismiss: (direction) async {
                              if (direction == DismissDirection.endToStart) {
                                return await showDialog<bool>(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                    title: const Text(AppKeywords.deleteTask),
                                    content: const Text(AppKeywords.areYouSure),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context, false),
                                        child: const Text(AppKeywords.cancel),
                                      ),
                                      FilledButton(
                                        onPressed: () {
                                          Navigator.pop(context, true);
                                          _cubit.doAction(DeleteTask(state.tasks.data![index]));
                                        },
                                        child: const Text(AppKeywords.delete),
                                      ),
                                    ],
                                  ),
                                );
                              }
                              return true;
                            },
                            child: TaskItem(
                              onTab: (){
                                _cubit.doAction(GoToTaskDetailsScreen(state.tasks.data![index]));
                              },
                              taskItem: state.tasks.data![index],
                            ),
                          ),
                          separatorBuilder: (_,_) => Divider(
                            height: context.heightSize *0.03,
                            thickness: 1,
                          ),
                          itemCount: state.tasks.data!.length) :
                      Center(
                        child: Text(AppKeywords.emptyList,),
                      ),
                      States.failure => Center(child: Text(state.tasks.message!),),
                    },
                  ),
                ),
              )
            ],
          ).allPadding(12),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _navigationSubscription.cancel();
    super.dispose();
  }
}
