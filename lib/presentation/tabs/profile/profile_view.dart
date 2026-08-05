import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_flow/core/const/keywords.dart';
import 'package:task_flow/core/di/di.dart';
import 'package:task_flow/core/theme/app_colors.dart';
import 'package:task_flow/core/utils/context_func.dart';
import 'package:task_flow/core/utils/padding.dart';
import 'package:task_flow/presentation/main/cubit/main_cubit.dart';

import '../../../core/const/assets.dart';
import '../../main/cubit/main_contract.dart';
import '../../shared_widgets/change_name_dialog.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {

  final MainCubit _mainCubit = getIt();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<MainCubit, MainStates>(
        builder:(_,state) => Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: state.themeMode == ThemeMode.dark ? AppColors.backgroundDark : AppColors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              spacing: context.heightSize * 0.02,
              children: [
                Row(
                  spacing: context.widthSize * 0.02,
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: context.widthSize *0.13,
                          backgroundImage:state.profileImage.isEmpty? AssetImage(AppImages.logo) : FileImage(File(state.profileImage)),
                        ),

                        InkWell(
                          onTap: () {
                            _mainCubit.doAction(ChangeProfileImage(context: context));
                          },
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.white,
                                width: 2,
                              ),
                            ),
                            child: const Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 5,
                      children: [
                        Text(
                            state.name.isEmpty ? AppKeywords.noNameAdded : state.name,
                          style: context.textStyle.titleMedium!.copyWith(
                              color:
                              state.name.isEmpty?
                              AppColors.gray : state.themeMode == ThemeMode.dark ? AppColors.white :
                              AppColors.black),
                        ),
                        FilledButton(
                            onPressed: (){
                              showDialog(
                                context: context,
                                builder: (_) => ChangeNameDialog(),
                              );
                            },
                            child: Text(AppKeywords.updateName))
                      ],
                    )
                  ],
                ).allPadding(12),
                Divider(
                  endIndent: context.widthSize *0.03,
                  indent: context.widthSize * 0.03,
                  color: Colors.grey,
                  thickness: 1,
                ),
                // Dark Mode
                ListTile(
                  title: Text(
                    AppKeywords.darkMode,
                    style: context.textStyle.titleMedium,
                  ),
                  trailing:  Switch(
                    value: state.themeMode == ThemeMode.dark,
                    onChanged: (value) {
                      _mainCubit.doAction(ChangeThemeMode(
                        context: context,
                          mode: value ? ThemeMode.dark : ThemeMode.light
                      ));
                    },
                  ),
                ),

              ],
            ),
          ),
        ).allPadding(12),
      ),
    );
  }
}
