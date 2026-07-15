import 'package:intl/intl.dart';

DateTime convertTextToDateTime({
  required String dateText,
  required String timeText,
}){
  final date = DateFormat(
    'MMM d, yyyy',
  ).parse(dateText);
  final time = DateFormat('h:mm a').parse(timeText);

  return DateTime(
    date.year,
    date.month,
    date.day,
    time.hour,
    time.minute,
  );

}