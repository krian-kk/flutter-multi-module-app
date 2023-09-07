import 'package:flutter/material.dart';
import 'package:languages/language_english.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/widgets/custom_button.dart';

class CustomCancelButton {
  static Widget cancelButton(BuildContext? context,
      {Function()? function, double? fontsize}) {
    return CustomButton(
      LanguageEn().cancel.toUpperCase(),
      fontSize: fontsize ?? FontSize.eighteen,
      buttonBackgroundColor: Colors.white,
      borderColor: Colors.white,
      textColor: ColorResource.colorEA6D48,
      onTap: function ?? () => Navigator.pop(context!),
      cardShape: 5,
    );
  }
}
