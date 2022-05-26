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
import 'package:origa/utils/pick_date_time_utils.dart';
import 'package:origa/utils/select_payment_mode_button_widget.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_read_only_text_field.dart';
import 'package:origa/widgets/custom_text.dart';

class CustomerNotMetScreen extends StatefulWidget {
  const CustomerNotMetScreen({
    Key? key,
    required this.context,
    required this.bloc,
  }) : super(key: key);

  final BuildContext context;
  final CaseDetailsBloc bloc;

  @override
  State<CustomerNotMetScreen> createState() => _CustomerNotMetScreenState();
}

class _CustomerNotMetScreenState extends State<CustomerNotMetScreen> {
  String selectedOptionBottomSheetButton = '';
  double bottomHeight = 0.0;

  @override
  void initState() {
    super.initState();
    widget.bloc.add(ChangeFollowUpDateEvent(
        followUpDate: DateTime.now().add(const Duration(days: 3)).toString()));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<SelectedClipModel> selectedClipList = <SelectedClipModel>[
      SelectedClipModel(Languages.of(context)!.leftMessage.toUpperCase()),
      SelectedClipModel(Languages.of(context)!.doorLocked.toUpperCase()),
      SelectedClipModel(Languages.of(context)!.entryRestricted.toUpperCase()),
    ];

    final List<OptionBottomSheetButtonModel> optionBottomSheetButtonList =
        <OptionBottomSheetButtonModel>[
      // OptionBottomSheetButtonModel(
      //     Languages.of(context)!.addNewContact, Constants.addNewContact),
      OptionBottomSheetButtonModel(Languages.of(context)!.repo, Constants.repo),
    ];
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Form(
        key: widget.bloc.addressCustomerNotMetFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: Scaffold(
                resizeToAvoidBottomInset: true,
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Wrap(
                          runSpacing: 10,
                          spacing: 10,
                          children: _buildSelectedClip(selectedClipList),
                        ),
                        const SizedBox(height: 25),
                        SizedBox(
                          width: (MediaQuery.of(context).size.width - 62) / 2,
                          child: CustomReadOnlyTextField(
                            Languages.of(context)!.nextActionDate,
                            widget.bloc
                                .addressCustomerNotMetNextActionDateController,
                            isLabel: true,
                            focusNode: widget.bloc
                                .addressCustomerNotMetNextActionDateFocusNode,
                            isReadOnly: true,
                            validationRules: const <String>['required'],
                            onTapped: () =>
                                PickDateAndTimeUtils.pickDate(context,
                                    (String? newDate, String? followUpDate) {
                              if (newDate != null && followUpDate != null) {
                                setState(() {
                                  widget
                                      .bloc
                                      .addressCustomerNotMetNextActionDateController
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
                              widget.bloc
                                  .addressCustomerNotMetNextActionDateFocusNode
                                  .unfocus();
                              widget.bloc.addressCustomerNotMetRemarksFocusNode
                                  .requestFocus();
                            },
                          ),
                        ),
                        const SizedBox(height: 15),
                        Flexible(
                            child: CustomReadOnlyTextField(
                          Languages.of(context)!.remarks.replaceAll('*', ''),
                          widget.bloc.addressCustomerNotMetRemarksController,
                          // validationRules: const <String>['required'],
                          isLabel: true,
                          isVoiceRecordWidget: true,
                          returnS2Tresponse: (dynamic val) {
                            if (val is Speech2TextModel) {
                              setState(() =>
                                  widget.bloc.returnS2TCustomerNotMet = val);
                            }
                          },
                          editStringCallBack: ((dynamic values) {
                            setState(() {
                              bottomHeight = (values == '')
                                  ? 0.0
                                  : MediaQuery.of(context).size.height * 0.1;
                            });
                          }),
                          checkRecord: (String? isRecord, String? text,
                              Speech2TextModel returnS2Tdata) {
                            setState(() {
                              widget.bloc.returnS2TCustomerNotMet =
                                  returnS2Tdata;
                              widget.bloc.isRecordCustomerNotMet = isRecord;
                              widget.bloc.translateTextCustomerNotMet = text!;
                              widget.bloc.isTranslateCustomerNotMet = true;
                            });
                          },
                          isSubmit: widget.bloc.isTranslateCustomerNotMet,
                          caseId: widget.bloc.caseId,
                        )),
                        const SizedBox(height: 19),
                        CustomButton(
                          Languages.of(context)!.captureImage.toUpperCase(),
                          cardShape: 75.0,
                          textColor: ColorResource.color23375A,
                          fontSize: FontSize.sixteen,
                          onTap: () => widget.bloc.add(EventDetailsEvent(
                            Constants.captureImage,
                            widget.bloc.caseDetailsAPIValue.result
                                ?.addressDetails,
                            false,
                            health: ConstantEventValues.healthOne,
                          )),
                          fontWeight: FontWeight.w700,
                          padding: 15.0,
                          borderColor: ColorResource.colorBEC4CF,
                          buttonBackgroundColor: ColorResource.colorBEC4CF,
                          isLeading: true,
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
                            (OptionBottomSheetButtonModel element) {
                              setState(() {
                                selectedOptionBottomSheetButton = element.title;
                              });
                              widget.bloc.add(
                                EventDetailsEvent(
                                  element.stringResourceValue,
                                  widget.bloc.caseDetailsAPIValue.result
                                      ?.addressDetails,
                                  false,
                                  health: ConstantEventValues.healthOne,
                                ),
                              );
                            },
                            selectedOptionBottomSheetButton,
                          ),
                        ),
                        SizedBox(height: bottomHeight),
                      ],
                    ),
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
    final List<Widget> widgets = <Widget>[];
    for (SelectedClipModel element in list) {
      widgets.add(InkWell(
        onTap: () {
          widget.bloc.addressSelectedCustomerNotMetClip = element.clipTitle;
          setState(() {});
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 11),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: element.clipTitle ==
                    widget.bloc.addressSelectedCustomerNotMetClip
                ? ColorResource.colorFFB800.withOpacity(0.67)
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
