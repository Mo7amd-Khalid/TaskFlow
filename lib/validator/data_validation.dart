

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

  static String? endDateAndTimeValidation({
        required String startDate,
        required String endDate,}){
    DateTime startDateTime = convertTextToDateTime(dateText: startDate);
    DateTime endDateTime = convertTextToDateTime(dateText: endDate);
    if (endDateTime.isBefore(startDateTime) || endDateTime.isAtSameMomentAs(startDateTime)){
      return AppKeywords.endDateInvalid;
    }
    return null;
  }

  static String? reminderNotificationValidation({
    required String reminderDateText,
    required String startDateText,
  }) {
    final reminderDate = convertTextToDateTime(dateText: reminderDateText);
    final startDate = convertTextToDateTime(dateText: startDateText);

    // Reminder must be in the future.
    if (!reminderDate.isAfter(DateTime.now())) {
      return "Reminder date must be in the future.";
    }

    // Reminder must be before the task start date.
    if (!reminderDate.isBefore(startDate)) {
      return "Reminder date must be befor the task start date.";
    }

    return null;
  }

}