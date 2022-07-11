import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:origa/listener/item_selected_listener.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/widgets/custom_text.dart';

class DropDownButton extends StatefulWidget {
  const DropDownButton(
    this.listOfItems, {
    Key? key,
    this.hintWidget,
    this.icon,
    this.labelText,
    this.underline,
    this.isExpanded = true,
    this.style,
    this.valueTextStyle,
    this.focusNode,
    this.underlineColor = ColorResource.colorE5EAF6,
    this.autoFocus = false,
    this.onChanged,
    this.focusColor,
    this.menuMaxHeight,
    this.selectedValue,
  }) : super(key: key);
  // final String value;
  final String? labelText;
  final List<String> listOfItems;
  final String? selectedValue;
  final Widget? hintWidget;
  final Widget? icon;
  final Widget? underline;
  final bool isExpanded;
  final TextStyle? style;
  final TextStyle? valueTextStyle;
  final Color? focusColor;
  final Color? underlineColor;
  final FocusNode? focusNode;
  final bool autoFocus;
  final OnChange? onChanged;
  final double? menuMaxHeight;

  @override
  State<DropDownButton> createState() => _DropDownButtonState();
}

class _DropDownButtonState extends State<DropDownButton> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        widget.labelText != null
            ? CustomText(
                widget.labelText!,
                color: ColorResource.color666666,
                fontSize: FontSize.twelve,
              )
            : const SizedBox(),
        MediaQuery.removePadding(
          removeBottom: true,
          // removeTop: true,
          context: context,
          child: SizedBox(
            // height: 35,
            child: DropdownButtonFormField<String>(
              value: widget.selectedValue,
              icon: Padding(
                padding: const EdgeInsets.only(right: 10, bottom: 3),
                child: widget.icon ??
                    Padding(
                      padding: const EdgeInsets.only(right: 3),
                      child: SvgPicture.asset(
                        ImageResource.downArrow,
                        width: 9,
                        height: 14,
                      ),
                    ),
              ),
              // iconSize: 24,
              isExpanded: widget.isExpanded,
              style: widget.style ??
                  const TextStyle(
                      color: ColorResource.color333333,
                      fontWeight: FontWeight.w700,
                      height: 0.5,
                      fontSize: FontSize.fourteen,
                      fontStyle: FontStyle.normal),
              // underline: Container(
              //   height: 1,
              //   color: widget.underlineColor,
              // ),
              menuMaxHeight: widget.menuMaxHeight,
              focusNode: widget.focusNode,
              decoration: const InputDecoration(
                // enabledBorder:const InputBorder(borderSide: ),
                errorStyle: TextStyle(
                    color: Colors.red,
                    height: 0.7,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                    fontSize: 8),
                border: UnderlineInputBorder(
                    borderSide: BorderSide(
                  color: ColorResource.colorE5EAF6,
                )),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                  color: ColorResource.colorE5EAF6,
                )),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                  color: ColorResource.colorE5EAF6,
                )),
                // errorBorder: OutlineInputBorder(
                //   gapPadding: 0.0,
                //   borderSide: BorderSide(
                //       color: ColorResource.red, style: BorderStyle.none),
                // ),
              ),
              // onChanged: (newValue) {
              //   setState(() {
              //     selectedValue = newValue;
              //   });
              // },
              onTap: () => FocusScope.of(context).unfocus(),
              onChanged: widget.onChanged,
              autofocus: widget.autoFocus,
              focusColor: widget.focusColor,
              hint: widget.hintWidget,
              validator: (value) =>
                  value == null ? 'This field is required' : null,
              // disabledHint: widget.disableHint != null
              //     ? Text(widget.disableHint!)
              //     : const SizedBox(),
              items: widget.listOfItems
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: widget.valueTextStyle ??
                        const TextStyle(overflow: TextOverflow.ellipsis),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
