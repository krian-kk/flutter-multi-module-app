// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/validator.dart';

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
  List<String> validationRules = [];
  Function? oncomplete;
  final Function? onEditing;
  final bool isBorder;
  final bool isFill;
  final Color cursorColor;
  final Function(bool)? validatorCallBack;

  // ignore: avoid_unused_constructor_parameters

  CustomTextField(

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
      this.inputformaters,
      this.isLabel = false,
      this.isBorder = false,
      this.isFill = false,
      this.cursorColor = ColorResource.color666666,
      this.validationRules = const []});

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
        contentPadding: EdgeInsets.fromLTRB(25, 20, 20, 20),
        fillColor: ColorResource.colorFFFFFF,
        filled: widget.isFill,
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: ColorResource.color101010.withOpacity(0.3),
          fontSize: FontSize.sixteen,
        ),
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
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: widget.borderColor!))
            : InputBorder.none,
        border: widget.isBorder
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: widget.borderColor!, width: 0.5))
            : InputBorder.none,
        enabledBorder: widget.isBorder
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: widget.borderColor!))
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
    // TODO: implement dispose
    super.dispose();
  }
}


// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:origa/utils/color_resource.dart';
// import 'package:origa/utils/font.dart';

// import 'custom_text.dart';

// class CustomTextField extends StatefulWidget {
//   String title;
//   String hintText;
//   bool obscureText;
//   TextEditingController controller;
//   Widget? suffixWidget;
//   bool isEnable;
//   bool isReadOnly;
//   Function? onTapped;

//   // ignore: avoid_unused_constructor_parameters

//   CustomTextField(
//       // ignore: invalid_required_positional_param
//       @required this.title,
//       // ignore: invalid_required_positional_param
//       @required this.hintText,
//       // ignore: invalid_required_positional_param
//       @required this.controller,
//       {this.obscureText = false,
//       this.suffixWidget,
//       this.isEnable = true,
//       this.onTapped,
//       this.isReadOnly = false});

//   @override
//   _CustomTextFieldState createState() => _CustomTextFieldState();
// }

// class _CustomTextFieldState extends State<CustomTextField> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         CustomText(
//           widget.title,
//           fontSize: 12,
//           color: ColorResource.color000000.withOpacity(0.3),
//         ),
//         Theme(
//           data: ThemeData(
//             primaryColor: ColorResource.color0066cc,
//           ),
//           child: TextField(
//             textInputAction: TextInputAction.send,
//             onTap: () {
//               widget.onTapped!();
//             },
//             autocorrect: false,
//             enableSuggestions: false,
//             obscureText: widget.obscureText,
//             controller: widget.controller,
//             readOnly: widget.isReadOnly,
//             enabled: widget.isEnable,
//             keyboardType: TextInputType.multiline,
//             maxLines: widget.obscureText ? 1 : null,
//             style: TextStyle(
//                 color: ColorResource.color000000,
//                 fontFamily: Font.latoRegular.toString(),
//                 fontSize: 14),
//             decoration: InputDecoration(
//               hintText: widget.hintText,
//               suffixIcon: UnconstrainedBox(child: widget.suffixWidget),
//               labelStyle: const TextStyle(color: ColorResource.color0066cc),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

