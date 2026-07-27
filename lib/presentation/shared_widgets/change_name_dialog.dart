import 'package:flutter/material.dart';
import 'package:task_flow/core/const/keywords.dart';
import 'package:task_flow/core/di/di.dart';
import 'package:task_flow/presentation/main/cubit/main_contract.dart';
import 'package:task_flow/presentation/main/cubit/main_cubit.dart';

import '../../validator/data_validation.dart';

class ChangeNameDialog extends StatelessWidget {
  ChangeNameDialog({super.key});

  final TextEditingController controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final MainCubit _mainCubit = getIt();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: AlertDialog(
        title: Text(AppKeywords.updateName),
        content: TextFormField(
          validator: (value) =>
              DataValidation.nameValidation(value!),
          controller: controller,
          decoration:  InputDecoration(
            hintText: AppKeywords.enterYourName,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppKeywords.cancel),
          ),
          FilledButton(
            onPressed: () {
              if(_formKey.currentState!.validate())
                {
                  _mainCubit.doAction(ChangeName(context: context, name: controller.text));
                  Navigator.pop(context);
                }
            },
            child: Text(AppKeywords.update),
          ),
        ],
      ),
    );
  }
}