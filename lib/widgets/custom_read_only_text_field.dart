import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/listener/item_selected_listener.dart';
import 'package:origa/models/speech2text_model.dart';
import 'package:origa/singleton.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/constants.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/validator.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_cancel_button.dart';
import 'package:origa/widgets/custom_text.dart';
import 'package:origa/widgets/voice_record_widget.dart';
import 'package:path_provider/path_provider.dart';

import '../singleton.dart';

class CustomReadOnlyTextField extends StatefulWidget {
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
    this.returnS2Tresponse,
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
    this.isNumberOnly = false,
    this.agrRef,
    this.remarkFunction,
    this.lableStyle,
    this.checkRecord,
    this.isSubmit = true,
  }) : super(key: key);
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
  final Function? returnS2Tresponse;
  final bool isBorder;
  final bool isFill;
  final Color cursorColor;
  final Function? validatorCallBack;
  final double height;
  final TextCapitalization? textCapitalization;
  final bool isVoiceRecordWidget;
  final bool isNumberOnly;
  final String? caseId;
  final String? agrRef;
  final OnChange? remarkFunction;
  final TextStyle? lableStyle;
  final OnChangeCheckRecord? checkRecord;
  final bool isSubmit;

  @override
  _CustomReadOnlyTextFieldState createState() =>
      _CustomReadOnlyTextFieldState();
}

class _CustomReadOnlyTextFieldState extends State<CustomReadOnlyTextField> {
  String filePath = '';
  bool isPlaying = false;
  bool isPaused = false;
  bool isActiveSpeaker = false;
  TextEditingController translateTextController =
      TextEditingController(text: '');
  bool isEdit = false;
  static const platform = MethodChannel('recordAudioChannel');
  FocusNode? focus = FocusNode();

  Speech2TextModel getTranslatedData = Speech2TextModel();

  @override
  void initState() {
    if (widget.isVoiceRecordWidget) {
      getFileDirectory();
    }

    super.initState();
  }

  getFileDirectory() async {
    final String dir = ((await getApplicationDocumentsDirectory()).path) +
        '/${Singleton.instance.agrRef}_${((DateTime.now().toIso8601String()).split('.').first.toString()).replaceAll(':', '-')}.wav';
    setState(() {
      filePath = dir;
    });
  }

  playAudio() async {
    await platform
        .invokeMethod('playRecordAudio', {'filePath': filePath}).then((value) {
      if (value) {
        setState(() => isPlaying = true);
      }
    });
    await platform.invokeMethod(
        'completeRecordAudio', {'filePath': filePath}).then((value) {
      if (value != null) {
        setState(() {
          isPlaying = false;
          isPaused = false;
        });
      }
    });
  }

  stopAudio() async {
    await platform
        .invokeMethod('stopPlayingAudio', {'filePath': filePath}).then((value) {
      if (value) {
        setState(() {
          isPlaying = false;
          isPaused = false;
        });
      }
    });
  }

  pauseAudio() async {
    await platform.invokeMethod(
        'pausePlayingAudio', {'filePath': filePath}).then((value) {
      if (value) {
        setState(() {
          isPaused = true;
        });
      }
    });
  }

  resumeAudio() async {
    await platform.invokeMethod(
        'resumePlayingAudio', {'filePath': filePath}).then((value) {
      if (value) {
        setState(() {
          isPaused = false;
        });
      }
    });
    await platform.invokeMethod(
        'completeRecordAudio', {'filePath': filePath}).then((value) {
      if (value != null) {
        setState(() {
          isPlaying = false;
          isPaused = false;
        });
      }
    });
  }

  @override
  void dispose() {
    isActiveSpeaker = false;
    filePath = '';
    translateTextController.text = '';
    translateTextController.dispose();
    super.dispose();
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
              inputFormatters: widget.inputformaters ??
                  [
                    FilteringTextInputFormatter.deny(Constants.rEGEXEMOJI),
                    if (widget.controller.text.isEmpty)
                      FilteringTextInputFormatter.deny(' '),
                    if (widget.maximumWordCount != null)
                      LengthLimitingTextInputFormatter(widget.maximumWordCount),
                    if (widget.isNumberOnly)
                      FilteringTextInputFormatter.digitsOnly,
                  ],
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
                      ? (filePath != '')
                          ? VoiceRecodingWidget(
                              filePath: filePath,
                              recordingData: (values) {
                                if (values is bool) {
                                  //Click action true/false
                                } else if (values is Speech2TextModel) {
                                  //API response
                                  setState(() {
                                    getTranslatedData = values;
                                    translateTextController.text =
                                        values.result!.translatedText!;
                                    isActiveSpeaker = true;
                                  });
                                }
                              },
                              onRecordStart: () {
                                widget.controller.text =
                                    translateTextController.text;
                                setState(() {
                                  translateTextController.text = '';
                                  isActiveSpeaker = false;
                                });
                                widget.checkRecord!(
                                    Constants.none, '', Speech2TextModel());
                                widget.returnS2Tresponse!(getTranslatedData);
                              },
                              caseId: widget.caseId,
                              checkRecord: widget.checkRecord,
                            )
                          : const SizedBox()
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
                  labelStyle: widget.lableStyle ??
                      const TextStyle(
                          color: ColorResource.color666666,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          fontSize: FontSize.fifteen),
                  // const TextStyle(
                  //     fontWeight: FontWeight.w400,
                  //     fontStyle: FontStyle.normal,
                  //     fontSize: FontSize.twelve,
                  //     color: ColorResource.color23375A),

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
        if (widget.isVoiceRecordWidget && isActiveSpeaker && widget.isSubmit)
          const SizedBox(height: 13),
        if (widget.isVoiceRecordWidget &&
            isActiveSpeaker &&
            translateTextController.text != '' &&
            widget.isSubmit)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 13, vertical: 11),
                decoration: const BoxDecoration(
                    color: ColorResource.colorF7F8FA,
                    borderRadius: BorderRadius.all(Radius.circular(60.0))),
                child: CustomText(
                  Languages.of(context)!.remarksRecording,
                  lineHeight: 1,
                  color: ColorResource.color000000,
                ),
              ),
              const SizedBox(width: 5),
              GestureDetector(
                onTap: () {
                  isPlaying ? stopAudio() : playAudio();
                },
                child: CircleAvatar(
                  backgroundColor: ColorResource.color23375A,
                  radius: 15,
                  child: Center(
                    child: Icon(
                      isPlaying ? Icons.stop : Icons.play_arrow,
                      color: ColorResource.colorFFFFFF,
                    ),
                  ),
                ),
              ),
              if (isPlaying) const SizedBox(width: 5),
              if (isPlaying)
                GestureDetector(
                  onTap: () {
                    isPaused ? resumeAudio() : pauseAudio();
                  },
                  child: CircleAvatar(
                    backgroundColor: ColorResource.color23375A,
                    radius: 15,
                    child: Center(
                      child: Icon(
                        isPaused ? Icons.play_arrow : Icons.pause,
                        color: ColorResource.colorFFFFFF,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        if (widget.isVoiceRecordWidget &&
            translateTextController.text != '' &&
            widget.isSubmit)
          const SizedBox(height: 6),
        if (widget.isVoiceRecordWidget &&
            translateTextController.text != '' &&
            widget.isSubmit)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 11),
            decoration: const BoxDecoration(
                color: ColorResource.colorF7F8FA,
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            child: isEdit
                ? TextField(
                    controller: translateTextController,
                    textInputAction: TextInputAction.newline,
                    maxLines: 5,
                    minLines: 1,
                    focusNode: focus,
                    onEditingComplete: () {
                      setState(() {
                        isEdit = false;
                      });
                    },
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                  )
                : CustomText(
                    translateTextController.text,
                    color: ColorResource.color000000,
                  ),
          ),
        if (widget.isVoiceRecordWidget &&
            translateTextController.text != '' &&
            widget.isSubmit)
          const SizedBox(height: 8),
        if (widget.isVoiceRecordWidget &&
            translateTextController.text != '' &&
            widget.isSubmit)
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SizedBox(
                  height: 48,
                  child: CustomButton(
                    Languages.of(context)!.edit.toUpperCase(),
                    cardElevation: 0.5,
                    cardShape: 5.0,
                    onTap: () {
                      setState(() {
                        isEdit = true;
                        focus?.requestFocus();
                      });
                    },
                    buttonBackgroundColor: ColorResource.colorFFFFFF,
                    borderColor: ColorResource.colorDADADA,
                    textColor: ColorResource.color23375A,
                    fontSize: FontSize.twelve,
                    padding: 1,
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: SizedBox(
                  height: 48,
                  child: CustomButton(
                    Languages.of(context)!.okay.toUpperCase(),
                    cardElevation: 2.0,
                    cardShape: 5.0,
                    onTap: () {
                      widget.controller.text = translateTextController.text;
                      setState(() {
                        translateTextController.text = '';
                        isActiveSpeaker = false;
                      });
                      widget.checkRecord!(
                          Constants.none, '', Speech2TextModel());
                      // Here vreturn the value for S2T API respose
                      widget.returnS2Tresponse!(getTranslatedData);
                    },
                    fontSize: FontSize.twelve,
                    padding: 1,
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: CustomCancelButton.cancelButton(
                  context,
                  fontsize: FontSize.twelve,
                  function: () {
                    setState(() {
                      translateTextController.text = '';
                      isActiveSpeaker = false;
                      widget.checkRecord!(
                          Constants.none, '', Speech2TextModel());
                    });
                  },
                ),
              ),
            ],
          )
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
}
