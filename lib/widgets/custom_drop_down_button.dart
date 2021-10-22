// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/widgets/custom_text.dart';

class CustomDropDownButton extends StatefulWidget {
  // final String value;
  final String labelText;
  final List<String> listOfItems;
  final Widget? hintWidget;
  final Widget icon;
  final Widget? underline;
  final bool isExpanded;
  final TextStyle? style;
  final Color? focusColor;
  final FocusNode? focusNode;
  final bool autoFocus;
  final Function? onChanged;

  const CustomDropDownButton(this.labelText, this.listOfItems,
      {Key? key,
      this.hintWidget,
      this.icon = const ImageIcon(AssetImage(ImageResource.downArrow)),
      this.underline,
      this.isExpanded = true,
      this.style,
      this.focusNode,
      this.autoFocus = false,
      this.onChanged,
      this.focusColor})
      : super(key: key);
  @override
  State<CustomDropDownButton> createState() => _CustomDropDownButtonState();
}

class _CustomDropDownButtonState extends State<CustomDropDownButton> {
  late String? selectedValue;
  @override
  void initState() {
    super.initState();

    setState(() {
      selectedValue = widget.listOfItems[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomText(
          widget.labelText,
          color: ColorResource.color666666,
          fontWeight: FontWeight.w400,
          fontSize: FontSize.twelve,
          fontStyle: FontStyle.normal,
        ),
        DropdownButton<String>(
          value: selectedValue,
          icon: widget.icon,
          iconSize: 24,
          isExpanded: widget.isExpanded,
          style: widget.style ??
              TextStyle(
                  color: ColorResource.color333333,
                  fontWeight: FontWeight.w700,
                  fontSize: FontSize.fourteen,
                  fontStyle: FontStyle.normal),
          underline: Container(
            height: 1,
            color: ColorResource.colorE5EAF6,
          ),
          focusNode: widget.focusNode,
          onChanged: (newValue) {
            setState(() {
              selectedValue = newValue;
            });
          },
          autofocus: widget.autoFocus,
          focusColor: widget.focusColor,
          hint: widget.hintWidget,
          items:
              widget.listOfItems.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ],
    );
  }
}
