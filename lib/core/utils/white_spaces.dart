import 'package:flutter/cupertino.dart';

extension WhiteSpace on num{

  SizedBox get horizontalSpace => SizedBox(width: toDouble());
  SizedBox get verticalSpace => SizedBox(height: toDouble());
}


