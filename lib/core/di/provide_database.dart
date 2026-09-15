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

    return await openDatabase(
      path,
      version: 2,
      onCreate: (Database db, int version) async {
        await db.execute(_createTasksTableSql);
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) async {
        if (oldVersion < 2) {
          await _migrateToV2(db);
        }
      },
    );
  }

  static const String _createTasksTableSql = """
      CREATE TABLE ${ConstOfDatabase.tasksTable}(
      ${ConstOfDatabase.idColumn} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${ConstOfDatabase.titleColumn} TEXT NOT NULL,
      ${ConstOfDatabase.descriptionColumn} TEXT NOT NULL,
      ${ConstOfDatabase.dueStartDateColumn} INTEGER NOT NULL,
      ${ConstOfDatabase.completedAtColumn} INTEGER,
      ${ConstOfDatabase.spentDurationColumn} INTEGER,
      ${ConstOfDatabase.plannedDurationColumn} INTEGER NOT NULL,
      ${ConstOfDatabase.priorityColumn} TEXT NOT NULL,
      ${ConstOfDatabase.categoryColumn} TEXT NOT NULL,
      ${ConstOfDatabase.statusColumn} TEXT NOT NULL,
      ${ConstOfDatabase.isDeletedColumn} INTEGER NOT NULL DEFAULT 0,
      ${ConstOfDatabase.reminderNotificationColumn} INTEGER NOT NULL,
      ${ConstOfDatabase.reminderTimeColumn} INTEGER
      )
      """;

  Future<void> _migrateToV2(Database db) async {
    const newTable = '${ConstOfDatabase.tasksTable}_new';
    await db.execute("""
      CREATE TABLE $newTable(
      ${ConstOfDatabase.idColumn} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${ConstOfDatabase.titleColumn} TEXT NOT NULL,
      ${ConstOfDatabase.descriptionColumn} TEXT NOT NULL,
      ${ConstOfDatabase.dueStartDateColumn} INTEGER NOT NULL,
      ${ConstOfDatabase.completedAtColumn} INTEGER,
      ${ConstOfDatabase.spentDurationColumn} INTEGER,
      ${ConstOfDatabase.plannedDurationColumn} INTEGER NOT NULL,
      ${ConstOfDatabase.priorityColumn} TEXT NOT NULL,
      ${ConstOfDatabase.categoryColumn} TEXT NOT NULL,
      ${ConstOfDatabase.statusColumn} TEXT NOT NULL,
      ${ConstOfDatabase.isDeletedColumn} INTEGER NOT NULL DEFAULT 0,
      ${ConstOfDatabase.reminderNotificationColumn} INTEGER NOT NULL,
      ${ConstOfDatabase.reminderTimeColumn} INTEGER
      )
      """);

    await db.execute("""
      INSERT INTO $newTable (
        ${ConstOfDatabase.idColumn},
        ${ConstOfDatabase.titleColumn},
        ${ConstOfDatabase.descriptionColumn},
        ${ConstOfDatabase.dueStartDateColumn},
        ${ConstOfDatabase.completedAtColumn},
        ${ConstOfDatabase.spentDurationColumn},
        ${ConstOfDatabase.plannedDurationColumn},
        ${ConstOfDatabase.priorityColumn},
        ${ConstOfDatabase.categoryColumn},
        ${ConstOfDatabase.statusColumn},
        ${ConstOfDatabase.isDeletedColumn},
        ${ConstOfDatabase.reminderNotificationColumn},
        ${ConstOfDatabase.reminderTimeColumn}
      )
      SELECT
        ${ConstOfDatabase.idColumn},
        ${ConstOfDatabase.titleColumn},
        ${ConstOfDatabase.descriptionColumn},
        ${ConstOfDatabase.dueStartDateColumn},
        ${ConstOfDatabase.completedAtColumn},
        ${ConstOfDatabase.spentDurationColumn},
        ${ConstOfDatabase.plannedDurationColumn},
        ${ConstOfDatabase.priorityColumn},
        ${ConstOfDatabase.categoryColumn},
        ${ConstOfDatabase.statusColumn},
        ${ConstOfDatabase.isDeletedColumn},
        ${ConstOfDatabase.reminderNotificationColumn},
        ${ConstOfDatabase.reminderTimeColumn}
      FROM ${ConstOfDatabase.tasksTable}
      """);

    await db.execute('DROP TABLE ${ConstOfDatabase.tasksTable}');
    await db.execute('ALTER TABLE $newTable RENAME TO ${ConstOfDatabase.tasksTable}');
  }
}
