import 'package:task_flow/core/base/results.dart';

import '../models/task_dm.dart';

abstract class Repository {
  Future<Results<void>> addTask(TaskDm task);
  Future<Results<void>> deleteTask(int id);
  Future<Results<void>> updateTask(TaskDm newTask);
  Future<Results<List<TaskDm>>> getTasks();
}