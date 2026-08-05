import 'package:injectable/injectable.dart';
import 'package:task_flow/core/base/base_cubit.dart';
import 'package:task_flow/core/base/results.dart';
import 'package:task_flow/core/const/keywords.dart';
import 'package:task_flow/domain/models/notification_model.dart';
import 'package:task_flow/domain/models/task_dm.dart';
import 'package:task_flow/domain/repository/repository.dart';
import 'package:task_flow/services/local_notification_service.dart';

import 'add_or_edit_task_contract.dart';

@injectable
class AddOrEditTaskCubit
    extends
        BaseCubit<
          AddOrEditTaskState,
          AddOrEditTaskActions,
          AddOrEditTaskNavigation
        > {
  AddOrEditTaskCubit(this._repo) : super(AddOrEditTaskState());

  final Repository _repo;

  @override
  Future<void> doAction(AddOrEditTaskActions action) async {
    switch (action) {
      case AddNewTask():
        addNewTask(action.newTask);
      case UpdateTask():
        _updateTask(action.updatedTask);
    }
  }

  void addNewTask(TaskDm newTask) async {
    emitNavigation(ShowLoadingDialog());
    var response = await _repo.addTask(newTask);
    switch (response) {
      case Success<int>():
        {
          if(newTask.reminderNotification)
            {
              DateTime reminderDate = DateTime.fromMillisecondsSinceEpoch(newTask.reminderTime!);
              NotificationModel notification = NotificationModel(
                  notificationId: response.data!,
                  channelID: AppKeywords.channelIdForReminder,
                  channelName: AppKeywords.channelNameForReminder,
                  title: newTask.title,
                  body: AppKeywords.bodyOfReminderNotification,
                  payload: AppKeywords.payloadForReminderNotification);
              LocalNotificationService.scheduleNotification(
                  notification, reminderDate);
            }

          emitNavigation(ShowSuccessDialog(message: response.message!));
        }
      case Failure<int>():
        emitNavigation(ShowErrorDialog(message: response.message!));
    }
  }

  void _updateTask(TaskDm updatedTask) async {
    emitNavigation(ShowLoadingDialog());
    if ((updatedTask.plannedDuration - (updatedTask.spentDuration ?? 0)).isNegative) {
      emitNavigation(
        ShowErrorDialog(
          message:
              "If you need to update the planned date of this task to this, You already completed this task.",
        ),
      );
    }
    else
      {
        var response = await _repo.updateTask(updatedTask);
        switch (response) {
          case Success<void>():
            LocalNotificationService.cancelNotification(updatedTask.id!);
            DateTime reminderDate = DateTime.fromMillisecondsSinceEpoch(updatedTask.reminderTime!);
            NotificationModel notification = NotificationModel(
                notificationId: updatedTask.id!,
                channelID: AppKeywords.channelIdForReminder,
                channelName: AppKeywords.channelNameForReminder,
                title: updatedTask.title,
                body: AppKeywords.bodyOfReminderNotification,
                payload: AppKeywords.payloadForReminderNotification);
            LocalNotificationService.scheduleNotification(
                notification, reminderDate);
            emitNavigation(ShowSuccessDialog(message: response.message!));
          case Failure<void>():
            emitNavigation(ShowErrorDialog(message: response.message!));
        }
      }

  }
}
