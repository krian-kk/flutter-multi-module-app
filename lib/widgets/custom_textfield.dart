import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';

import 'custom_text.dart';

class CustomTextField extends StatefulWidget {
  String title;
  String hintText;
  bool obscureText;
  TextEditingController controller;
  Widget? suffixWidget;
  bool isEnable;
  bool isReadOnly;
  Function? onTapped;

  // ignore: avoid_unused_constructor_parameters

  CustomTextField(
      // ignore: invalid_required_positional_param
      @required this.title,
      // ignore: invalid_required_positional_param
      @required this.hintText,
      // ignore: invalid_required_positional_param
      @required this.controller,
      {this.obscureText = false,
      this.suffixWidget,
      this.isEnable = true,
      this.onTapped,
      this.isReadOnly = false});

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          widget.title,
          fontSize: 12,
          color: ColorResource.color000000.withOpacity(0.3),
        ),
        Theme(
          data: ThemeData(
            primaryColor: ColorResource.color0066cc,
          ),
          child: TextField(
            textInputAction: TextInputAction.send,
            onTap: () {
              widget.onTapped!();
            },
            autocorrect: false,
            enableSuggestions: false,
            obscureText: widget.obscureText,
            controller: widget.controller,
            readOnly: widget.isReadOnly,
            enabled: widget.isEnable,
            keyboardType: TextInputType.multiline,
            maxLines: widget.obscureText ? 1 : null,
            style: TextStyle(
                color: ColorResource.color000000,
                fontFamily: Font.latoRegular.toString(),
                fontSize: 14),
            decoration: InputDecoration(
              hintText: widget.hintText,
              suffixIcon: UnconstrainedBox(child: widget.suffixWidget),
              labelStyle: const TextStyle(color: ColorResource.color0066cc),
            ),
          ),
        ),
      ],
    );
  }
}
