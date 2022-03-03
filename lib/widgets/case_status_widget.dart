import 'package:flutter/material.dart';
import 'package:origa/utils/color_resource.dart';
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
            color: health == '0'
                ? ColorResource.red
                : health == '1'
                    ? ColorResource.orange
                    : ColorResource.green,
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
}
