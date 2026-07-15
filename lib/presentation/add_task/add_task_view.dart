import 'package:flutter/material.dart';
import 'package:task_flow/core/const/keywords.dart';
import 'package:task_flow/core/di/di.dart';
import 'package:task_flow/core/routes/routes.dart';
import 'package:task_flow/core/theme/app_colors.dart';
import 'package:task_flow/core/utils/context_func.dart';
import 'package:task_flow/core/utils/padding.dart';
import 'package:task_flow/core/utils/time_and_date.dart';
import 'package:task_flow/core/utils/white_spaces.dart';
import 'package:task_flow/domain/mapper/convert_text_to_date_time.dart';
import 'package:task_flow/domain/models/task_dm.dart';
import 'package:task_flow/presentation/add_task/cubit/add_task_contract.dart';
import 'package:task_flow/presentation/add_task/cubit/add_task_cubit.dart';
import 'package:task_flow/presentation/shared_widgets/app_dialogs.dart';
import 'package:task_flow/validator/data_validation.dart';

import '../../core/const/database_and_model.dart';

class AddTaskView extends StatefulWidget {
  const AddTaskView({super.key});

  @override
  State<AddTaskView> createState() => _AddTaskViewState();
}

class _AddTaskViewState extends State<AddTaskView> {
  final AddTaskCubit _cubit = getIt();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _startDateController;
  late TextEditingController _startTimeController;
  late TextEditingController _endDateController;
  late TextEditingController _endTimeController;
  late Category _selectedCategory;
  late Priority _selectedPriority;
  late GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();

    _startDateController = TextEditingController(
      text: DateTime.now().getDate(),
    );
    _startTimeController = TextEditingController(
      text: DateTime.now().getTime(),
    );
    _endDateController = TextEditingController(
        text: DateTime.now().getDate()
    );
    _endTimeController = TextEditingController(
        text: DateTime.now().getTime()
    );

    _selectedCategory = Category.work;
    _selectedPriority = Priority.medium;
    _formKey = GlobalKey<FormState>();
    _cubit.navigation.listen((event) {
      switch (event) {
        case ShowLoadingDialog():
          AppDialogs.loadingDialog(
            context: context,
            loadingMessage: AppKeywords.loading,
          );
        case ShowSuccessDialog():
          AppDialogs.actionDialog(
            context: context,
            title: "Success",
            content: event.message,
            posActionTitle: AppKeywords.ok,
            posAction: () {
              Navigator.pushReplacementNamed(context, Routes.mainViews);
            },
          );
        case ShowErrorDialog():
          AppDialogs.actionDialog(
            context: context,
            title: "Error",
            content: event.message,
            posActionTitle: AppKeywords.tryAgain,
            posAction: () {
              Navigator.pop(context);
            },
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
          title: Text(AppKeywords.addNewTask),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {

                if (_formKey.currentState!.validate()) {
                  DateTime startDateAndTime = convertTextToDateTime(
                      dateText: _startDateController.text,
                      timeText: _startTimeController.text
                  );
                  DateTime endDateAndTime = convertTextToDateTime(
                      dateText: _endDateController.text,
                      timeText: _endTimeController.text
                  );
                  TaskDm newTask = TaskDm(
                    title: _titleController.text,
                    description: _descriptionController.text,
                    dueStartDate: startDateAndTime.millisecondsSinceEpoch,
                    dueEndDate: endDateAndTime.millisecondsSinceEpoch,
                    priority: _selectedPriority,
                    category: _selectedCategory,
                    status: AppKeywords.pending,
                  );
                  _cubit.doAction(AddNewTask(newTask: newTask));
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
                AppKeywords.startDateAndTime,
                style: context.textStyle.titleMedium,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      onTap: () {
                        showDatePicker(
                          context: context,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(DateTime.now().year + 5),
                        ).then((value) {
                          if (value != null) {
                            _startDateController.text = value.getDate();
                          }
                        });
                      },
                      readOnly: true,
                      controller: _startDateController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.date_range_rounded,
                          color: AppColors.black,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      onTap: () {
                        showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        ).then((value) {
                          if (value != null) {
                            _startTimeController.text = value.format(context);
                          }
                        });
                      },
                      readOnly: true,
                      controller: _startTimeController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.date_range_rounded,
                          color: AppColors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              (context.heightSize * 0.02).verticalSpace,

              // end date
              Text(
                  AppKeywords.endDateAndTime,
                  style: context.textStyle.titleMedium
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      validator: (value){
                        return DataValidation.endDateAndTimeValidation(
                          startDate: _startDateController.text,
                          startTime: _startTimeController.text,
                          endDate: _endDateController.text,
                          endTime: _endTimeController.text
                        );
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onTap: () {
                        showDatePicker(
                          context: context,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(DateTime.now().year + 5),
                        ).then((value) {
                          if (value != null) {
                            _endDateController.text = value.getDate();
                          }
                        });
                      },
                      readOnly: true,
                      controller: _endDateController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        errorMaxLines: 3,
                        prefixIcon: Icon(
                          Icons.date_range_rounded,
                          color: AppColors.black,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      onTap: () {
                        showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        ).then((value) {
                          if (value != null) {
                            _endTimeController.text = value.format(context);
                          }
                        });
                      },
                      readOnly: true,
                      controller: _endTimeController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.date_range_rounded,
                          color: AppColors.black,
                        ),
                      ),
                    ),
                  ),
                ],
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
    _startTimeController.dispose();
    _endDateController.dispose();
    _endTimeController.dispose();
  }
}

/*
*
*   final int? id; dn
  final String title;  dn
  final String description;  dn
  final int dueDate; dn
  final Priority priority;  dn
  final Category category;  dn
* */
