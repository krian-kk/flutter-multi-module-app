import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';

class CustomButton extends StatefulWidget {
  final String? text;
  final double cardElevation;
  final double cardShape;
  final Color buttonBackgroundColor;
  final Color borderColor;
  final TextAlign textAlign;
  final GestureTapCallback? onTap;
  final bool isUnderLine;
  final bool isSingleLine;
  final bool isLeading;
  final bool isTrailing;
  final int? maxLines;
  final Widget leadingWidget;
  final Widget trailingWidget;
  final FontWeight? fontWeight;
  final Color textColor;
  final IconData? trailingIconData;
  final Axis axis;
  final MainAxisAlignment alignment;
  final double fontSize;
  final Font font;
  final bool isEnabled;
  final double width;
  final double height;

  CustomButton(this.text,
      {this.fontWeight = FontWeight.w600,
      this.leadingWidget = const Expanded(
        child: SizedBox.shrink(),
      ),
      this.trailingWidget = const Expanded(
        child: SizedBox.shrink(),
      ),
      this.font = Font.latoRegular,
      this.buttonBackgroundColor = ColorResource.color23375A,
      this.borderColor = Colors.black26,
      this.textAlign = TextAlign.left,
      this.onTap,
      this.textColor = ColorResource.colorFFFFFF,
      this.fontSize = FontSize.eighteen,
      this.isUnderLine = false,
      this.isLeading = false,
      this.isTrailing = false,
      this.isSingleLine = false,
      this.cardElevation = 0.0,
      this.cardShape = 8.0,
      this.axis = Axis.horizontal,
      this.alignment = MainAxisAlignment.center,
      this.maxLines,
      this.trailingIconData,
      this.height = 56,
      this.width = double.infinity,
      this.isEnabled = true});

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.onTap != null && widget.isEnabled) {
          widget.onTap!();
        }
      },
      child: SizedBox(
        width: widget.width,
        height: widget.height,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(widget.cardShape)),
            color: widget.buttonBackgroundColor
                .withOpacity(widget.isEnabled ? 1 : 0.3),
          ),
          // shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(widget.cardShape),
          //     side: BorderSide(
          //         color: widget.borderColor
          //             .withOpacity(widget.isEnabled ? 1 : 0.3))),
          // color: widget.buttonBackgroundColor
          //     .withOpacity(widget.isEnabled ? 1 : 0.3),
          //elevation: widget.cardElevation,
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Flex(
              direction: widget.axis,
              mainAxisAlignment: widget.alignment,
              children: [
                if (widget.isLeading) widget.trailingWidget,
                if (widget.text != null)
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      widget.text.toString(),
                      textAlign: widget.textAlign,
                      style: Theme.of(context).textTheme.button!.copyWith(
                              color: widget.textColor.withOpacity(
                            widget.isEnabled ? 1 : 0.3,
                          )),
                      maxLines: widget.maxLines,
                      overflow:
                          widget.isSingleLine ? TextOverflow.ellipsis : null,
                    ),
                  ),
                if (widget.isTrailing) widget.leadingWidget
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
