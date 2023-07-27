import 'package:flutter/material.dart';

import '../app_sizes.dart';
import '../colors.dart';
import '../fonts.dart';

class CustomLabelWidget extends StatelessWidget {
  final double? labelWidth;
  final double? labelHeight;
  final Color? labelBg;
  final String labelText;
  final Color? labelTextColor;
  final FontWeight? labelTextFontWeight;
  final double? labelTextFontSize;

  const CustomLabelWidget({
    super.key,
    this.labelWidth,
    this.labelHeight,
    this.labelBg,
    required this.labelText,
    this.labelTextColor,
    this.labelTextFontWeight,
    this.labelTextFontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: labelWidth ?? 55,
      height: labelHeight ?? 19,
      decoration: BoxDecoration(
        color: labelBg ?? primaryLabelBg,
        borderRadius: const BorderRadius.all(Radius.circular(50)),
      ),
      child: Center(
        child: Text(labelText,
            style: TextStyle(
              fontSize: labelTextFontSize ?? Sizes.p10,
              fontWeight: labelTextFontWeight ?? textFontWeightSemiBold,
              color: labelTextColor ?? appTextSecondaryColor,
            )),
      ),
    );
  }
}
