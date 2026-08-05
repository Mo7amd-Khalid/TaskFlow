import 'package:flutter/material.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:task_flow/core/const/keywords.dart';
import 'package:task_flow/core/di/di.dart';
import 'package:task_flow/core/theme/app_colors.dart';
import 'package:task_flow/core/utils/context_func.dart';
import 'package:task_flow/core/utils/padding.dart';
import 'package:task_flow/core/utils/time_and_date.dart';
import 'package:task_flow/core/utils/white_spaces.dart';
import 'package:task_flow/domain/mapper/convert_text_to_date_time.dart';
import 'package:task_flow/domain/models/task_dm.dart';
import 'package:task_flow/presentation/add_or_edit_task/cubit/add_or_edit_task_contract.dart';
import 'package:task_flow/presentation/add_or_edit_task/cubit/add_or_edit_task_cubit.dart';
import 'package:task_flow/presentation/shared_widgets/app_dialogs.dart';
import 'package:task_flow/validator/data_validation.dart';

import '../../core/const/database_and_model.dart';
import '../../core/routes/routes.dart';

class AddOrEditTaskView extends StatefulWidget {
  const AddOrEditTaskView({super.key, this.task});
  final TaskDm? task;

  @override
  State<AddOrEditTaskView> createState() => _AddOrEditTaskViewState();
}

class _AddOrEditTaskViewState extends State<AddOrEditTaskView> {
  final AddOrEditTaskCubit _cubit = getIt();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _startDateController;
  late TextEditingController _endDateController;
  late TextEditingController _reminderNotificationController;
  late Category _selectedCategory;
  late Priority _selectedPriority;
  late bool reminderNotificationValue;
  late GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(
      text: widget.task?.title ?? "",
    );
    _descriptionController = TextEditingController(
      text: widget.task?.description ?? "",
    );

    _startDateController = TextEditingController(
      text:
      widget.task != null ?
      DateTime.fromMillisecondsSinceEpoch(widget.task!.dueStartDate).getFullDateAndTime() :
      DateTime.now().getFullDateAndTime(),
    );
    _endDateController = TextEditingController(
        text: widget.task != null ?
        DateTime.fromMillisecondsSinceEpoch(widget.task!.dueEndDate).getFullDateAndTime() :
        DateTime.now().getFullDateAndTime(),
    );
    _reminderNotificationController = TextEditingController(
      text: (widget.task != null &&  widget.task!.reminderTime != null)?
      DateTime.fromMillisecondsSinceEpoch(widget.task!.reminderTime!).getFullDateAndTime() :
      DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        DateTime.now().hour,
        DateTime.now().minute + 15,
      ).getFullDateAndTime()
    );
    reminderNotificationValue =
    (widget.task != null) ?
    widget.task!.reminderNotification :
    true;

    _selectedCategory = widget.task?.category ?? Category.work;
    _selectedPriority = widget.task?.priority ?? Priority.medium;
    _formKey = GlobalKey<FormState>();
    _cubit.navigation.listen((event) {
      if(!mounted) {
        return;
      }
      switch (event) {
        case ShowLoadingDialog():
          AppDialogs.loadingDialog(
            context: context,
            loadingMessage: AppKeywords.loading,
          );
        case ShowSuccessDialog():
          Navigator.pop(context);
          AppDialogs.actionDialog(
            context: context,
            title: "Success",
            content: event.message,
            posActionTitle: AppKeywords.ok,
            posAction: () {
              Navigator.pushNamedAndRemoveUntil(context, Routes.mainViews, (_) => false);
            },
          );
        case ShowErrorDialog():
          Navigator.pop(context);
          AppDialogs.actionDialog(
            context: context,
            title: "Error",
            content: event.message,
            posActionTitle: AppKeywords.tryAgain,
          );
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.task == null ? AppKeywords.addNewTask : AppKeywords.editTask),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  DateTime startDateAndTime = convertTextToDateTime(
                      dateText: _startDateController.text,
                  );
                  DateTime endDateAndTime = convertTextToDateTime(
                      dateText: _endDateController.text,
                  );
                  DateTime reminderDate = convertTextToDateTime(
                    dateText: _reminderNotificationController.text,
                  );
                  Duration planned =  endDateAndTime
                      .difference(
                    startDateAndTime,
                  );
                  if(widget.task == null)
                    {
                      TaskDm newTask = TaskDm(
                        title: _titleController.text,
                        description: _descriptionController.text,
                        dueStartDate: startDateAndTime.millisecondsSinceEpoch,
                        dueEndDate: endDateAndTime.millisecondsSinceEpoch,
                        plannedDuration: planned.inMilliseconds,
                        priority: _selectedPriority,
                        category: _selectedCategory,
                        status: AppKeywords.pending,
                        reminderNotification: reminderNotificationValue,
                        reminderTime: reminderDate.millisecondsSinceEpoch,
                      );
                      _cubit.doAction(AddNewTask(newTask: newTask));
                    }
                  else
                    {
                      TaskDm updatedTask = widget.task!.copyWith(
                        title: _titleController.text,
                        description: _descriptionController.text,
                        dueStartDate: startDateAndTime.millisecondsSinceEpoch,
                        dueEndDate: endDateAndTime.millisecondsSinceEpoch,
                        plannedDuration: planned.inMilliseconds,
                        priority: _selectedPriority,
                        category: _selectedCategory,
                        reminderNotification: reminderNotificationValue,
                        reminderTime: reminderDate.millisecondsSinceEpoch,
                      );
                      _cubit.doAction(UpdateTask(
                        updatedTask: updatedTask,
                      ));
                    }


                }
              },
              icon: Icon(Icons.check_rounded),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // title
              Text(AppKeywords.title, style: context.textStyle.titleMedium),
              TextFormField(
                validator: (value) => DataValidation.titleValidation(value!),
                controller: _titleController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(hintText: AppKeywords.titleHint),
              ),
              (context.heightSize * 0.02).verticalSpace,

              // description
              Text(
                AppKeywords.description,
                style: context.textStyle.titleMedium,
              ),
              TextFormField(
                validator: (value) =>
                    DataValidation.descriptionValidation(value!),
                controller: _descriptionController,
                maxLines: 4,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: AppKeywords.descriptionHint,
                ),
                onTap: () {},
              ),
              (context.heightSize * 0.02).verticalSpace,

              // start date
              Text(
                AppKeywords.plannedStart,
                style: context.textStyle.titleMedium,
              ),
              TextFormField(
                controller: _startDateController,
                readOnly: true,
                onTap: () async{
                  showOmniDateTimePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(DateTime.now().year + 5),
                    is24HourMode: false,
                  ).then((value){
                    if(value != null)
                    {
                      _startDateController.text = value.getFullDateAndTime();
                    }
                  });
                },
              ),
              (context.heightSize * 0.02).verticalSpace,

              // end date
              Text(
                  AppKeywords.plannedEnd,
                  style: context.textStyle.titleMedium
              ),
              TextFormField(
                controller: _endDateController,
                readOnly: true,
                onTap: () async{
                  showOmniDateTimePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(DateTime.now().year + 5),
                    is24HourMode: false,
                  ).then((value){
                    if(value != null)
                    {
                      _endDateController.text = value.getFullDateAndTime();
                    }
                  });
                },
                decoration: InputDecoration(
                  errorMaxLines: 3,
                ),
                validator: (value){
                  return DataValidation.endDateAndTimeValidation(
                    startDate: _startDateController.text,
                    endDate: value!,
                  );
                },
              ),
              (context.heightSize * 0.02).verticalSpace,

              Text(AppKeywords.priority, style: context.textStyle.titleMedium),
              Row(
                spacing: context.widthSize * 0.04,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _selectedPriority = Priority.low;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Priority.low.color.withAlpha(30),
                        ),
                        child: Row(
                          spacing: 5,
                          children: [
                            if (_selectedPriority == Priority.low)
                              CircleAvatar(
                                radius: 5,
                                backgroundColor: Priority.low.color,
                              ),
                            Text(
                              Priority.low.displayName,
                              style: context.textStyle.bodySmall!.copyWith(
                                fontWeight: FontWeight.w900,
                                color: Priority.low.color,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _selectedPriority = Priority.medium;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Priority.medium.color.withAlpha(30),
                        ),
                        child: Row(
                          spacing: 5,
                          children: [
                            if (_selectedPriority == Priority.medium)
                              CircleAvatar(
                                radius: 5,
                                backgroundColor: Priority.medium.color,
                              ),
                            Text(
                              Priority.medium.displayName,
                              style: context.textStyle.bodySmall!.copyWith(
                                fontWeight: FontWeight.w900,
                                color: Priority.medium.color,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _selectedPriority = Priority.high;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Priority.high.color.withAlpha(30),
                        ),
                        child: Row(
                          spacing: 5,
                          children: [
                            if (_selectedPriority == Priority.high)
                              CircleAvatar(
                                radius: 5,
                                backgroundColor: Priority.high.color,
                              ),
                            Text(
                              Priority.high.displayName,
                              style: context.textStyle.bodySmall!.copyWith(
                                fontWeight: FontWeight.w900,
                                color: Priority.high.color,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              (context.heightSize * 0.02).verticalSpace,
              Text(AppKeywords.category, style: context.textStyle.titleMedium),
              DropdownButtonFormField<Category>(
                initialValue: _selectedCategory,
                items: Category.values.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 5,
                          backgroundColor: category.color,
                        ),
                        const SizedBox(width: 12),
                        Text(category.displayName),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  _selectedCategory = value!;
                },
              ),


              ListTile(
                title: Text(
                    AppKeywords.reminderNotification,
                    style: context.textStyle.titleMedium
                ),
                subtitle: widget.task != null ? null : Row(
                  spacing: 5,
                  children: [
                    Icon(Icons.info_outline_rounded,color: AppColors.gray, size: context.widthSize * 0.05,),
                    Expanded(
                      child: Text(
                        AppKeywords.reminderNotificationMessage,
                          style: context.textStyle.bodySmall!.copyWith(
                              color: Colors.grey
                          )
                      ),
                    ),
                  ],
                ),
                trailing: Switch(
                  value: reminderNotificationValue,
                  onChanged: (value) {
                    setState(() {
                      reminderNotificationValue = value;
                    });
                  },
                ),
              ),
              if(reminderNotificationValue)
                TextFormField(
                  controller: _reminderNotificationController,
                  readOnly: true,
                  validator: (value){
                    return DataValidation.reminderNotificationValidation(
                        reminderDateText: value!,startDateText: _startDateController.text);
                  },
                  onTap: () async{
                    showOmniDateTimePicker(
                      context: context,
                      initialDate: widget.task != null ? DateTime.fromMillisecondsSinceEpoch(widget.task!.reminderTime!) : DateTime(
                        DateTime.now().year,
                        DateTime.now().month,
                        DateTime.now().day,
                        DateTime.now().hour,
                        DateTime.now().minute + 15,
                      ),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(DateTime.now().year + 5),
                      is24HourMode: false,
                    ).then((value){
                      if(value != null)
                        {
                          _reminderNotificationController.text = value.getFullDateAndTime();
                        }
                    });
                  },
                )
            ],
          ).allPadding(12),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
    _titleController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
  }
}
