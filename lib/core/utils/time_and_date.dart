import 'package:intl/intl.dart';

extension TimeAndDate on DateTime{

  String getTime() => DateFormat("h:mm a").format(this);
  String getDate() => DateFormat("MMM d, yyyy").format(this);

}