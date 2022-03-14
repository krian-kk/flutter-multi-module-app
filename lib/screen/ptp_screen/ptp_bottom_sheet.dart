import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:origa/http/api_repository.dart';
import 'package:origa/http/httpurls.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/models/payment_mode_button_model.dart';
import 'package:origa/models/ptp_post_model/ptp_post_model.dart';
import 'package:origa/models/update_health_model.dart';
import 'package:origa/screen/allocation/bloc/allocation_bloc.dart';
import 'package:origa/screen/case_details_screen/bloc/case_details_bloc.dart';
import 'package:origa/singleton.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/call_status_utils.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/constant_event_values.dart';
import 'package:origa/utils/constants.dart';
import 'package:origa/utils/firebase.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/utils/pick_date_time_utils.dart';
import 'package:origa/widgets/bottomsheet_appbar.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_cancel_button.dart';
import 'package:origa/widgets/custom_loading_widget.dart';
import 'package:origa/widgets/custom_read_only_text_field.dart';
import 'package:origa/widgets/custom_text.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../utils/language_to_constant_convert.dart';

class CustomPtpBottomSheet extends StatefulWidget {
  const CustomPtpBottomSheet(
    this.cardTitle, {
    Key? key,
    required this.caseId,
    required this.customerLoanUserWidget,
    required this.userType,
    required this.bloc,
    this.postValue,
    this.isCall,
    this.isAutoCalling = false,
    this.allocationBloc,
    this.paramValue,
    this.callId,
    this.isCallFromCaseDetails = false,
  }) : super(key: key);
  final String cardTitle;
  final String caseId;
  final Widget customerLoanUserWidget;
  final String userType;
  final bool? isCall;
  final dynamic postValue;
  final bool isAutoCalling;
  final AllocationBloc? allocationBloc;
  final dynamic paramValue;
  final CaseDetailsBloc bloc;
  final bool isCallFromCaseDetails;
  final String? callId;

  @override
  State<CustomPtpBottomSheet> createState() => _CustomPtpBottomSheetState();
}

class _CustomPtpBottomSheetState extends State<CustomPtpBottomSheet> {
  late TextEditingController ptpDateControlller;
  late TextEditingController ptpTimeControlller;
  late TextEditingController ptpAmountControlller;
  late TextEditingController referenceControlller;
  late TextEditingController remarksControlller;
  late TextEditingController loanDurationController;

  late FocusNode ptpAmountFocusNode;
  late FocusNode ptpReferenceFocusNode;
  late FocusNode ptpRemarksFocusNode;

  bool isSubmit = true;

  String selectedPaymentModeButton = '';

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    ptpAmountFocusNode = FocusNode();
    ptpReferenceFocusNode = FocusNode();
    ptpRemarksFocusNode = FocusNode();
    ptpTimeControlller = TextEditingController();
    ptpAmountControlller = TextEditingController();
    referenceControlller = TextEditingController();
    remarksControlller = TextEditingController();
    loanDurationController = TextEditingController();
    ptpDateControlller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    ptpAmountFocusNode.dispose();
    ptpReferenceFocusNode.dispose();
    ptpRemarksFocusNode.dispose();
    ptpTimeControlller.dispose();
    ptpAmountControlller.dispose();
    referenceControlller.dispose();
    remarksControlller.dispose();
    loanDurationController.dispose();
    ptpDateControlller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<PaymentModeButtonModel> paymentModeButtonList = [
      PaymentModeButtonModel(Languages.of(context)!.cheque),
      PaymentModeButtonModel(Languages.of(context)!.selfPay),
    ];

    return BlocListener<CaseDetailsBloc, CaseDetailsState>(
      bloc: widget.bloc,
      listener: (context, state) {
        if (state is UpdateHealthStatusState) {
          UpdateHealthStatusModel data = UpdateHealthStatusModel.fromJson(
              Map<String, dynamic>.from(Singleton.instance.updateHealthStatus));
          setState(() {
            switch (data.tabIndex) {
              case 0:
                widget.bloc.caseDetailsAPIValue.result
                    ?.callDetails![data.selectedHealthIndex!]['health'] = '2';
                break;
              case 1:
                widget.bloc.caseDetailsAPIValue.result
                    ?.callDetails![data.selectedHealthIndex!]['health'] = '1';
                break;
              case 2:
                widget.bloc.caseDetailsAPIValue.result
                    ?.callDetails![data.selectedHealthIndex!]['health'] = '0';
                break;
              default:
                widget.bloc.caseDetailsAPIValue.result
                        ?.callDetails![data.selectedHealthIndex!]['health'] =
                    data.currentHealth;
                break;
            }
          });
        }
      },
      child: BlocBuilder<CaseDetailsBloc, CaseDetailsState>(
        bloc: widget.bloc,
        builder: (context, state) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.89,
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              backgroundColor: Colors.transparent,
              body: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  BottomSheetAppbar(
                    title: widget.cardTitle,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 15)
                            .copyWith(bottom: 5),
                  ),
                  Expanded(
                    child: KeyboardActions(
                      config: KeyboardActionsConfig(
                        keyboardActionsPlatform: KeyboardActionsPlatform.IOS,
                        actions: [
                          KeyboardActionsItem(
                            focusNode: ptpAmountFocusNode,
                            displayArrows: false,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: SingleChildScrollView(
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                widget.customerLoanUserWidget,
                                const SizedBox(height: 11),
                                Row(
                                  children: [
                                    Flexible(
                                        child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        CustomText(
                                          Languages.of(context)!.ptpDate,
                                          fontSize: FontSize.twelve,
                                          fontWeight: FontWeight.w400,
                                          color: ColorResource.color666666,
                                          fontStyle: FontStyle.normal,
                                        ),
                                        SizedBox(
                                          width: (MediaQuery.of(context)
                                                  .size
                                                  .width) /
                                              2,
                                          child: CustomReadOnlyTextField(
                                            // Languages.of(context)!.ptpDate,
                                            '',
                                            ptpDateControlller,
                                            // isLabel: true,
                                            isReadOnly: true,
                                            validationRules: const ['required'],
                                            onTapped: () =>
                                                PickDateAndTimeUtils.pickDate(
                                                    context,
                                                    (newDate, followUpDate) {
                                              if (newDate != null &&
                                                  followUpDate != null) {
                                                setState(() {
                                                  ptpDateControlller.text =
                                                      newDate;
                                                });
                                                widget.bloc.add(
                                                    ChangeFollowUpDateEvent(
                                                        followUpDate:
                                                            followUpDate));
                                              }
                                            }),
                                            suffixWidget: SvgPicture.asset(
                                              ImageResource.calendar,
                                              fit: BoxFit.scaleDown,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                                    const SizedBox(width: 7),
                                    Flexible(
                                        child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        CustomText(
                                          Languages.of(context)!.ptpTime,
                                          fontSize: FontSize.twelve,
                                          fontWeight: FontWeight.w400,
                                          color: ColorResource.color666666,
                                          fontStyle: FontStyle.normal,
                                        ),
                                        SizedBox(
                                          width: (MediaQuery.of(context)
                                                  .size
                                                  .width) /
                                              2,
                                          child: CustomReadOnlyTextField(
                                            // Languages.of(context)!.ptpTime,
                                            '',
                                            ptpTimeControlller,
                                            // isLabel: true,
                                            validatorCallBack: () {},
                                            isReadOnly: true,
                                            validationRules: const ['required'],
                                            onTapped: () =>
                                                PickDateAndTimeUtils.pickTime(
                                                    context, (newTime) {
                                              if (newTime != null) {
                                                setState(() {
                                                  ptpTimeControlller.text =
                                                      newTime;
                                                });
                                              }
                                            }),
                                            suffixWidget: SvgPicture.asset(
                                              ImageResource.clock,
                                              fit: BoxFit.scaleDown,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                                  ],
                                ),
                                const SizedBox(height: 15),
                                Flexible(
                                    child: CustomReadOnlyTextField(
                                  Languages.of(context)!.ptpAmount,
                                  ptpAmountControlller,
                                  focusNode: ptpAmountFocusNode,
                                  validatorCallBack: () {},
                                  keyBoardType: TextInputType.number,
                                  validationRules: const ['required'],
                                  isLabel: true,
                                  isNumberOnly: true,
                                  onEditing: () {
                                    ptpReferenceFocusNode.requestFocus();
                                    _formKey.currentState!.validate();
                                  },
                                )),
                                const SizedBox(height: 15),
                                CustomText(
                                  Languages.of(context)!.paymentMode,
                                  fontSize: FontSize.fourteen,
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.normal,
                                  color: ColorResource.color101010,
                                ),
                                const SizedBox(height: 8),
                                Wrap(
                                  runSpacing: 9,
                                  spacing: 10,
                                  children: _buildPaymentButton(
                                      paymentModeButtonList),
                                ),
                                const SizedBox(height: 21),
                                CustomReadOnlyTextField(
                                    Languages.of(context)!.reference.substring(
                                        0,
                                        Languages.of(context)!
                                                .reference
                                                .length -
                                            1),
                                    referenceControlller,
                                    focusNode: ptpReferenceFocusNode,
                                    isLabel: true,
                                    validatorCallBack: () {}, onEditing: () {
                                  ptpRemarksFocusNode.requestFocus();
                                  _formKey.currentState!.validate();
                                }),
                                const SizedBox(height: 20),
                                CustomReadOnlyTextField(
                                    Languages.of(context)!.remarks,
                                    remarksControlller,
                                    focusNode: ptpRemarksFocusNode,
                                    validationRules: const ['required'],
                                    isLabel: true,
                                    // suffixWidget: VoiceRecodingWidget(),
                                    validatorCallBack: () {}, onEditing: () {
                                  ptpRemarksFocusNode.unfocus();
                                  _formKey.currentState!.validate();
                                }),
                                const SizedBox(height: 15)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              bottomNavigationBar: Container(
                height: MediaQuery.of(context).size.height * 0.1,
                decoration: BoxDecoration(
                  color: ColorResource.colorFFFFFF,
                  boxShadow: [
                    BoxShadow(
                      color: ColorResource.color000000.withOpacity(.25),
                      blurRadius: 2.0,
                      offset: const Offset(1.0, 1.0),
                    ),
                  ],
                ),
                width: double.infinity,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Singleton.instance.startCalling ?? false
                          ? const SizedBox()
                          : Expanded(
                              child: CustomCancelButton.cancelButton(context),
                            ),
                      SizedBox(
                          width: Singleton.instance.startCalling ?? false
                              ? 0
                              : 25),
                      Singleton.instance.startCalling ?? false
                          ? SizedBox(
                              width: Singleton.instance.startCalling ?? false
                                  ? 150
                                  : 191,
                              child: CustomButton(
                                isSubmit
                                    ? Languages.of(context)!
                                            .stop
                                            .toUpperCase() +
                                        ' & \n' +
                                        Languages.of(context)!
                                            .submit
                                            .toUpperCase()
                                    : null,
                                isLeading: !isSubmit,
                                trailingWidget: CustomLoadingWidget(
                                  gradientColors: [
                                    ColorResource.colorFFFFFF,
                                    ColorResource.colorFFFFFF.withOpacity(0.7),
                                  ],
                                ),
                                fontSize: FontSize.sixteen,
                                fontWeight: FontWeight.w600,
                                onTap: isSubmit
                                    ? () => submitPTPEvent(true)
                                    : () {},
                                cardShape: 5,
                              ),
                            )
                          : const SizedBox(),
                      SizedBox(
                        width: Singleton.instance.startCalling ?? false
                            ? 150
                            : 191,
                        child: CustomButton(
                          isSubmit
                              ? Languages.of(context)!.submit.toUpperCase()
                              : null,
                          isLeading: !isSubmit,
                          trailingWidget: CustomLoadingWidget(
                            gradientColors: [
                              ColorResource.colorFFFFFF,
                              ColorResource.colorFFFFFF.withOpacity(0.7),
                            ],
                          ),
                          fontSize: FontSize.sixteen,
                          fontWeight: FontWeight.w600,
                          onTap: isSubmit ? () => submitPTPEvent(false) : () {},
                          cardShape: 5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  submitPTPEvent(bool stopValue) async {
    if (_formKey.currentState!.validate()) {
      if (selectedPaymentModeButton != '') {
        setState(() => isSubmit = false);
        bool isNotAutoCalling = true;
        if (widget.isAutoCalling ||
            (widget.isCallFromCaseDetails && widget.callId != null)) {
          await CallCustomerStatus.callStatusCheck(
            callId: (widget.isCallFromCaseDetails)
                ? widget.callId
                : widget.paramValue['callId'],
            context: context,
          ).then((value) {
            isNotAutoCalling = value;
          });
        }
        if (isNotAutoCalling) {
          Position position = Position(
            longitude: 0,
            latitude: 0,
            timestamp: DateTime.now(),
            accuracy: 0,
            altitude: 0,
            heading: 0,
            speed: 0,
            speedAccuracy: 0,
          );
          if (Geolocator.checkPermission().toString() !=
              PermissionStatus.granted.toString()) {
            Position res = await Geolocator.getCurrentPosition(
                desiredAccuracy: LocationAccuracy.best);

            setState(() {
              position = res;
            });
          }
          var requestBodyData = PTPPostModel(
            eventId: ConstantEventValues.ptpEventId,
            eventType:
                (widget.userType == Constants.telecaller || widget.isCall!)
                    ? 'TC : PTP'
                    : 'PTP',
            eventCode: ConstantEventValues.ptpEventCode,
            caseId: widget.caseId,
            eventAttr: EventAttr(
              pTPType: ConstantEventValues.ptpType,
              date: ptpDateControlller.text,
              time: ptpTimeControlller.text,
              remarks: remarksControlller.text,
              ptpAmount: int.parse(ptpAmountControlller.text),
              reference: referenceControlller.text,
              mode: ConvertString.convertLanguageToConstant(
                  selectedPaymentModeButton, context),
              followUpPriority: 'PTP',
              longitude: position.longitude,
              latitude: position.latitude,
              accuracy: position.accuracy,
              altitude: position.altitude,
              heading: position.heading,
              speed: position.speed,
            ),
            callID: Singleton.instance.callID ?? " ",
            callingID: Singleton.instance.callingID ?? " ",
            callerServiceID: Singleton.instance.callerServiceID ?? " ",
            voiceCallEventCode: ConstantEventValues.voiceCallEventCode,
            createdBy: Singleton.instance.agentRef ?? '',
            agentName: Singleton.instance.agentName ?? '',
            contractor: Singleton.instance.contractor ?? '',
            eventModule: widget.isCall! ? 'Telecalling' : 'Field Allocation',
            agrRef:
                widget.bloc.caseDetailsAPIValue.result?.caseDetails?.agrRef ??
                    '',
            contact: PTPContact(
              cType: widget.postValue['cType'],
              value: widget.postValue['value'],
              health: ConstantEventValues.ptpHealth,
              resAddressId0: Singleton.instance.resAddressId_0 ?? '',
              contactId0: Singleton.instance.contactId_0 ?? '',
            ),
          );

         /* if (ConnectivityResult.none ==
              await Connectivity().checkConnectivity()) {
            FirebaseUtils.storeEvents(
                eventsDetails: requestBodyData.toJson(), caseId: widget.caseId);
          } else {
            Map<String, dynamic> postResult = await APIRepository.apiRequest(
              APIRequestType.post,
              HttpUrl.ptpPostUrl(
                'ptp',
                widget.userType,
              ),
              requestBodydata: jsonEncode(requestBodyData),
            );
            if (postResult[Constants.success]) {
              widget.bloc.add(
                ChangeIsSubmitForMyVisitEvent(
                  Constants.ptp,
                ),
              );
              if (!(widget.userType == Constants.fieldagent &&
                  widget.isCall!)) {
                widget.bloc.add(
                  ChangeIsSubmitEvent(
                    selectedClipValue: Constants.ptp,
                    chageFollowUpDate: ptpDateControlller.text,
                  ),
                );
              }

              widget.bloc.add(
                ChangeHealthStatusEvent(),
              );

              if (widget.isAutoCalling) {
                Navigator.pop(widget.paramValue['context']);
                Navigator.pop(widget.paramValue['context']);
                Singleton.instance.startCalling = false;
                if (!stopValue) {
                  widget.allocationBloc!.add(StartCallingEvent(
                    customerIndex: widget.paramValue['customerIndex'] + 1,
                    phoneIndex: 0,
                    isIncreaseCount: true,
                  ));
                } else {
                  widget.allocationBloc!.add(ConnectedStopAndSubmitEvent(
                    customerIndex: widget.paramValue['customerIndex'],
                  ));
                }
              } else {
                AppUtils.topSnackBar(context, Constants.successfullySubmitted);
                Navigator.pop(context);
              }
            }
          }*/
          FirebaseUtils.storeEvents(
              eventsDetails: requestBodyData.toJson(), caseId: widget.caseId);
        }
      } else {
        AppUtils.showToast(Languages.of(context)!.pleaseSelectPaymentMode);
      }
    }
    setState(() => isSubmit = true);
  }

  List<Widget> _buildPaymentButton(List<PaymentModeButtonModel> list) {
    List<Widget> widgets = [];
    for (var element in list) {
      widgets.add(InkWell(
        onTap: () {
          setState(() {
            selectedPaymentModeButton = element.title;
          });
        },
        child: Container(
          width: 156,
          height: 50,
          decoration: BoxDecoration(
              color: element.title == selectedPaymentModeButton
                  ? ColorResource.color23375A
                  : ColorResource.colorBEC4CF,
              boxShadow: [
                BoxShadow(
                  color: ColorResource.color000000.withOpacity(0.2),
                  blurRadius: 2.0,
                  offset: const Offset(1.0, 1.0),
                )
              ],
              borderRadius: const BorderRadius.all(Radius.circular(50.0))),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 19,
                  backgroundColor: ColorResource.colorFFFFFF,
                  child: Center(
                    child: SvgPicture.asset(ImageResource.money),
                  ),
                ),
                const SizedBox(width: 6),
                Flexible(
                  child: CustomText(
                    element.title,
                    color: ColorResource.colorFFFFFF,
                    fontWeight: FontWeight.w700,
                    lineHeight: 1,
                    fontSize: FontSize.sixteen,
                    fontStyle: FontStyle.normal,
                  ),
                )
              ],
            ),
          ),
        ),
      ));
    }
    return widgets;
  }
}
