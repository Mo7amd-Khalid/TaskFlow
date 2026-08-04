import 'package:intl/intl.dart';

DateTime convertTextToDateTime({
  required String dateText,
}){
  final date = DateFormat(
    "MMM d, yyyy h:mm a",
  ).parse(dateText);

  return DateTime(
    date.year,
    date.month,
    date.day,
    date.hour,
    date.minute,
  );

}