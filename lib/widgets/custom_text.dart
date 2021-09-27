import 'package:flutter/cupertino.dart';
import 'package:easy_localization/easy_localization.dart';
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
  bool isUnderLine = false;
  bool isSingleLine = false;
  final int? maxLines;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final double? letterSpacing;

  CustomText(String text,
      {this.fontWeight,
      this.fontStyle,
      this.fontSize = 14,
      this.font = Font.robotoRegular,
      this.color = ColorResource.color1c1d22,
      this.lineHeight = 1.21, // Line Height - 17
      this.textAlign = TextAlign.left,
      this.onTap,
      this.isUnderLine = false,
      this.isSingleLine = false,
      this.letterSpacing,
      this.maxLines})
      // ignore: prefer_initializing_formals
      : text = text;

  @override
  _CustomTextState createState() => _CustomTextState();
}

class _CustomTextState extends State<CustomText> {
  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_this
    final Text textWidget = Text(this.widget.text,
            // ignore: unnecessary_this
            textAlign: this.widget.textAlign,
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
                fontWeight: widget.fontWeight))
        .tr();

    if (widget.onTap != null) {
      return GestureDetector(
        onTap: widget.onTap,
        child: textWidget,
      );
    } else {
      return textWidget;
    }
  }
}
