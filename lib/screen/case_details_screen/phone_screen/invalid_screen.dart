import 'package:flutter/material.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/models/payment_mode_button_model.dart';
import 'package:origa/models/select_clip_model.dart';
import 'package:origa/models/speech2text_model.dart';
import 'package:origa/screen/case_details_screen/bloc/case_details_bloc.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/constant_event_values.dart';
import 'package:origa/utils/constants.dart';
import 'package:origa/utils/select_payment_mode_button_widget.dart';
import 'package:origa/widgets/custom_read_only_text_field.dart';
import 'package:origa/widgets/custom_text.dart';

class PhonenInvalidScreen extends StatefulWidget {
  const PhonenInvalidScreen({
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
  State<PhonenInvalidScreen> createState() => _PhonenInvalidScreenState();
}

class _PhonenInvalidScreenState extends State<PhonenInvalidScreen> {
  String selectedOptionBottomSheetButton = '';
  @override
  Widget build(BuildContext context) {
    final List<SelectedClipModel> selectedClipList = [
      SelectedClipModel(Languages.of(context)!.doesNotExist.toUpperCase()),
      SelectedClipModel(Languages.of(context)!.incorrectNumber.toUpperCase()),
      SelectedClipModel(Languages.of(context)!.numberNotWorking.toUpperCase()),
      SelectedClipModel(Languages.of(context)!.notOperational.toUpperCase()),
    ];
    final List<OptionBottomSheetButtonModel> optionBottomSheetButtonList = [
      OptionBottomSheetButtonModel(
          Languages.of(context)!.otherFeedBack, Constants.otherFeedback),
    ];
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Form(
          key: widget.bloc.phoneInvalidFormKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Wrap(
                          runSpacing: 10,
                          spacing: 10,
                          children: _buildSelectedClip(selectedClipList),
                        ),
                        const SizedBox(height: 15),
                        Flexible(
                            child: CustomReadOnlyTextField(
                          Languages.of(context)!.remarks,
                          widget.bloc.phoneInvalidRemarksController,
                          validationRules: const ['required'],
                          isLabel: true,
                          isVoiceRecordWidget: true,
                          returnS2Tresponse: (val) {
                            if (val is Speech2TextModel) {
                              setState(() =>
                                  widget.bloc.returnS2TPhoneInvalid = val);
                            }
                          },
                          checkRecord: (isRecord, text, returnS2Tdata) {
                            setState(() {
                              widget.bloc.returnS2TPhoneInvalid = returnS2Tdata;
                              widget.bloc.isRecordPhoneInvalid = isRecord;
                              widget.bloc.translateTextPhoneInvalid = text!;
                              widget.bloc.isTranslatePhoneInvalid = true;
                            });
                          },
                          isSubmit: widget.bloc.isTranslatePhoneInvalid,
                          caseId: widget.bloc.caseId,
                        )),
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
                                health: ConstantEventValues.healthZero,
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
    final List<Widget> widgets = [];
    for (var element in list) {
      widgets.add(InkWell(
        onTap: () {
          widget.bloc.phoneSelectedInvalidClip = element.clipTitle;
          setState(() {});
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 11),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: element.clipTitle == widget.bloc.phoneSelectedInvalidClip
                ? ColorResource.colorF1BCC4
                : ColorResource.colorE7E7E7,
          ),
          child: CustomText(
            element.clipTitle,
            color: ColorResource.color000000,
            fontWeight: FontWeight.w700,
          ),
        ),
      ));
    }
    return widgets;
  }
}
