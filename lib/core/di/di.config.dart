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
    gh.factory<_i486.LocalDatasource>(
      () => _i23.LocalDatasourceImpl(gh<_i779.Database>()),
    );
    return this;
  }
}

class _$ProvideDatabase extends _i883.ProvideDatabase {}

class _$ProvideSharedPreferences extends _i1041.ProvideSharedPreferences {}
