import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/utils/validator.dart';
import 'package:origa/widgets/custom_text.dart';
import 'package:origa/widgets/voice_record_widget.dart';

class CustomReadOnlyTextField extends StatefulWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  final Widget? suffixWidget;
  final bool isEnable;
  final bool isReadOnly;
  final Function? onTapped;
  final Function? onChanged;
  final Widget? prefixWidget;
  final TextInputType keyBoardType;
  final int? maximumWordCount;
  final Color titleColor;
  final Color borderColor;
  final Color textColor;
  final bool isHighlighted;
  final Color highlightColor;
  final FocusNode? focusNode;
  final Color? focusTextColor;
  final bool isLabel;
  final String? descriptionText;
  final List<TextInputFormatter>? inputformaters;
  final List<String> validationRules;
  final EdgeInsetsGeometry? contentPadding;
  final Function? onEditing;
  final bool isBorder;
  final bool isFill;
  final Color cursorColor;
  final Function? validatorCallBack;
  final double height;
  final TextCapitalization? textCapitalization;
  final bool isVoiceRecordWidget;
  final String? caseId;

  const CustomReadOnlyTextField(
    this.hintText,
    this.controller, {
    Key? key,
    this.obscureText = false,
    this.suffixWidget,
    this.prefixWidget,
    this.isEnable = true,
    this.onTapped,
    this.onChanged,
    this.isReadOnly = false,
    this.maximumWordCount,
    this.titleColor = ColorResource.color666666,
    this.textColor = ColorResource.color333333,
    this.borderColor = ColorResource.colorE5EAF6,
    this.isHighlighted = false,
    this.highlightColor = ColorResource.colorDADADA,
    this.focusNode,
    this.focusTextColor,
    this.height = 40,
    this.keyBoardType = TextInputType.name,
    this.descriptionText,
    this.validatorCallBack,
    this.onEditing,
    this.inputformaters,
    this.isLabel = false,
    this.isBorder = true,
    this.isFill = false,
    this.contentPadding,
    this.cursorColor = ColorResource.color666666,
    this.validationRules = const [],
    this.textCapitalization,
    this.isVoiceRecordWidget = false,
    this.caseId = 'case_id',
  }) : super(key: key);

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
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            height: widget.isLabel ? null : widget.height,
            child: TextFormField(
              textInputAction: TextInputAction.done,
              cursorHeight: 17,
              validator: (String? value) {
                if (widget.validationRules.isNotEmpty) {
                  final ValidationState validationStatus = Validator.validate(
                      value ?? '',
                      rules: widget.validationRules);
                  if (!validationStatus.status) {
                    return validationStatus.error;
                  }
                }
                return null;
              },

              onEditingComplete: () {
                setState(() {});
                FocusScope.of(context).unfocus();
                // FocusScope.of(context).requestFocus(FocusNode());
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
                widget.onChanged;
                setState(() {});
                // FocusScope.of(context).unfocus();
              },
              textCapitalization:
                  widget.textCapitalization ?? TextCapitalization.none,

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
                  color:
                      (widget.focusNode != null && widget.focusNode!.hasFocus)
                          ? widget.focusTextColor
                          : widget.textColor),

              decoration: InputDecoration(
                  fillColor: ColorResource.colorFFFFFF,
                  filled: widget.isFill,
                  hintText: widget.hintText,
                  labelText: widget.isLabel ? widget.hintText : null,
                  isDense: true,
                  counterText: widget.descriptionText,
                  contentPadding: widget.contentPadding ??
                      const EdgeInsets.fromLTRB(0, 10, 0, 9),
                  errorMaxLines: 1,
                  suffixIcon: widget.isVoiceRecordWidget
                      ? VoiceRecodingWidget(
                          recording: (values) {
                            if (values is bool) {
                              //Click action true/false
                            } else if (values is String) {
                              //API response
                            }
                          },
                          caseId: widget.caseId,
                        )
                      : widget.suffixWidget,
                  errorStyle: const TextStyle(
                      color: Colors.red,
                      height: 0.7,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.normal,
                      fontSize: 8),
                  counterStyle: const TextStyle(
                      color: ColorResource.color666666,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.normal,
                      fontStyle: FontStyle.normal,
                      fontSize: 14),
                  // errorText: validatePassword(widget.controller.text.trim()),
                  labelStyle: const TextStyle(
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
                          borderSide: BorderSide(color: widget.borderColor))
                      : null,
                  border: widget.isBorder
                      ? UnderlineInputBorder(
                          borderSide: BorderSide(color: widget.borderColor))
                      : null,
                  enabledBorder: widget.isBorder
                      ? UnderlineInputBorder(
                          borderSide: BorderSide(color: widget.borderColor))
                      : null,
                  disabledBorder: widget.isBorder
                      ? UnderlineInputBorder(
                          borderSide: BorderSide(color: widget.borderColor))
                      : null,
                  errorBorder: widget.isBorder
                      ? const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red))
                      : null),
            ),
          ),
        ),
        if (widget.isVoiceRecordWidget) const SizedBox(height: 13),
        if (widget.isVoiceRecordWidget)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 13, vertical: 11),
                decoration: const BoxDecoration(
                    color: ColorResource.colorF7F8FA,
                    borderRadius: BorderRadius.all(Radius.circular(60.0))),
                child: const CustomText(
                  'Remarks Recording',
                  lineHeight: 1,
                  color: ColorResource.color000000,
                  fontSize: FontSize.fourteen,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(width: 5),
              CircleAvatar(
                backgroundColor: ColorResource.color23375A,
                radius: 15,
                child: Center(
                  child: SvgPicture.asset(
                    ImageResource.microPhoneImage,
                    width: 10,
                    height: 15,
                  ),
                ),
              ),
            ],
          ),
        if (widget.isVoiceRecordWidget) const SizedBox(height: 6),
        if (widget.isVoiceRecordWidget)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 11),
            decoration: const BoxDecoration(
                color: ColorResource.colorF7F8FA,
                borderRadius: BorderRadius.all(Radius.circular(60.0))),
            child: const CustomText(
              'Hi Reason for Dispute, they will update in a Weeks time!  We can call them next time.',
              color: ColorResource.color000000,
              fontSize: FontSize.fourteen,
              fontWeight: FontWeight.w400,
            ),
          ),
      ],
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
