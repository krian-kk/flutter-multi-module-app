import 'package:intl/intl.dart';

class DateFormateUtils {
  DateFormateUtils._();
  // static String followUpDateFormate(String date) =>
  //     DateFormat('yyyy-MM-dd  HH:mm').format(DateTime.parse(date));
  static String followUpDateFormate(String date) {

    String? convertedDate = DateFormat.yMMMEd().format(DateTime.parse(date));

    String todayDate = DateFormat.yMMMEd().format(DateTime.now());
    if (todayDate == convertedDate) {
      convertedDate = 'Today, ' + convertedDate;
    } else {
      convertedDate = convertedDate;
    }
    return convertedDate;
  }
}
