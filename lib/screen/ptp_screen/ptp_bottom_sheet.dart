import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:domain_models/response_models/events/ptp/ptp_request_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:languages/language_english.dart';
import 'package:network_helper/errors/network_exception.dart';
import 'package:network_helper/network_base_models/api_result.dart';
import 'package:network_helper/network_base_models/base_response.dart';
import 'package:origa/models/payment_mode_button_model.dart';
import 'package:origa/models/speech2text_model.dart';
import 'package:origa/models/update_health_model.dart';
import 'package:origa/singleton.dart';
import 'package:origa/src/features/case_details_screen/bloc/case_details_bloc.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/call_status_utils.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/constant_event_values.dart';
import 'package:origa/utils/constants.dart';
import 'package:origa/utils/firebase.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/utils/language_to_constant_convert.dart';
import 'package:origa/utils/pick_date_time_utils.dart';
import 'package:origa/widgets/bottomsheet_appbar.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_cancel_button.dart';
import 'package:origa/widgets/custom_loading_widget.dart';
import 'package:origa/widgets/custom_read_only_text_field.dart';
import 'package:origa/widgets/custom_text.dart';
import 'package:origa/widgets/get_followuppriority_value.dart'
    show EventFollowUpPriority;
import 'package:repository/case_repository.dart';

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
    // this.allocationBloc,
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

  //todo
  // final AllocationBloc? allocationBloc;
  final dynamic paramValue;
  final CaseDetailsBloc bloc;
  final bool isCallFromCaseDetails;
  final String? callId;

  @override
  State<CustomPtpBottomSheet> createState() => _CustomPtpBottomSheetState();
}

class _CustomPtpBottomSheetState extends State<CustomPtpBottomSheet> {
  late TextEditingController ptpDateController;
  late TextEditingController ptpTimeController;
  late TextEditingController ptpAmountController;
  late TextEditingController referenceController;
  late TextEditingController remarksController;
  late TextEditingController loanDurationController;

  String? isRecord;
  String translateText = '';
  bool isTranslate = true;

  late FocusNode ptpAmountFocusNode;
  late FocusNode ptpReferenceFocusNode;
  late FocusNode ptpRemarksFocusNode;

  bool isSubmit = true;

  String selectedPaymentModeButton = '';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//Returned speech to text AAPI data
  Speech2TextModel returnS2Tdata = Speech2TextModel();

  @override
  void initState() {
    ptpAmountFocusNode = FocusNode();
    ptpReferenceFocusNode = FocusNode();
    ptpRemarksFocusNode = FocusNode();
    ptpTimeController = TextEditingController();
    ptpAmountController = TextEditingController();
    referenceController = TextEditingController();
    remarksController = TextEditingController();
    loanDurationController = TextEditingController();
    ptpDateController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    ptpAmountFocusNode.dispose();
    ptpReferenceFocusNode.dispose();
    ptpRemarksFocusNode.dispose();
    ptpTimeController.dispose();
    ptpAmountController.dispose();
    referenceController.dispose();
    remarksController.dispose();
    loanDurationController.dispose();
    ptpDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<PaymentModeButtonModel> paymentModeButtonList =
        <PaymentModeButtonModel>[
      PaymentModeButtonModel(LanguageEn().pickUp),
      PaymentModeButtonModel(LanguageEn().selfPay),
    ];

    return BlocListener<CaseDetailsBloc, CaseDetailsState>(
      bloc: widget.bloc,
      listener: (BuildContext context, CaseDetailsState state) {
        if (state is UpdateHealthStatusState) {
          final UpdateHealthStatusModel data = UpdateHealthStatusModel.fromJson(
              Map<String, dynamic>.from(Singleton.instance.updateHealthStatus));
          setState(() {
            switch (data.tabIndex) {
              case 0:
                widget.bloc.caseDetailsAPIValue
                    .callDetails![data.selectedHealthIndex!]['health'] = '2';
                break;
              case 1:
                widget.bloc.caseDetailsAPIValue
                    .callDetails![data.selectedHealthIndex!]['health'] = '1';
                break;
              case 2:
                widget.bloc.caseDetailsAPIValue
                    .callDetails![data.selectedHealthIndex!]['health'] = '0';
                break;
              default:
                widget.bloc.caseDetailsAPIValue
                        .callDetails![data.selectedHealthIndex!]['health'] =
                    data.currentHealth;
                break;
            }
          });
        }
      },
      child: BlocBuilder<CaseDetailsBloc, CaseDetailsState>(
        bloc: widget.bloc,
        builder: (BuildContext context, CaseDetailsState state) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.89,
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              backgroundColor: Colors.transparent,
              body: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  BottomSheetAppbar(
                    title: widget.cardTitle,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 15)
                            .copyWith(bottom: 5),
                  ),
                  Expanded(
                    child: KeyboardActions(
                      enable: (Platform.isIOS),
                      config: KeyboardActionsConfig(
                        keyboardActionsPlatform: KeyboardActionsPlatform.IOS,
                        actions: <KeyboardActionsItem>[
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
                                  children: <Widget>[
                                    Flexible(
                                      child: CustomReadOnlyTextField(
                                        LanguageEn().ptpDate,
                                        ptpDateController,
                                        isLabel: true,
                                        isReadOnly: true,
                                        validationRules: const <String>[
                                          'required'
                                        ],
                                        onTapped: () =>
                                            PickDateAndTimeUtils.pickDate(
                                                context, (String? newDate,
                                                    String? followUpDate) {
                                          if (newDate != null &&
                                              followUpDate != null) {
                                            setState(() {
                                              ptpDateController.text = newDate;
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
                                    const SizedBox(width: 7),
                                    Flexible(
                                        child: CustomReadOnlyTextField(
                                      LanguageEn().ptpTime,
                                      ptpTimeController,
                                      validatorCallBack: () {},
                                      isReadOnly: true,
                                      isLabel: true,
                                      validationRules: const <String>[
                                        'required'
                                      ],
                                      onTapped: () =>
                                          PickDateAndTimeUtils.pickTime(context,
                                              (String? newTime) {
                                        if (newTime != null) {
                                          setState(() {
                                            ptpTimeController.text = newTime;
                                          });
                                        }
                                      }),
                                      suffixWidget: SvgPicture.asset(
                                        ImageResource.clock,
                                        fit: BoxFit.scaleDown,
                                      ),
                                    )),
                                  ],
                                ),
                                const SizedBox(height: 15),
                                Flexible(
                                    child: CustomReadOnlyTextField(
                                  LanguageEn().ptpAmount,
                                  ptpAmountController,
                                  focusNode: ptpAmountFocusNode,
                                  validatorCallBack: () {},
                                  keyBoardType: TextInputType.number,
                                  validationRules: const <String>['required'],
                                  lableStyle: const TextStyle(
                                      color: ColorResource.color666666,
                                      fontFamily: 'Lato',
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                      fontSize: FontSize.fifteen),
                                  isLabel: true,
                                  isNumberOnly: true,
                                  onEditing: () {
                                    ptpReferenceFocusNode.requestFocus();
                                    _formKey.currentState!.validate();
                                  },
                                )),
                                const SizedBox(height: 15),
                                CustomText(
                                  LanguageEn().paymentMode,
                                  fontWeight: FontWeight.w700,
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
                                    LanguageEn().reference.substring(
                                        0, LanguageEn().reference.length - 1),
                                    referenceController,
                                    focusNode: ptpReferenceFocusNode,
                                    isLabel: true,
                                    validatorCallBack: () {}, onEditing: () {
                                  ptpRemarksFocusNode.requestFocus();
                                  _formKey.currentState!.validate();
                                }),
                                const SizedBox(height: 20),
                                CustomReadOnlyTextField(
                                    LanguageEn().remarks, remarksController,
                                    focusNode: ptpRemarksFocusNode,
                                    validationRules: const <String>['required'],
                                    isLabel: true,
                                    isVoiceRecordWidget: true,
                                    checkRecord: (String? isRecord,
                                        String? text,
                                        Speech2TextModel returnS2Tdata) {
                                      setState(() {
                                        this.returnS2Tdata = returnS2Tdata;
                                        this.isRecord = isRecord;
                                        translateText = text!;
                                        isTranslate = true;
                                      });
                                    },
                                    isSubmit: isTranslate,
                                    returnS2Tresponse: (dynamic val) {
                                      if (val is Speech2TextModel) {
                                        setState(() {
                                          returnS2Tdata = val;
                                        });
                                      }
                                    },
                                    // suffixWidget: VoiceRecodingWidget(),
                                    validatorCallBack: () {},
                                    onEditing: () {
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
                  boxShadow: <BoxShadow>[
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
                    children: <Widget>[
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
                                    ? '${LanguageEn().stop.toUpperCase()} & \n${LanguageEn().submit.toUpperCase()}'
                                    : null,
                                isLeading: !isSubmit,
                                trailingWidget: CustomLoadingWidget(
                                  gradientColors: <Color>[
                                    ColorResource.colorFFFFFF,
                                    ColorResource.colorFFFFFF.withOpacity(0.7),
                                  ],
                                ),
                                fontSize: FontSize.sixteen,
                                onTap: isSubmit
                                    ? () async {
                                        if (await AppUtils.checkGPSConnection(
                                            context)) {
                                          if (await AppUtils
                                              .checkLocationPermission(
                                                  context)) {
                                            submitPTPEvent(true);
                                          }
                                        }
                                      }
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
                          isSubmit ? LanguageEn().submit.toUpperCase() : null,
                          isLeading: !isSubmit,
                          trailingWidget: CustomLoadingWidget(
                            gradientColors: <Color>[
                              ColorResource.colorFFFFFF,
                              ColorResource.colorFFFFFF.withOpacity(0.7),
                            ],
                          ),
                          fontSize: FontSize.sixteen,
                          onTap: isSubmit
                              ? () async {
                                  if (await AppUtils.checkGPSConnection(
                                      context)) {
                                    if (await AppUtils.checkLocationPermission(
                                        context)) {
                                      submitPTPEvent(false);
                                    }
                                  }
                                }
                              : () {},
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
    if (isRecord == Constants.process) {
      AppUtils.showToast('Stop the Record then Submit');
    } else if (isRecord == Constants.stop) {
      AppUtils.showToast('Please wait audio is converting');
    } else {
      if (isRecord == Constants.submit) {
        setState(() {
          remarksController.text = translateText;
          isTranslate = false;
        });
      }
      if (_formKey.currentState!.validate()) {
        if (selectedPaymentModeButton != '') {
          setState(() => isSubmit = false);
          bool isNotAutoCalling = true;
          //todo
          if (widget.isAutoCalling ||
              (widget.isCallFromCaseDetails && widget.callId != null)) {
            await CallCustomerStatus.callStatusCheck(
              callId: (widget.isCallFromCaseDetails)
                  ? widget.callId
                  : widget.paramValue['callId'],
              context: context,
            ).then((bool value) {
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
            final GeolocatorPlatform geolocatorPlatform =
                GeolocatorPlatform.instance;

            final Position res = await geolocatorPlatform.getCurrentPosition();
            setState(() {
              position = res;
            });
            final PTPPostModel requestBodyData = PTPPostModel(
              eventId: ConstantEventValues.ptpEventId,
              eventType:
                  (widget.userType == Constants.telecaller || widget.isCall!)
                      ? 'TC : PTP'
                      : 'PTP',
              eventCode: ConstantEventValues.ptpEventCode,
              caseId: widget.caseId,
              eventAttr: EventAttr(
                pTPType: ConstantEventValues.ptpType,
                date: ptpDateController.text,
                time: ptpTimeController.text,
                remarks: remarksController.text,
                ptpAmount: int.parse(ptpAmountController.text),
                reference: referenceController.text,
                mode: ConvertString.convertLanguageToConstant(
                    selectedPaymentModeButton, context),
                followUpPriority:
                    EventFollowUpPriority.connectedFollowUpPriority(
                  currentCaseStatus: widget
                      .bloc.caseDetailsAPIValue.caseDetails!.telSubStatus!,
                  eventType: 'PTP',
                  currentFollowUpPriority: widget
                      .bloc.caseDetailsAPIValue.caseDetails!.followUpPriority!,
                ),
                // followUpPriority: 'PTP',
                longitude: position.longitude,
                latitude: position.latitude,
                accuracy: position.accuracy,
                altitude: position.altitude,
                heading: position.heading,
                speed: position.speed,
                reginalText: returnS2Tdata.result?.reginalText,
                translatedText: returnS2Tdata.result?.translatedText,
                audioS3Path: returnS2Tdata.result?.audioS3Path,
              ),
              callID: Singleton.instance.callID,
              callingID: Singleton.instance.callingID,
              callerServiceID: Singleton.instance.callerServiceID,
              voiceCallEventCode: ConstantEventValues.voiceCallEventCode,
              createdBy: Singleton.instance.agentRef ?? '',
              agentName: Singleton.instance.agentName ?? '',
              contractor: Singleton.instance.contractor ?? '',
              eventModule: widget.isCall! ? 'Telecalling' : 'Field Allocation',
              agrRef: widget.bloc.caseDetailsAPIValue.caseDetails?.agrRef ?? '',
              contact: PTPContact(
                cType: widget.postValue['cType'],
                value: widget.postValue['value'],
                health: ConstantEventValues.ptpHealth,
                resAddressId0: Singleton.instance.resAddressId_0 ?? '',
                contactId0: Singleton.instance.contactId_0 ?? '',
              ),
              invalidNumber: Singleton.instance.invalidNumber,
            );

            if (ConnectivityResult.none ==
                await Connectivity().checkConnectivity()) {
              await FirebaseUtils.storeEvents(
                      eventsDetails: requestBodyData.toJson(),
                      caseId: widget.caseId,
                      selectedFollowUpDate: ptpDateController.text,
                      selectedClipValue: Constants.ptp,
                      bloc: widget.bloc)
                  .whenComplete(() {
                AppUtils.topSnackBar(context, Constants.successfullySubmitted);
              });
            } else {
              final CaseRepositoryImpl caseRepositoryImpl =
                  CaseRepositoryImpl();
              final ApiResult<BaseResponse> eventResult =
                  await caseRepositoryImpl
                      .postPTPEvent(jsonEncode(requestBodyData));
              await eventResult.when(
                  success: (BaseResponse? result) async {
                    await FirebaseUtils.storeEvents(
                            eventsDetails: requestBodyData.toJson(),
                            caseId: widget.caseId,
                            selectedFollowUpDate: ptpDateController.text,
                            selectedClipValue: Constants.ptp,
                            bloc: widget.bloc)
                        .whenComplete(() {});
                    // here update followUpPriority value.
                    widget.bloc.caseDetailsAPIValue.caseDetails!
                            .followUpPriority =
                        requestBodyData.eventAttr.followUpPriority;
                    // set speech to text data is null
                    returnS2Tdata.result?.reginalText = null;
                    returnS2Tdata.result?.translatedText = null;
                    returnS2Tdata.result?.audioS3Path = null;

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
                          chageFollowUpDate: ptpDateController.text,
                        ),
                      );
                    }

                    widget.bloc.add(
                      ChangeHealthStatusEvent(),
                    );

                    if (widget.isAutoCalling) {
                      //todo
                      Navigator.pop(widget.paramValue['context']);
                      Navigator.pop(widget.paramValue['context']);
                      // Singleton.instance.startCalling = false;
                      // if (!stopValue) {
                      //   widget.allocationBloc!.add(StartCallingEvent(
                      //     customerIndex: widget.paramValue['customerIndex'] + 1,
                      //     phoneIndex: 0,
                      //     isIncreaseCount: true,
                      //   ));
                      // } else {
                      //   widget.allocationBloc!.add(ConnectedStopAndSubmitEvent(
                      //     customerIndex: widget.paramValue['customerIndex'],
                      //   ));
                      // }
                    } else {
                      AppUtils.topSnackBar(
                          context, Constants.successfullySubmitted);
                      Navigator.pop(context);
                    }
                    setState(() {
                      remarksController.clear();
                      translateText = '';
                    });
                  },
                  failure: (NetworkExceptions? error) async {});
            }
          }
        } else {
          AppUtils.showToast(LanguageEn().pleaseSelectPaymentMode);
        }
      }
    }
    setState(() => isSubmit = true);
  }

  List<Widget> _buildPaymentButton(List<PaymentModeButtonModel> list) {
    final List<Widget> widgets = <Widget>[];
    for (PaymentModeButtonModel element in list) {
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
              boxShadow: <BoxShadow>[
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
              children: <Widget>[
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
