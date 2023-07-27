import 'package:design_system/colors.dart';
import 'package:flutter/material.dart';

class ToolbarRectBtnWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isBorder;

  final Color? btnBackgroundColor;
  final double? btnWidth;
  final double? btnHeight;
  final String btnText;
  final Color? btnTextColor;
  final FontWeight? btnTextFontWeight;
  final double? btnTextFontSize;

  const ToolbarRectBtnWidget({
    super.key,
    required this.onPressed,
    this.btnBackgroundColor,
    required this.btnText,
    this.btnTextColor,
    this.btnTextFontWeight,
    this.btnTextFontSize,
    this.btnWidth,
    this.btnHeight,
    required this.isBorder,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: btnBackgroundColor ?? primaryButtonBg,
        minimumSize: Size(btnWidth ?? 73, btnHeight ?? 30),
        side: isBorder
            ? const BorderSide(
                width: 0.5,
                color: blueColor,
              )
            : null,
      ),
      onPressed: onPressed,
      child: Text(
        btnText,
        style: TextStyle(
          fontWeight: btnTextFontWeight ?? FontWeight.w700,
          fontSize: btnTextFontSize ?? 12,
          color: btnTextColor ?? primaryButtonTextColor,
        ),
      ),
    );
  }
}
