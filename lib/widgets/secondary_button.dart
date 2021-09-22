import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';

import 'custom_text.dart';

class SecondaryButton extends StatefulWidget {
  final String buttonName;
  final Function? onClick;
  // ignore: prefer_typing_uninitialized_variables
  final double leftMargin;
  // ignore: type_annotate_public_apis
  final double rightMargin;
  final Color color;
  final FontWeight fontWeight;
  final double fontSize;
  final bool isMarginRequired;
  final Color textColor;
  final Color marginColor;
  final bool isShadowrequired;

  const SecondaryButton(this.buttonName,
      {this.onClick,
      this.leftMargin = 25,
      this.rightMargin = 25,
      this.color = Colors.white,
      this.fontWeight = FontWeight.w700,
      this.fontSize = 14,
      this.isMarginRequired = true,
      this.textColor = ColorResource.color1c1d22,
      this.marginColor = ColorResource.colore3e3e5,
      this.isShadowrequired = true});
  @override
  _SecondaryButtonState createState() => _SecondaryButtonState();
}

class _SecondaryButtonState extends State<SecondaryButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      decoration: _buildDecoration(),
      child: InkWell(
        onTap: () {
          AppUtils.hideKeyBoard(context);
          widget.onClick!();
        },
        child: Center(
          child: CustomText(
            widget.buttonName,
            color: widget.textColor,
            font: Font.robotoMedium,
            fontSize: widget.fontSize,
          ),
        ),
      ),
    );
  }

  Decoration _buildDecoration() {
    return BoxDecoration(

        // ignore: avoid_redundant_argument_values
        border: widget.isMarginRequired
            // ignore: avoid_redundant_argument_values
            ? Border.all(width: 1, color: widget.marginColor)
            : null,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        // ignore: prefer_const_literals_to_create_immutables
        boxShadow: [
          if (widget.isMarginRequired && widget.isShadowrequired)
            const BoxShadow(
                color: ColorResource.colorDEE0E2,
                blurRadius: 20,
                offset: Offset(0, 2))
        ],
        // ignore: unnecessary_this
        color: this.widget.color);
  }
}
