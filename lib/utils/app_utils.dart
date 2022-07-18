import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/custom_snackbar/custom_snackbar.dart';
import 'package:origa/utils/custom_snackbar/top_snack_bar.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_dialog.dart';
import 'package:origa/widgets/custom_text.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

// class DebugMode {
//   static bool get isInDebugMode {
//     const bool inDebugMode = true;
//     //assert(inDebugMode = true);
//     return inDebugMode;
//   }
// }

class AppUtils {
  static void hideKeyBoard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static void showErrorToast(String text) {
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 14.0);
  }

  static Future<void> makePhoneCall(String value) async {
    if (await canLaunch(value)) {
      await launch(value);
    } else {
      //  throw 'Could not make call $value';
      showErrorToast('Could not make call $value');
    }
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
                ScaffoldMessenger.of(context)
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
        backgroundColor: ColorResource.color3BCD25,
      ),
      displayDuration: const Duration(milliseconds: 1500),
    );
  }

  static void showToast(String text,
      {ToastGravity gravity = ToastGravity.BOTTOM,
      Color? backgroundColor = Colors.green}) {
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: gravity,
        timeInSecForIosWeb: 2,
        backgroundColor: backgroundColor,
        textColor: Colors.white,
        fontSize: 14.0);
  }

  static showDivider() {
    return const Divider(
      color: ColorResource.colorDADADA,
      thickness: 0.5,
    );
  }

  static showDivider2() {
    return const Divider(
      color: ColorResource.colorE5EAF6,
      thickness: 1.2,
    );
  }

  static String getLanguageCode(context) {
    final Locale myLocale = Localizations.localeOf(context);
    return myLocale.languageCode;
  }

  static Future<bool> checkNetworkConnection() async {
    bool networkConection = true;
    if (ConnectivityResult.none == await Connectivity().checkConnectivity()) {
      networkConection = false;
    } else {
      networkConection = true;
    }
    return networkConection;
  }

  static Future<bool> checkGPSConnection(context) async {
    bool gpsConnection = false;
    if (!await Location().serviceEnabled()) {
      await DialogUtils.showDialog(
        buildContext: context,
        title: 'Can not get current location',
        description: 'Please make sure you enable GPS and try again',
        okBtnText: Languages.of(context)!.enable.toUpperCase(),
        cancelBtnText: Languages.of(context)!.cancel.toUpperCase(),
        okBtnFunction: (String val) async {
          Navigator.pop(context);
          await Location().requestService().then((value) {
            debugPrint('------GPS Connection----->>> $value');
            gpsConnection = value;
          });
        },
      );
    } else {
      gpsConnection = true;
    }
    return gpsConnection;
  }

  static Future<bool> checkLocationPermission() async {
    bool locationAccess = false;
    final GeolocatorPlatform geolocatorPlatform = GeolocatorPlatform.instance;
    final LocationPermission permission =
        await geolocatorPlatform.checkPermission();
    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      locationAccess = true;
    } else {
      await openAppSettings();
    }
    return locationAccess;
  }
}
