import 'package:injectable/injectable.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_flow/core/const/database_and_model.dart';

@module
abstract class ProvideDatabase {

  @preResolve
  Future<Database> get database async => _createDatabase();

  Future<Database> _createDatabase() async {
    String path = join(await getDatabasesPath(), 'TaskFlow.db');

    return await openDatabase(path, version: 1, onCreate: (Database db, int version)async{
      await db.execute("""
      CREATE TABLE ${ConstOfDatabase.tasksTable}(
      ${ConstOfDatabase.idColumn} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${ConstOfDatabase.titleColumn} TEXT NOT NULL,
      ${ConstOfDatabase.descriptionColumn} TEXT NOT NULL,
      ${ConstOfDatabase.dueDateColumn} INTEGER NOT NULL,
      ${ConstOfDatabase.priorityColumn} TEXT NOT NULL,
      ${ConstOfDatabase.categoryColumn} TEXT NOT NULL,
      ${ConstOfDatabase.statusColumn} TEXT NOT NULL
      )
      """);
    });
  }
}