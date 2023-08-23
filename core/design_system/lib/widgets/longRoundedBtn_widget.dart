import 'package:design_system/colors.dart';
import 'package:design_system/fonts.dart';
import 'package:flutter/material.dart';

import '../app_sizes.dart';

class LongRoundedBtn extends StatelessWidget {
  final VoidCallback onPressed;

  final Color? btnBackgroundColor;

  final bool isBorder;
  final String btnText;
  final int? btnTextColor;
  final FontWeight? btnTextFontWeight;
  final double? btnTextFontSize;

  const LongRoundedBtn({
    super.key,
    this.btnBackgroundColor,
    required this.btnText,
    this.btnTextColor,
    this.btnTextFontWeight,
    this.btnTextFontSize,
    required this.isBorder,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor:
            btnBackgroundColor ?? ColorResourceDesign.secondaryButtonBg,
        side: isBorder
            ? const BorderSide(
                width: 0.5,
                color: ColorResourceDesign.blueColor,
              )
            : null,
        minimumSize: const Size(320, 50),
        elevation: 0,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(50))),
      ),
      onPressed: onPressed,
      child: Text(btnText,
          style: const TextStyle(
              color: ColorResourceDesign.textColor,
              fontWeight: FontResourceDesign.textFontWeightNormal,
              fontSize: Sizes.p16)),
    );
  }
}
