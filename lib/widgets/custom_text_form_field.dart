import 'package:flutter/material.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField(
    this.initailString,
    this.labelString, {
    Key? key,
    this.cursorColor = ColorResource.colorDADADA,
    this.focusColor = ColorResource.colorE5EAF6,
    this.hoverColor = ColorResource.colorE5EAF6,
    this.fillColor = ColorResource.colorE5EAF6,
    this.labelColor = ColorResource.color666666,
  }) : super(key: key);

  final Color cursorColor;
  final Color fillColor;
  final Color focusColor;
  final Color hoverColor;
  final String initailString;
  final Color labelColor;
  final String labelString;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: widget.cursorColor,

      initialValue: widget.initailString,
      //controller: loanDurationController,
      readOnly: true,
      decoration: new InputDecoration(
          labelText: widget.labelString,
          focusColor: widget.focusColor,
          hoverColor: widget.hoverColor,
          fillColor: widget.fillColor,
          labelStyle: TextStyle(
              color: widget.labelColor,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.normal,
              fontSize: FontSize.twelve)),
    );
  }
}
