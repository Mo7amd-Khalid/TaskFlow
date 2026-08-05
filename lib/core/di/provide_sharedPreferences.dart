import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class ProvideSharedPreferences {

  @preResolve
  Future<SharedPreferences> provideShared() async=> await SharedPreferences.getInstance();
}