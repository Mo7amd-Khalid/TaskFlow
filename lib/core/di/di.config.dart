// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;
import 'package:sqflite/sqflite.dart' as _i779;

import '../../data/datasource/contract/local_datasource.dart' as _i486;
import '../../data/datasource/impl/local_datasource_impl.dart' as _i23;
import '../../data/repo_impl/repo_impl.dart' as _i212;
import '../../domain/repository/repository.dart' as _i131;
import '../../presentation/add_task/cubit/add_task_cubit.dart' as _i981;
import '../../presentation/main/cubit/main_cubit.dart' as _i671;
import '../../presentation/onboarding/cubit/onboarding_cubit.dart' as _i657;
import '../../presentation/tabs/calendar/cubit/calendar_cubit.dart' as _i355;
import '../../presentation/tabs/home/cubit/home_cubit.dart' as _i114;
import '../../presentation/tabs/statistics/cubit/statistics_cubit.dart'
    as _i268;
import '../../presentation/task_details/cubit/task_details_cubit.dart' as _i826;
import '../../presentation/timer/cubit/timer_cubit.dart' as _i438;
import 'provide_database.dart' as _i883;
import 'provide_sharedPreferences.dart' as _i1041;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final provideDatabase = _$ProvideDatabase();
    final provideSharedPreferences = _$ProvideSharedPreferences();
    await gh.factoryAsync<_i779.Database>(
      () => provideDatabase.database,
      preResolve: true,
    );
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => provideSharedPreferences.provideShared(),
      preResolve: true,
    );
    gh.factory<_i671.MainCubit>(() => _i671.MainCubit());
    gh.factory<_i657.OnboardingCubit>(
      () => _i657.OnboardingCubit(gh<_i460.SharedPreferences>()),
    );
    gh.factory<_i486.LocalDatasource>(
      () => _i23.LocalDatasourceImpl(gh<_i779.Database>()),
    );
    gh.factory<_i131.Repository>(
      () => _i212.RepoImpl(gh<_i486.LocalDatasource>()),
    );
    gh.singleton<_i114.HomeCubit>(
      () => _i114.HomeCubit(gh<_i131.Repository>()),
    );
    gh.factory<_i981.AddTaskCubit>(
      () => _i981.AddTaskCubit(gh<_i131.Repository>()),
    );
    gh.factory<_i826.TaskDetailsCubit>(
      () => _i826.TaskDetailsCubit(gh<_i131.Repository>()),
    );
    gh.factory<_i438.TimerCubit>(
      () => _i438.TimerCubit(gh<_i131.Repository>()),
    );
    gh.factory<_i355.CalendarCubit>(
      () => _i355.CalendarCubit(gh<_i114.HomeCubit>()),
    );
    gh.factory<_i268.StatisticsCubit>(
      () => _i268.StatisticsCubit(gh<_i114.HomeCubit>()),
    );
    return this;
  }
}

class _$ProvideDatabase extends _i883.ProvideDatabase {}

class _$ProvideSharedPreferences extends _i1041.ProvideSharedPreferences {}
