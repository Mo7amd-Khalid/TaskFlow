import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_flow/core/base/safeCall.dart';
import 'package:task_flow/core/const/database_and_model.dart';
import 'package:task_flow/data/datasource/contract/local_datasource.dart';
import 'package:task_flow/domain/models/task_dm.dart';

import '../../../core/base/results.dart';

@Injectable(as:LocalDatasource)
class LocalDatasourceImpl implements LocalDatasource{

  LocalDatasourceImpl(this._database, this._sharedPreferences);
  final Database _database;
  final SharedPreferences _sharedPreferences;


  @override
  Future<Results<int>> addTask(TaskDm task) {
    return safeCall(()async{
     int taskId = await _database.insert(
         ConstOfDatabase.tasksTable,
         task.toJson(),
         conflictAlgorithm: ConflictAlgorithm.ignore);
     return Success(data: taskId, message: "Task Added Successfully");
    });
  }

  @override
  Future<Results<List<TaskDm>>> getTasksWithoutDeleted() {
    return safeCall(()async{
      var response = await _database.query(ConstOfDatabase.tasksTable, where: '${ConstOfDatabase.isDeletedColumn} = ?', whereArgs: [0]);
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

  @override
  Future<Results<TaskDm>> getTaskPerId(int id) {
    return safeCall(()async{
      var response = await _database.query(
          ConstOfDatabase.tasksTable,
          where: '${ConstOfDatabase.idColumn} = ?',
          whereArgs: [id]);
      if(response.isEmpty)
        {
          return Failure(exception: Exception("No Item Found"), message: "No Task Found");
        }
      else
        {
          TaskDm task = TaskDm.fromJson(response.first);
          return Success(data: task);
        }

    });
  }

  @override
  Future<Results<List<TaskDm>>> getAllTasks() {
    return safeCall(()async{
      var response = await _database.query(ConstOfDatabase.tasksTable);
      List<TaskDm> tasks = response.map((element) {
        return TaskDm.fromJson(element);
      }).toList();
      return Success(data: tasks);
    });
  }

  Future<Results<void>> saveDataInSharedPreferences(BuildContext context,
      String key,
      dynamic value,) async {
    return safeCall(() async {
      if (value is String ||
          value is int ||
          value is bool ||
          value is double ||
          value is List<String>) {
        if (value is String) {
          await _sharedPreferences.setString(key, value);
        } else if (value is int) {
          await _sharedPreferences.setInt(key, value);
        } else if (value is bool) {
          await _sharedPreferences.setBool(key, value);
        } else if (value is double) {
          await _sharedPreferences.setDouble(key, value);
        } else if (value is List<String>) {
          await _sharedPreferences.setStringList(key, value);
        }
        return Success();
      } else {
        return Failure(
          exception: Exception(), message: 'SharedPreferences Error',
        );
      }
    });
  }

}