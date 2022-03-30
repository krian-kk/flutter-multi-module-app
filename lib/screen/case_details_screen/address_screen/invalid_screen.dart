import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/models/payment_mode_button_model.dart';
import 'package:origa/models/select_clip_model.dart';
import 'package:origa/models/speech2text_model.dart';
import 'package:origa/screen/case_details_screen/bloc/case_details_bloc.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/constant_event_values.dart';
import 'package:origa/utils/constants.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/utils/select_payment_mode_button_widget.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_read_only_text_field.dart';
import 'package:origa/widgets/custom_text.dart';

class AddressInvalidScreen extends StatefulWidget {
  const AddressInvalidScreen(
      {Key? key, required this.context, required this.bloc})
      : super(key: key);

  final BuildContext context;
  final CaseDetailsBloc bloc;

  @override
  State<AddressInvalidScreen> createState() => _AddressInvalidScreenState();
}

class _AddressInvalidScreenState extends State<AddressInvalidScreen> {
  String selectedOptionBottomSheetButton = '';

  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List<SelectedClipModel> selectedClipList = [
      SelectedClipModel(Languages.of(context)!.wrongAddress),
      SelectedClipModel(Languages.of(context)!.shifted),
      SelectedClipModel(Languages.of(context)!.addressNotFound),
    ];

    List<OptionBottomSheetButtonModel> optionBottomSheetButtonList = [
      OptionBottomSheetButtonModel(Languages.of(context)!.repo, Constants.repo),
      OptionBottomSheetButtonModel(
          Languages.of(context)!.otherFeedBack, Constants.otherFeedback),
    ];
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Form(
        key: widget.bloc.addressInvalidFormKey,
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
                      const SizedBox(height: 15),
                      Flexible(
                          child: CustomReadOnlyTextField(
                        Languages.of(context)!.remarks,
                        widget.bloc.addressInvalidRemarksController,
                        validationRules: const ['required'],
                        isLabel: true,
                        isVoiceRecordWidget: true,
                        returnS2Tresponse: (val) {
                          if (val is Speech2TextModel) {
                            setState(() =>
                                widget.bloc.returnS2TAddressInvalid = val);
                          }
                        },
                        checkRecord: (isRecord, text, returnS2T) {
                          setState(() {
                            widget.bloc.returnS2TAddressInvalid = returnS2T;
                            widget.bloc.isRecordAddressInvaild = isRecord;
                            widget.bloc.translateTextAddressInvalid = text!;
                            widget.bloc.isTranslateAddressInvalid = true;
                          });
                        },
                        isSubmit: widget.bloc.isTranslateAddressInvalid,
                        caseId: widget.bloc.caseId,
                      )),
                      const SizedBox(height: 19),
                      CustomButton(
                        Languages.of(context)!.captureImage.toUpperCase(),
                        cardShape: 75.0,
                        textColor: ColorResource.color23375A,
                        fontSize: FontSize.sixteen,
                        fontWeight: FontWeight.w700,
                        padding: 15.0,
                        borderColor: ColorResource.colorBEC4CF,
                        buttonBackgroundColor: ColorResource.colorBEC4CF,
                        isLeading: true,
                        onTap: () => widget.bloc.add(EventDetailsEvent(
                            Constants.captureImage,
                            widget.bloc.caseDetailsAPIValue.result
                                ?.addressDetails,
                            false,
                            health: '0')),
                        trailingWidget:
                            SvgPicture.asset(ImageResource.captureImage),
                      ),
                      const SizedBox(height: 20),
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
                                    ?.addressDetails,
                                false,
                                health: ConstantEventValues.healthZero));
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
    );
  }

  List<Widget> _buildSelectedClip(List<SelectedClipModel> list) {
    List<Widget> widgets = [];
    for (var element in list) {
      widgets.add(InkWell(
        onTap: () {
          widget.bloc.addressSelectedInvalidClip = element.clipTitle;
          setState(() {});
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 11),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: element.clipTitle == widget.bloc.addressSelectedInvalidClip
                ? ColorResource.colorF1BCC4
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
