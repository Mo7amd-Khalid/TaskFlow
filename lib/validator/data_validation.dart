

import 'package:task_flow/core/const/keywords.dart';
import 'package:task_flow/domain/mapper/convert_text_to_date_time.dart';

class DataValidation{
  static String? titleValidation(String value){
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
        required String startTime,
        required String endDate,
        required String endTime}){
    DateTime startDateTime = convertTextToDateTime(dateText: startDate, timeText: startTime);
    DateTime endDateTime = convertTextToDateTime(dateText: endDate, timeText: endTime);
    if (endDateTime.isBefore(startDateTime) || endDateTime.isAtSameMomentAs(startDateTime)){
      return AppKeywords.endDateInvalid;
    }
    return null;
  }



}