import 'package:task_flow/core/base/results.dart';
import 'package:task_flow/domain/models/task_dm.dart';

abstract class LocalDatasource {
  Future<void> addTask(TaskDm task);
  Future<void> deleteTask(int id);
  Future<void> updateTask(TaskDm newTask);
  Future<Results<List<TaskDm>>> getTasks();
}