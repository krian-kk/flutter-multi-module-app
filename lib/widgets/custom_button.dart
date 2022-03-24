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
  final double padding;
  final bool isRemoveExtraPadding;
  final double? width;

  const CustomButton(
    this.text, {
    Key? key,
    this.fontWeight = FontWeight.w600,
    this.leadingWidget = const Expanded(
      child: SizedBox.shrink(),
    ),
    this.trailingWidget = const Expanded(
      child: SizedBox.shrink(),
    ),
    this.font = Font.latoMedium,
    this.buttonBackgroundColor = ColorResource.colorEA6D48,
    this.borderColor = ColorResource.colorEA6D48,
    this.textAlign = TextAlign.left,
    this.onTap,
    this.textColor = Colors.white,
    this.fontSize = FontSize.eighteen,
    this.isUnderLine = false,
    this.isLeading = false,
    this.isTrailing = false,
    this.isSingleLine = false,
    this.trailingIconData = Icons.settings,
    this.cardElevation = 0.0,
    this.cardShape = 8.0,
    this.axis = Axis.horizontal,
    this.alignment = MainAxisAlignment.center,
    this.maxLines,
    this.padding = 5.0,
    this.isEnabled = true,
    this.isRemoveExtraPadding = false,
    this.width,
  }) : super(key: key);

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
        width: MediaQuery.of(context).size.width,
        height: 56,
        child: MediaQuery.removePadding(
          context: context,
          removeBottom: widget.isRemoveExtraPadding,
          removeLeft: widget.isRemoveExtraPadding,
          removeRight: widget.isRemoveExtraPadding,
          removeTop: widget.isRemoveExtraPadding,
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(widget.cardShape),
                side: BorderSide(
                    width: 0.5,
                    color: widget.borderColor
                        .withOpacity(widget.isEnabled ? 1 : 0.3))),
            color: widget.buttonBackgroundColor
                .withOpacity(widget.isEnabled ? 1 : 0.3),
            elevation: widget.cardElevation,
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Flex(
                direction: widget.axis,
                mainAxisAlignment: widget.alignment,
                children: [
                  if (widget.isLeading) widget.trailingWidget,
                  if (widget.text != null)
                    Padding(
                      padding: EdgeInsets.all(widget.padding),
                      child: Text(
                        widget.text.toString(),
                        textAlign: widget.textAlign,
                        style: Theme.of(context).textTheme.button!.copyWith(
                                // fontSize: widget.fontSize,
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
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
