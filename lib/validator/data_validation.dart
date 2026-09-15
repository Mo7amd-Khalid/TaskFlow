

import 'package:task_flow/core/const/keywords.dart';
import 'package:task_flow/domain/mapper/convert_text_to_date_time.dart';

class DataValidation{
  static String? titleValidation(String value){
    if (value.isEmpty) {
      return AppKeywords.titleRequired;
    }
    return null;
  }

  static String? nameValidation(String value){
    if (value.isEmpty) {
      return AppKeywords.titleRequired;
    }
    return null;
  }

  static String? descriptionValidation(String value){
    if (value.isEmpty) {
      return AppKeywords.descriptionRequired;
    }
    return null;
  }


  static String? reminderNotificationValidation({
    required String reminderDateText,
  }) {
    final reminderDate = convertTextToDateTime(dateText: reminderDateText);

    // Reminder must be in the future.
    if (!reminderDate.isAfter(DateTime.now())) {
      return "Reminder date must be in the future.";
    }

    return null;
  }

}