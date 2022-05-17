import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:origa/listener/item_selected_listener.dart';
import 'package:origa/utils/color_resource.dart';

class PickDateAndTimeUtils {
  static Future<dynamic> pickDate(
      BuildContext context, OnChangeForPickDate function) async {
    final DateTime? newDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year + 3),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: Theme.of(context).copyWith(
              textTheme: const TextTheme(
                subtitle1: TextStyle(
                  fontSize: 25.0,
                  color: ColorResource.color000000,
                ),
                headline1: TextStyle(fontSize: 20.0),
              ),
              colorScheme: const ColorScheme.light(
                primary: ColorResource.color23375A,
                onSurface: ColorResource.color23375A,
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  primary: ColorResource.color23375A,
                ),
              ),
            ),
            child: child!,
          );
        });

    if (newDate == null) {
      return null;
    }
    final String formattedDate = DateFormat('yyyy-MM-dd').format(newDate);
    function(formattedDate, newDate.toString());
  }

  static Future<dynamic> pickTime(
      BuildContext context, OnChange function) async {
    final TimeOfDay? newTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: Theme.of(context).copyWith(
              textTheme: const TextTheme(
                subtitle1: TextStyle(fontSize: 10.0),
                headline1: TextStyle(fontSize: 8.0),
              ),
              colorScheme: const ColorScheme.light(
                primary: ColorResource.color23375A,
                onSurface: ColorResource.color23375A,
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  primary: ColorResource.color23375A,
                ),
              ),
            ),
            child: child!,
          );
        });
    if (newTime == null) {
      return;
    }

    final String hours = newTime.hourOfPeriod.toString().padLeft(2, '0');
    final String minites = newTime.minute.toString().padLeft(2, '0');
    function('$hours:$minites');
  }

  static Future<dynamic> pickCollectionDate(
      BuildContext context, OnChangeForPickDate function) async {
    final DateTime? newDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(DateTime.now().year - 1),
        lastDate: DateTime.now(),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: Theme.of(context).copyWith(
              textTheme: const TextTheme(
                subtitle1: TextStyle(
                  fontSize: 25.0,
                  color: ColorResource.color000000,
                ),
                headline1: TextStyle(fontSize: 20.0),
              ),
              colorScheme: const ColorScheme.light(
                primary: ColorResource.color23375A,
                onSurface: ColorResource.color23375A,
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  primary: ColorResource.color23375A,
                ),
              ),
            ),
            child: child!,
          );
        });

    if (newDate == null) {
      return null;
    }
    final String formattedDate = DateFormat('yyyy-MM-dd').format(newDate);
    function(formattedDate, newDate.toString());
  }
}
