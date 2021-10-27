// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:origa/utils/color_resource.dart';

class DebugMode {
  static bool get isInDebugMode {
    const bool inDebugMode = true;
    //assert(inDebugMode = true);
    return inDebugMode;
  }
}

class AppUtils {
  static void hideKeyBoard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static void showErrorToast(String text) {
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 14.0);
  }

  static void showSnackBar(
      BuildContext context, String value, bool isError) async {
    final snackbar = SnackBar(
      duration: Duration(milliseconds: 500),
      width: 710,
      content: Text(
        value,
        style: Theme.of(context)
            .textTheme
            .subtitle1!
            .copyWith(color: ColorResource.colorFFFFFF),
      ),
      backgroundColor: isError ? Colors.red : Colors.green,
      action: SnackBarAction(
        label: '',
        textColor: Colors.white,
        onPressed: () {},
      ),
      behavior: SnackBarBehavior.floating,
      dismissDirection: DismissDirection.endToStart,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  static void showToast(String text,
      {ToastGravity gravity = ToastGravity.BOTTOM}) {
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: gravity,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 14.0);
  }
}
