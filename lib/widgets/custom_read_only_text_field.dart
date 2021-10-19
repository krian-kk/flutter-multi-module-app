// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/validator.dart';

class CustomReadOnlyTextField extends StatefulWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  final Widget? suffixWidget;
  final bool isEnable;
  final bool isReadOnly;
  final Function? onTapped;
  final Widget? prefixWidget;
  final TextInputType keyBoardType;
  final int? maximumWordCount;
  final Color titleColor;
  final Color? borderColor;
  final Color textColor;
  final bool isHighlighted;
  final Color highlightColor;
  final FocusNode? focusNode;
  final Color? focusTextColor;
  final bool isLabel;
  final String? descriptionText;
  final List<TextInputFormatter>? inputformaters;
  List<String> validationRules = [];
  Function? oncomplete;
  final Function? onEditing;
  final bool isBorder;
  final bool isFill;
  final Color cursorColor;
  final Function(bool)? validatorCallBack;

  // ignore: avoid_unused_constructor_parameters

  CustomReadOnlyTextField(

      // ignore: invalid_required_positional_param
      @required this.hintText,
      // ignore: invalid_required_positional_param
      @required this.controller,
      {this.obscureText = false,
      this.suffixWidget,
      this.prefixWidget,
      this.isEnable = true,
      this.onTapped,
      this.isReadOnly = false,
      this.maximumWordCount,
      this.titleColor = ColorResource.color666666,
      this.textColor = ColorResource.color333333,
      this.borderColor = ColorResource.colorDADADA,
      this.isHighlighted = false,
      this.highlightColor = ColorResource.colorDADADA,
      this.focusNode,
      this.focusTextColor,
      this.keyBoardType = TextInputType.name,
      this.descriptionText,
      this.oncomplete,
      this.validatorCallBack,
      this.onEditing,
      this.inputformaters,
      this.isLabel = false,
      this.isBorder = true,
      this.isFill = false,
      this.cursorColor = ColorResource.color666666,
      this.validationRules = const []});

  @override
  _CustomReadOnlyTextFieldState createState() =>
      _CustomReadOnlyTextFieldState();
}

class _CustomReadOnlyTextFieldState extends State<CustomReadOnlyTextField> {
  @override
  void initState() {
    // if (widget.focusNode != null) {
    //   widget.focusNode!.addListener(() {
    //     setState(() {
    //       FocusScope.of(context).requestFocus(widget.focusNode);
    //     });
    //   });
    // }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: SizedBox(
        height: widget.isLabel ? null : 40,
        child: TextFormField(
          textInputAction: TextInputAction.done,
          cursorHeight: 17,

          validator: (String? value) {
            if (widget.validationRules.isNotEmpty) {
              final ValidationState validationStatus = Validator.validate(
                  value ?? '',
                  rules: widget.validationRules);
              widget.validatorCallBack!(validationStatus.status);
              if (!validationStatus.status) {
                return validationStatus.error;
              }
            }
            return null;
          },

          onEditingComplete: () {
            setState(() {});
            FocusScope.of(context).requestFocus(FocusNode());
            if (widget.onEditing != null) {
              widget.onEditing!();
            }
          },

          onFieldSubmitted: (text) {
            setState(() {});
            FocusScope.of(context).requestFocus(FocusNode());
            if (widget.onEditing != null) {
              widget.onEditing!();
            }
          },

          onTap: () {
            setState(() {});
            if (widget.onTapped != null) {
              widget.onTapped!();
            }
          },
          onChanged: (q) {
            setState(() {});
          },
          // ignore: prefer_const_literals_to_create_immutables
          // inputFormatters: [
          //   // if (widget.maximumWordCount != null)
          //   //   LengthLimitingTextInputFormatter(widget.maximumWordCount),
          // ],
          inputFormatters: widget.inputformaters,

          autocorrect: false,
          enableSuggestions: false,
          obscureText: widget.obscureText,
          controller: widget.controller,
          readOnly: widget.isReadOnly,
          enabled: widget.isEnable,
          keyboardType: widget.keyBoardType,
          cursorColor: widget.cursorColor,

          // maxLines: 1,

          focusNode: widget.focusNode,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
              color: (widget.focusNode != null && widget.focusNode!.hasFocus)
                  ? widget.focusTextColor
                  : widget.textColor),

          decoration: InputDecoration(
              fillColor: ColorResource.colorFFFFFF,
              filled: widget.isFill,
              hintText: widget.hintText,
              labelText: widget.isLabel ? widget.hintText : null,
              isDense: true,
              counterText: widget.descriptionText,
              contentPadding: EdgeInsets.fromLTRB(0, 10, 0, 11),
              errorMaxLines: 1,
              suffixIcon: widget.suffixWidget,
              errorStyle: Theme.of(context)
                  .textTheme
                  .subtitle1!
                  .copyWith(color: Colors.red),
              counterStyle: const TextStyle(
                  color: ColorResource.color666666,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.normal,
                  fontStyle: FontStyle.normal,
                  fontSize: 14),
              // errorText: validatePassword(widget.controller.text.trim()),
              labelStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  fontSize: FontSize.twelve,
                  color: ColorResource.color666666),

              // Theme.of(context).textTheme.subtitle1!.copyWith(
              //     color: (widget.focusNode != null && widget.focusNode!.hasFocus)
              //         ? ColorResource.color333333
              //         : ColorResource.color666666),
              focusedBorder: widget.isBorder
                  ? UnderlineInputBorder(
                      borderSide: BorderSide(color: ColorResource.colorE5EAF6))
                  : null,
              border: widget.isBorder
                  ? UnderlineInputBorder(
                      borderSide: BorderSide(color: ColorResource.colorE5EAF6))
                  : null,
              enabledBorder: widget.isBorder
                  ? UnderlineInputBorder(
                      borderSide: BorderSide(color: ColorResource.colorE5EAF6))
                  : null,
              disabledBorder: widget.isBorder
                  ? UnderlineInputBorder(
                      borderSide: BorderSide(color: ColorResource.colorE5EAF6))
                  : null,
              errorBorder: widget.isBorder
                  ? UnderlineInputBorder(
                      borderSide: const BorderSide(color: Colors.red))
                  : null),
        ),
      ),
    );
  }

  String? validatePassword(String value) {
    if (widget.validationRules.isNotEmpty) {
      final ValidationState validationStatus =
          Validator.validate(value, rules: widget.validationRules);
      if (!validationStatus.status) {
        return validationStatus.error;
      }
    }
    return null;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
