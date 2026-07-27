import 'package:flutter/material.dart';
import 'package:task_flow/core/base/results.dart';

import '../models/task_dm.dart';

abstract class Repository {
  Future<Results<void>> addTask(TaskDm task);
  Future<Results<void>> deleteTask(int id);
  Future<Results<void>> updateTask(TaskDm newTask);
  Future<Results<List<TaskDm>>> getTasksWithoutDeleted();
  Future<Results<List<TaskDm>>> getAllTasks();
  Future<Results<TaskDm>> getTaskPerId(int id);

  Future<Results<void>> saveDataInSharedPreferences(BuildContext context, String key, dynamic value);
}