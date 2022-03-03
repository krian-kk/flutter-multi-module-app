import 'package:flutter/material.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/constants.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/widgets/custom_text.dart';

class CaseStatusWidget {
  static Widget satusTextWidget(context,
      {double? width,
      // double? height,
      String? text,
      double? fontSize,
      double? radius,
      String? health}) {
    Widget? child;
    if (text != '') {
      child = Container(
        width: width ?? MediaQuery.of(context).size.width * 0.20,
        // height: height ?? 19,
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
        decoration: BoxDecoration(
            color: getStatusColor(text),
            borderRadius: BorderRadius.circular(radius ?? 30)),
        child: Center(
          child: CustomText(
            text!,
            color: ColorResource.colorffffff,
            fontSize: fontSize ?? FontSize.ten,
            lineHeight: 1,
            textAlign: TextAlign.center,
          ),
        ),
      );
    } else {
      child = const SizedBox();
    }
    return child;
  }

  static List<String> health_1 = [
    // Telecaller unreachable
    Constants.telsubstatuslineBusy.toLowerCase(),
    Constants.telsubstatusswitchOff.toLowerCase(),
    Constants.telsubstatusrnr.toLowerCase(),
    Constants.telsubstatusoutOfNetwork.toLowerCase(),
    Constants.telsubstatusdisconnecting.toLowerCase(),
    // Collector customer not met
    Constants.leftMessage.toLowerCase(),
    Constants.doorLocked.toLowerCase(),
    Constants.entryRestricted.toLowerCase(),
  ];

  static List<String> health_0 = [
    // Telecaller Invalid
    Constants.telsubstatusdoesNotExist.toLowerCase(),
    Constants.telsubstatusincorrectNumber.toLowerCase(),
    Constants.telsubstatusnotOpeartional.toLowerCase(),
    Constants.telsubstatusnumberNotWorking.toLowerCase(),
    // Collector Invalid
    Constants.wrongAddress.toLowerCase(),
    Constants.shifted.toLowerCase(),
    Constants.addressNotFound.toLowerCase(),
  ];

  static Color getStatusColor(String? text) {
    Color? color;
    if (health_1.contains(text?.toLowerCase())) {
      color = ColorResource.orange;
    } else if (health_0.contains(text?.toLowerCase())) {
      color = ColorResource.red;
    } else {
      color = ColorResource.green;
    }
    return color;
  }
}
