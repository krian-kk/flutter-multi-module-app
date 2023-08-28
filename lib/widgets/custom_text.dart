import 'package:design_system/fonts.dart';
import 'package:flutter/material.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';

class CustomText extends StatelessWidget {

  final String text;
  final double fontSize;
  final Font font;
  final Color color;
  final double lineHeight;
  final TextAlign textAlign;
  final GestureTapCallback? onTap;
  final bool isUnderLine;
  final bool isSingleLine;
  final int? maxLines;
  final FontWeight? fontWeight;
  final FontStyle fontStyle;
  final double? letterSpacing;
  final TextStyle? style;

  const CustomText(
    this.text, {
    Key? key,
    this.fontWeight,
    this.fontStyle = FontStyle.normal,
    this.fontSize = FontSize.fourteen,
    this.font = Font.latoMedium,
    this.color = ColorResource.color1c1d22,
    this.lineHeight = 1.5,
    this.textAlign = TextAlign.left,
    this.onTap,
    this.isUnderLine = false,
    this.isSingleLine = false,
    this.letterSpacing,
    this.style,
    this.maxLines,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final Text textWidget = Text(text,
        textAlign: textAlign,
        overflow: isSingleLine ? TextOverflow.ellipsis : null,
        maxLines: maxLines,
        style: TextStyle(
            decoration:
                isUnderLine ? TextDecoration.underline : TextDecoration.none,
            color: color,
            fontFamily: font.value,
            fontSize: fontSize,
            height: lineHeight,
            fontStyle: fontStyle,
            letterSpacing: letterSpacing,
            fontWeight:
                fontWeight ?? FontResourceDesign.textFontWeightSemiBold));

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        child: textWidget,
      );
    } else {
      return textWidget;
    }
  }
}
