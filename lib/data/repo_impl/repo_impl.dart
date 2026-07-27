import 'package:flutter/src/widgets/framework.dart';
import 'package:injectable/injectable.dart';
import 'package:task_flow/core/base/results.dart';
import 'package:task_flow/data/datasource/contract/local_datasource.dart';
import 'package:task_flow/domain/models/task_dm.dart';
import 'package:task_flow/domain/repository/repository.dart';

@Injectable(as: Repository)
class RepoImpl implements Repository{

  RepoImpl(this._localDatasource);
  final LocalDatasource _localDatasource;

  @override
  Future<Results<void>> addTask(TaskDm task) async{
    var response = await _localDatasource.addTask(task);
    switch(response) {
      case Success<void>():
        return Success(message: response.message);
      case Failure<void>():
        return Failure(exception: response.exception, message: response.message);
    }
  }

  @override
  Future<Results<void>> deleteTask(int id) async{
    var response = await _localDatasource.deleteTask(id);
    switch(response) {
      case Success<void>():
        return Success(message: response.message);
      case Failure<void>():
        return Failure(exception: response.exception, message: response.message);
    }
  }

  @override
  Future<Results<List<TaskDm>>> getTasksWithoutDeleted() async{
    var response = await _localDatasource.getTasksWithoutDeleted();
    switch(response) {
      case Success<List<TaskDm>>():
        //sort from newest to oldest
        response.data!.sort((a, b) => b.dueStartDate.compareTo(a.dueStartDate));
        return Success(data:response.data, message: response.message);
      case Failure<List<TaskDm>>():
        return Failure(exception: response.exception, message: response.message);
    }
  }

  @override
  Future<Results<void>> updateTask(TaskDm newTask) async{
    var response = await _localDatasource.updateTask(newTask);
    switch(response) {
      case Success<void>():
        return Success(message: response.message);
      case Failure<void>():
        return Failure(exception: response.exception, message: response.message);
    }

  }

  @override
  Future<Results<TaskDm>> getTaskPerId(int id) async{
    var response = await _localDatasource.getTaskPerId(id);
    switch(response) {
      case Success<TaskDm>():
        return Success(data: response.data, message: response.message);
      case Failure<TaskDm>():
        return Failure(exception: response.exception, message: response.message);
    }
  }

  @override
  Future<Results<List<TaskDm>>> getAllTasks() async{
    var response = await _localDatasource.getAllTasks();
    switch(response) {
      case Success<List<TaskDm>>():
       return Success(data:response.data, message: response.message);
      case Failure<List<TaskDm>>():
        return Failure(exception: response.exception, message: response.message);
    }
  }

  @override
  Future<Results<void>> saveDataInSharedPreferences(BuildContext context, String key, value) async{
    var response = await _localDatasource.saveDataInSharedPreferences(context, key, value);
    switch(response) {
      case Success<void>():
        return Success();
      case Failure<void>():
        return Failure(exception: response.exception, message: response.message);
    }
  }

}