import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_flow/core/base/safeCall.dart';
import 'package:task_flow/core/const/database_and_model.dart';
import 'package:task_flow/data/datasource/contract/local_datasource.dart';
import 'package:task_flow/domain/models/task_dm.dart';

import '../../../core/base/results.dart';

@Injectable(as:LocalDatasource)
class LocalDatasourceImpl implements LocalDatasource{

  LocalDatasourceImpl(this._database);
  final Database _database;


  @override
  Future<Results<void>> addTask(TaskDm task) {
    return safeCall(()async{
     await _database.insert(
         ConstOfDatabase.tasksTable,
         task.toJson(),
         conflictAlgorithm: ConflictAlgorithm.ignore);
     return Success(message: "Task Added Successfully");
    });
  }

  @override
  Future<Results<List<TaskDm>>> getTasks() {
    return safeCall(()async{
      var response = await _database.query(ConstOfDatabase.tasksTable);
      List<TaskDm> tasks = response.map((element) {
        return TaskDm.fromJson(element);
      }).toList();

      return Success(data: tasks);
    });
  }

  @override
  Future<Results<void>> updateTask(TaskDm newTask) {
    return safeCall(()async{
      await _database.update(ConstOfDatabase.tasksTable, newTask.toJson(), where: '${ConstOfDatabase.idColumn} = ?' , whereArgs: [newTask.id]);
      return Success(message: "Task Updated Successfully");
    });
  }

  @override
  Future<Results<void>> deleteTask(int id) {
    return safeCall(() async{
      await _database.delete(ConstOfDatabase.tasksTable, where: '${ConstOfDatabase.idColumn} = ?', whereArgs: [id]);
      return Success(message: "Task Deleted Successfully");
    });
  }

}