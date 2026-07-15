import 'package:intl/intl.dart';

extension TimeAndDate on DateTime{

  String getTime() => DateFormat("h:mm a").format(this);
  String getDate() => DateFormat("MMM d, yyyy").format(this);

  String getFullDateAndTime() => DateFormat("MMM d, h:mm a").format(this);

}