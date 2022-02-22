import 'package:flutter/material.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/widgets/custom_button.dart';

class CustomCancelButton {
  static Widget cancelButton(context) {
    return CustomButton(
      Languages.of(context!)!.cancel.toUpperCase(),
      fontSize: FontSize.eighteen,
      fontWeight: FontWeight.w600,
      buttonBackgroundColor: Colors.white,
      borderColor: Colors.white,
      textColor: ColorResource.colorEA6D48,
      onTap: () => Navigator.pop(context),
      cardShape: 5,
    );
  }
}
