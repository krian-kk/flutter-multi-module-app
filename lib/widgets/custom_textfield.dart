import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/validator.dart';

@immutable
class CustomTextField extends StatefulWidget {
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
  final Color? errorborderColor;
  final Color textColor;
  final bool isHighlighted;
  final Color highlightColor;
  final FocusNode? focusNode;
  final Color? focusTextColor;
  final bool isLabel;
  final String? descriptionText;
  final List<TextInputFormatter>? inputformaters;
  final List<String> validationRules;
  final Function? oncomplete;
  final Function? onEditing;
  final Function? onChange;
  final bool isBorder;
  final bool isFill;
  final Color cursorColor;
  final Function(bool)? validatorCallBack;
  final AutovalidateMode? autovalidateMode;
  final EdgeInsetsGeometry? contentPadding;

  const CustomTextField(
    this.hintText,
    this.controller, {
    Key? key,
    this.obscureText = false,
    this.suffixWidget,
    this.prefixWidget,
    this.isEnable = true,
    this.onTapped,
    this.isReadOnly = false,
    this.maximumWordCount,
    this.titleColor = ColorResource.color666666,
    this.textColor = ColorResource.color333333,
    this.borderColor = ColorResource.colorDADADA,
    this.errorborderColor = Colors.red,
    this.isHighlighted = false,
    this.highlightColor = ColorResource.colorDADADA,
    this.focusNode,
    this.focusTextColor,
    this.keyBoardType = TextInputType.name,
    this.descriptionText,
    this.oncomplete,
    this.validatorCallBack,
    this.onEditing,
    this.onChange,
    this.inputformaters,
    this.isLabel = false,
    this.isBorder = false,
    this.isFill = false,
    this.autovalidateMode,
    this.cursorColor = ColorResource.color666666,
    this.contentPadding = const EdgeInsets.fromLTRB(25, 15, 20, 15),
    this.validationRules = const [],
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
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
    return TextFormField(
      textInputAction: TextInputAction.done,
      autovalidateMode: widget.autovalidateMode,
      validator: (String? value) {
        if (widget.validationRules.isNotEmpty) {
          final ValidationState validationStatus =
              Validator.validate(value ?? '', rules: widget.validationRules);
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
        setState(() {
          if (widget.onChange != null) {
            widget.onChange!();
          }
        });
      },
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
        contentPadding: widget.contentPadding,
        fillColor: ColorResource.colorFFFFFF,
        filled: widget.isFill,
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: ColorResource.color101010.withOpacity(0.3),
          fontSize: FontSize.sixteen,
        ),
        suffixIcon: widget.suffixWidget,
        labelText: widget.isLabel ? widget.hintText : null,
        isDense: false,
        counterText: widget.descriptionText,
        errorMaxLines: 1,
        errorStyle:
            Theme.of(context).textTheme.subtitle1!.copyWith(color: Colors.red),
        counterStyle: const TextStyle(
            color: ColorResource.color666666,
            fontFamily: 'Lato-Medium',
            fontWeight: FontWeight.normal,
            fontStyle: FontStyle.normal,
            fontSize: 12),
        // errorText: validatePassword(widget.controller.text.trim()),
        labelStyle: const TextStyle(
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            fontSize: FontSize.fourteen,
            color: ColorResource.color666666),

        // Theme.of(context).textTheme.subtitle1!.copyWith(
        //     color: (widget.focusNode != null && widget.focusNode!.hasFocus)
        //         ? ColorResource.color333333
        //         : ColorResource.color666666),
        focusedBorder: widget.isBorder
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: widget.borderColor!, width: 0.5))
            : InputBorder.none,
        border: widget.isBorder
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: widget.borderColor!, width: 0.5))
            : InputBorder.none,
        enabledBorder: widget.isBorder
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: widget.borderColor!, width: 0.5))
            : InputBorder.none,
        disabledBorder: widget.isBorder
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: widget.borderColor!))
            : InputBorder.none,
        focusedErrorBorder: widget.isBorder
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: widget.errorborderColor!))
            : InputBorder.none,
        errorBorder: widget.isBorder
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: widget.errorborderColor!))
            : InputBorder.none,
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
    super.dispose();
  }
}
