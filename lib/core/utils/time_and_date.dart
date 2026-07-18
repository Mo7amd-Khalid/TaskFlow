import 'package:intl/intl.dart';

extension TimeAndDate on DateTime{

  String getTime() => DateFormat("h:mm a").format(this);
  String getDate() => DateFormat("MMM d, yyyy").format(this);

  String getFullDateAndTime() => DateFormat("MMM d, h:mm a").format(this);

  bool isSameDateByDay() {
  DateTime dateTime = DateTime.now();
    return year == dateTime.year &&
        month == dateTime.month &&
        day == dateTime.day;
  }

  bool isSameDateByMonth() {
    DateTime dateTime = DateTime.now();
    return year == dateTime.year &&
        month == dateTime.month;
  }
  bool isSameDateByYear() {
    DateTime dateTime = DateTime.now();
    return year == dateTime.year;
  }

}