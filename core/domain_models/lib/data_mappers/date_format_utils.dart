import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class DateFormatUtils {
  DateFormatUtils._();

// static String followUpDateFormate(String date) =>
// DateFormat('yyyy-MM-dd HH:mm').format(DateTime.parse(date));
  static String followUpDateFormate(String date) {
    // String? convertedDate = DateFormat.yMMMEd().format(DateTime.parse(date));
    final DateTime utcFormate = DateTime.parse(date).toUtc();
    String? convertedDate = DateFormat.yMMMEd()
        .format(DateTime.parse(utcFormate.toLocal().toString()));
    final String todayDate = DateFormat.yMMMEd().format(DateTime.now());
    if (todayDate == convertedDate) {
      convertedDate = 'Today, $convertedDate';
    } else {
      convertedDate = convertedDate;
    }
    return convertedDate;
  }

  static String? getDate2Month(String? date) {
    if (date != null && date.isNotEmpty) {
      final DateTime utcFormate = DateTime.parse(date).toUtc();
      final String convertedDate = DateFormat.MMMM()
          .format(DateTime.parse(utcFormate.toLocal().toString()));
      return convertedDate;
    } else {
      return null;
    }
  }
}

class DateFormatUtils2 {
  DateFormatUtils2._();

  static String followUpDateFormat2(String date) {
    String? convertedDate;
    if (date != '') {
      try {
        final utcFormat = DateTime.parse(date).toUtc();
        convertedDate = DateFormat('dd-MM-yyyy')
            .format(DateTime.parse(utcFormat.toLocal().toString()));
      } catch (e) {
        debugPrint('Try catch issue $e');
        convertedDate = date;
      }
    }
    return convertedDate ?? 'null';
  }
}

class DateFormatUtils3 {
  DateFormatUtils3._();

  static String followUpDateFormat3(String date) {
    String? convertedDate;
    if (date != '') {
      try {
        final DateTime utcFormat = DateTime.parse(date).toUtc();
        convertedDate = DateFormat.yMd()
            .format(DateTime.parse(utcFormat.toLocal().toString()));
      } catch (e) {
        debugPrint('Try catch issue $e');
        convertedDate = date;
      }
    }
    return convertedDate ?? 'null';
  }
}
