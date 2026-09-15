import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_flow/core/base/base_cubit.dart';
import 'package:task_flow/core/const/sharedPreferencesKeys.dart';
import 'package:task_flow/domain/repository/repository.dart';
import 'package:task_flow/presentation/main/cubit/main_contract.dart';


@singleton
class MainCubit extends BaseCubit<MainStates, MainActions, MainNavigation>{
  MainCubit(this._repo, this._preferences) : super(MainStates());

  final Repository _repo;
  final SharedPreferences _preferences;

  @override
  Future<void> doAction(MainActions action) async{
    switch(action) {
      case ChangePage():
        changePage(action.currentIndex);
      case GoToAddTaskScreen():
        goToAddTaskScreen();
      case ChangeThemeMode():
        _changeThemeMode(action.context, action.mode);
      case GetAppData():
        _getAppData();
      case ChangeProfileImage():
        _changeProfileImage(action.context);
      case ChangeName():
        _changeName(action.context, action.name);
    }
  }

  void changePage(int currentIndex) {
    if(currentIndex != 2)
      {
        emit(state.copyWith(currentPageIndex: currentIndex));
      }
  }

  void goToAddTaskScreen() {
    emitNavigation(NavigateToAddTaskScreen());
  }

  void _changeThemeMode(BuildContext context,ThemeMode mode) async{
    await _repo.saveDataInSharedPreferences(context, SharedPreferencesKeys.themeMode, mode == ThemeMode.dark);
    emit(state.copyWith(themeMode: mode));
  }

  void _getAppData(){
    var getThemeMode = _preferences.getBool(SharedPreferencesKeys.themeMode);
    var getImageProfile = _preferences.getString(SharedPreferencesKeys.profileImage);
    var getName = _preferences.getString(SharedPreferencesKeys.name);


    if(getThemeMode == null )
      {
        if(WidgetsBinding.instance.platformDispatcher.platformBrightness == Brightness.dark)
          {
            emit(state.copyWith(themeMode: ThemeMode.dark));
          }
        else
          {
            emit(state.copyWith(themeMode: ThemeMode.light));
          }
      }
    else if(getThemeMode == false)
    {
      emit(state.copyWith(themeMode: ThemeMode.light));
    }
    else
      {
        emit(state.copyWith(themeMode: ThemeMode.dark));
      }
    emit(state.copyWith(profileImage: getImageProfile ?? "", name: getName ?? ""));
  }

  void _changeProfileImage(BuildContext context) async{
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if(image != null)
      {
        await _repo.saveDataInSharedPreferences(context, SharedPreferencesKeys.profileImage, image.path);
        emit(state.copyWith(profileImage: image.path));
      }
  }

  void _changeName(BuildContext context, String name) async{
    await _repo.saveDataInSharedPreferences(context, SharedPreferencesKeys.name, name );
    emit(state.copyWith(name: name));
  }

}