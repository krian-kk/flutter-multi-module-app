import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/models/payment_mode_button_model.dart';
import 'package:origa/models/select_clip_model.dart';
import 'package:origa/models/speech2text_model.dart';
import 'package:origa/screen/case_details_screen/bloc/case_details_bloc.dart';
import 'package:origa/singleton.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/constant_event_values.dart';
import 'package:origa/utils/constants.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/utils/pick_date_time_utils.dart';
import 'package:origa/utils/select_payment_mode_button_widget.dart';
import 'package:origa/widgets/custom_read_only_text_field.dart';
import 'package:origa/widgets/custom_text.dart';

class PhoneUnreachableScreen extends StatefulWidget {
  const PhoneUnreachableScreen({
    Key? key,
    required this.context,
    required this.bloc,
    this.isCallFromCaseDetails = false,
    this.callId,
  }) : super(key: key);

  final BuildContext context;
  final CaseDetailsBloc bloc;
  final bool isCallFromCaseDetails;
  final String? callId;

  @override
  State<PhoneUnreachableScreen> createState() => _PhoneUnreachableScreenState();
}

class _PhoneUnreachableScreenState extends State<PhoneUnreachableScreen> {
  String selectedOptionBottomSheetButton = '';

  @override
  void initState() {
    super.initState();
    widget.bloc.add(ChangeFollowUpDateEvent(
        followUpDate: DateTime.now().add(const Duration(days: 1)).toString()));
  }

  @override
  Widget build(BuildContext context) {
    List<SelectedClipModel> selectedClipList = [
      SelectedClipModel(Languages.of(context)!.lineBusy.toUpperCase()),
      SelectedClipModel(Languages.of(context)!.switchOff.toUpperCase()),
      SelectedClipModel(Languages.of(context)!.rnr.toUpperCase()),
      SelectedClipModel(Languages.of(context)!.outOfNetwork.toUpperCase()),
      SelectedClipModel(Languages.of(context)!.disConnecting.toUpperCase()),
    ];
    List<OptionBottomSheetButtonModel> optionBottomSheetButtonList = [
      OptionBottomSheetButtonModel(
          Languages.of(context)!.otherFeedBack, Constants.otherFeedback),
    ];
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Form(
          key: widget.bloc.phoneUnreachableFormKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Wrap(
                          runSpacing: 10,
                          spacing: 10,
                          children: _buildSelectedClip(selectedClipList),
                        ),
                        const SizedBox(height: 25),
                        // CustomText(
                        //   Languages.of(context)!.nextActionDate,
                        //   color: ColorResource.color666666,
                        //   fontSize: FontSize.twelve,
                        //   fontWeight: FontWeight.w400,
                        //   fontStyle: FontStyle.normal,
                        // ),
                        SizedBox(
                          width: (MediaQuery.of(context).size.width - 62) / 2,
                          child: CustomReadOnlyTextField(
                            Languages.of(context)!.nextActionDate,
                            widget
                                .bloc.phoneUnreachableNextActionDateController,
                            isLabel: true,
                            focusNode: widget
                                .bloc.phoneUnreachableNextActionDateFocusNode,
                            isReadOnly: true,
                            validationRules: const ['required'],
                            onTapped: () => PickDateAndTimeUtils.pickDate(
                                context, (newDate, followUpDate) {
                              if (newDate != null && followUpDate != null) {
                                setState(() {
                                  widget
                                      .bloc
                                      .phoneUnreachableNextActionDateController
                                      .text = newDate;
                                });
                                widget.bloc.add(ChangeFollowUpDateEvent(
                                    followUpDate: followUpDate));
                              }
                            }),
                            suffixWidget: SvgPicture.asset(
                              ImageResource.calendar,
                              fit: BoxFit.scaleDown,
                            ),
                            onEditing: () {
                              widget
                                  .bloc.phoneUnreachableNextActionDateFocusNode
                                  .unfocus();
                              widget.bloc.phoneUnreachableRemarksFocusNode
                                  .requestFocus();
                              widget.bloc.phoneInvalidFormKey.currentState!
                                  .validate();
                            },
                          ),
                        ),
                        const SizedBox(height: 15),
                        Flexible(
                            child: CustomReadOnlyTextField(
                          Languages.of(context)!.remarks,
                          widget.bloc.phoneUnreachableRemarksController,
                          validationRules: const ['required'],
                          isLabel: true,
                          isVoiceRecordWidget: true,
                          returnS2Tresponse: (val) {
                            if (val is Speech2TextModel) {
                              setState(
                                  () => widget.bloc.returnS2TUnReachable = val);
                            }
                          },
                          checkRecord: (isRecord, text, returnS2Tdata) {
                            setState(() {
                              widget.bloc.returnS2TUnReachable = returnS2Tdata;
                              widget.bloc.isRecordUnReachable = isRecord;
                              widget.bloc.translateTextUnReachable = text!;
                              widget.bloc.isTranslateUnReachable = true;
                            });
                          },
                          isSubmit: widget.bloc.isTranslateUnReachable,
                          caseId: widget.bloc.caseId,
                        )),
                        const SizedBox(height: 20),
                        Singleton.instance.contractorInformations?.result
                                    ?.hideCallTriedSmsButton ??
                                true
                            ? const SizedBox()
                            : GestureDetector(
                                onTap: () {
                                  widget.bloc.add(SendSMSEvent(context,
                                      type: Constants.callTriedType));
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: ColorResource.color23375A,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                        color: ColorResource.colorECECEC,
                                        width: 1.0),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.message_rounded,
                                        color: ColorResource.colorffffff,
                                        size: 22,
                                      ),
                                      const SizedBox(width: 5),
                                      CustomText(
                                          Constants.sendSMS.toUpperCase(),
                                          lineHeight: 1.0,
                                          color: ColorResource.colorffffff),
                                    ],
                                  ),
                                ),
                              ),
                        const SizedBox(height: 19),
                        Wrap(
                          spacing: 15,
                          runSpacing: 8,
                          children: SelectPaymentModeButtonWidget
                              .buildOptionBottomSheetOpenButton(
                            optionBottomSheetButtonList,
                            context,
                            (element) {
                              setState(() {
                                selectedOptionBottomSheetButton = element.title;
                              });
                              widget.bloc.add(EventDetailsEvent(
                                element.stringResourceValue,
                                widget.bloc.caseDetailsAPIValue.result
                                    ?.callDetails,
                                true,
                                health: ConstantEventValues.healthOne,
                                isCallFromCallDetails:
                                    widget.isCallFromCaseDetails,
                                callId: widget.callId,
                              ));
                            },
                            selectedOptionBottomSheetButton,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildSelectedClip(List<SelectedClipModel> list) {
    List<Widget> widgets = [];

    for (var element in list) {
      widgets.add(InkWell(
        onTap: () {
          widget.bloc.phoneSelectedUnreadableClip = element.clipTitle;
          setState(() {});
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 11),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: element.clipTitle == widget.bloc.phoneSelectedUnreadableClip
                ? ColorResource.colorFFB800.withOpacity(0.67)
                : ColorResource.colorE7E7E7,
          ),
          child: CustomText(
            element.clipTitle,
            color: ColorResource.color000000,
            fontSize: FontSize.fourteen,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w700,
          ),
        ),
      ));
    }
    return widgets;
  }
}
