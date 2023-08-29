import 'package:design_system/colors.dart';
import 'package:design_system/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../app_sizes.dart';

class LongRoundedBtnIcon extends StatelessWidget {
  final Function()? onPressed;
  final Color? btnBackgroundColor;
  final double? btnWidth;
  final double? btnHeight;
  final bool isBorder;
  final String btnText;
  final Color? btnTextColor;
  final FontWeight? btnTextFontWeight;
  final double? btnTextFontSize;
  final SvgPicture btnImage;

  const LongRoundedBtnIcon({
    super.key,
    this.btnBackgroundColor,
    required this.btnText,
    this.btnTextColor,
    this.btnTextFontWeight,
    this.btnTextFontSize,
    required this.isBorder,
    this.onPressed,
    required this.btnImage,
    this.btnWidth,
    this.btnHeight,
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
        minimumSize: Size(btnWidth ?? 320, btnHeight ?? 50),
        elevation: 0,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(50))),
      ),
      onPressed: onPressed ?? () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          btnImage,
          gapW16,
          Text(btnText,
              style: const TextStyle(
                  color: ColorResourceDesign.textColor,
                  fontWeight: FontResourceDesign.textFontWeightNormal,
                  fontSize: Sizes.p16)),
        ],
      ),
    );
  }
}
