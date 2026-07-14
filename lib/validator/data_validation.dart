

import 'package:task_flow/core/const/keywords.dart';

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

}