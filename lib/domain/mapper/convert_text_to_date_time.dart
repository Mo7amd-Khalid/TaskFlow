import 'package:intl/intl.dart';

DateTime convertTextToDateTime({
  required String dateText,
}) {
  try {
    return DateFormat("MMM d, yyyy h:mm a").parse(dateText);
  } catch (_) {
    return DateFormat("MMM d, yyyy").parse(dateText);
  }
}
