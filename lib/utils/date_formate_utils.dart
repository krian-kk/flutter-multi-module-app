import 'package:intl/intl.dart';

class DateFormateUtils {
  DateFormateUtils._();
  static String followUpDateFormate(String date) =>
      DateFormat('yyyy-MM-dd  HH:mm').format(DateTime.parse(date));
}
