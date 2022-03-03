import 'package:flutter/material.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';

class CustomText extends StatefulWidget {
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
    this.fontWeight = FontWeight.w400,
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
  _CustomTextState createState() => _CustomTextState();
}

class _CustomTextState extends State<CustomText> {
  @override
  Widget build(BuildContext context) {
    final Text textWidget = Text(widget.text,
        textAlign: widget.textAlign,
        overflow: widget.isSingleLine ? TextOverflow.ellipsis : null,
        maxLines: widget.maxLines,
        style: TextStyle(
            decoration: widget.isUnderLine
                ? TextDecoration.underline
                : TextDecoration.none,
            color: widget.color,
            fontFamily: widget.font.value,
            fontSize: widget.fontSize,
            height: widget.lineHeight,
            fontStyle: widget.fontStyle,
            letterSpacing: widget.letterSpacing,
            fontWeight: widget.fontWeight));

    if (widget.onTap != null) {
      return InkWell(
        onTap: widget.onTap,
        child: textWidget,
      );
    } else {
      return textWidget;
    }
  }
}
