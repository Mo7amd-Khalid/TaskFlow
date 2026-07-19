import 'package:task_flow/core/base/results.dart';
import 'package:task_flow/domain/models/task_dm.dart';

abstract class LocalDatasource {
  Future<Results<void>> addTask(TaskDm task);
  Future<Results<void>> deleteTask(int id);
  Future<Results<void>> updateTask(TaskDm newTask);
  Future<Results<List<TaskDm>>> getTasks();
  Future<Results<TaskDm>> getTaskPerId(int id);
}