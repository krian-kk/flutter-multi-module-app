// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/custom_snackbar/custom_snackbar.dart';
import 'package:origa/utils/custom_snackbar/top_snack_bar.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_text.dart';

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

  // static void showSnackBar(
  //     BuildContext context, String value, bool isError) async {
  //   final snackbar = SnackBar(
  //     duration: Duration(milliseconds: 500),
  //     width: 710,
  //     content: Text(
  //       value,
  //       style: Theme.of(context)
  //           .textTheme
  //           .subtitle1!
  //           .copyWith(color: ColorResource.colorFFFFFF),
  //     ),
  //     backgroundColor: isError ? Colors.red : Colors.green,
  //     action: SnackBarAction(
  //       label: '',
  //       textColor: Colors.white,
  //       onPressed: () {},
  //     ),
  //     behavior: SnackBarBehavior.floating,
  //     dismissDirection: DismissDirection.endToStart,
  //   );

  //   ScaffoldMessenger.of(context).showSnackBar(snackbar);
  // }

  static void noInternetSnackbar(BuildContext context) {
    final snackBar = SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            Languages.of(context)!.noInternetConnection,
            color: ColorResource.colorffffff,
            fontWeight: FontWeight.w600,
          ),
          SizedBox(
            width: 110,
            height: 42,
            child: CustomButton(
              'Dismiss',
              padding: 0.0,
              buttonBackgroundColor: ColorResource.colorE72C30,
              borderColor: ColorResource.colorffffff,
              onTap: () {
                // ignore: deprecated_member_use
                Scaffold.of(context)
                    .hideCurrentSnackBar(reason: SnackBarClosedReason.action);
              },
            ),
          ),
        ],
      ),
      backgroundColor: ColorResource.colorE72C30,
      // action: SnackBarAction(
      //   label: 'Dismiss',
      //   textColor: ColorResource.colorffffff,
      //   onPressed: () {
      //   },
      // ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void topSnackBar(BuildContext context, String value) {
    showTopSnackBar(
      context,
      CustomSnackBar.success(
        message: value,
        backgroundColor: ColorResource.colorEA6D48,
      ),
    );
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

  static showDivider() {
    return Divider(
      color: ColorResource.colorDADADA,
      thickness: 0.5,
    );
  }

  // Pick Date Function

}
