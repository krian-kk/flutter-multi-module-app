import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:origa/http/api_repository.dart';
import 'package:origa/http/httpurls.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/models/not_eligible_post_model.dart';
import 'package:origa/models/update_health_model.dart';
import 'package:origa/screen/allocation/bloc/allocation_bloc.dart';
import 'package:origa/singleton.dart';
import 'package:origa/src/features/case_details_screen/bloc/case_details_bloc.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/call_status_utils.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/constant_event_values.dart';
import 'package:origa/utils/constants.dart';
import 'package:origa/utils/firebase.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/string_resource.dart';
import 'package:origa/widgets/bottomsheet_appbar.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_cancel_button.dart';
import 'package:origa/widgets/custom_loading_widget.dart';
import 'package:origa/widgets/custom_read_only_text_field.dart';
import 'package:origa/widgets/dropdown_custom.dart';

import '../../models/speech2text_model.dart';
import '../../widgets/custom_text.dart';

class CustomNotEligibleBottomSheet extends StatefulWidget {
  const CustomNotEligibleBottomSheet(
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
    this.isCallFromCaseDetails = false,
    this.callId,
  }) : super(key: key);
  final String cardTitle;
  final String caseId;
  final Widget customerLoanUserWidget;
  final String userType;
  final dynamic postValue;
  final bool isAutoCalling;
  final AllocationBloc? allocationBloc;
  final dynamic paramValue;
  final CaseDetailsBloc bloc;
  final bool isCallFromCaseDetails;
  final String? callId;

  final bool? isCall;

  @override
  State<CustomNotEligibleBottomSheet> createState() =>
      _CustomNotEligibleBottomSheetState();
}

class _CustomNotEligibleBottomSheetState
    extends State<CustomNotEligibleBottomSheet> {
  // late TextEditingController nextActionDateControlller;
  // late TextEditingController nextActionTimeControlller;
  late TextEditingController remarksControlller;

  bool isSubmit = true;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? isRecord;
  String translateText = '';
  bool isTranslate = true;

  //Returned speech to text AAPI data
  Speech2TextModel returnS2Tdata = Speech2TextModel();
  String? selectedDropdownValue;

  @override
  void initState() {
    // nextActionDateControlller = TextEditingController();
    // nextActionTimeControlller = TextEditingController();
    remarksControlller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // nextActionDateControlller.dispose();
    // nextActionTimeControlller.dispose();
    remarksControlller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<String> dropdownValues = [
      StringResource.ciblBounce,
      StringResource.salaryIssue,
      StringResource.negativeProfile,
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
                widget.bloc.caseDetailsAPIValue.callDetails![data.selectedHealthIndex!]['health'] = '2';
                break;
              case 1:
                widget.bloc.caseDetailsAPIValue.callDetails![data.selectedHealthIndex!]['health'] = '1';
                break;
              case 2:
                widget.bloc.caseDetailsAPIValue.callDetails![data.selectedHealthIndex!]['health'] = '0';
                break;
              default:
                widget.bloc.caseDetailsAPIValue.callDetails![data.selectedHealthIndex!]['health'] =
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
              backgroundColor: Colors.transparent,
              resizeToAvoidBottomInset: true,
              body: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    BottomSheetAppbar(
                      title: widget.cardTitle,
                      padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15)
                          .copyWith(bottom: 5),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              widget.customerLoanUserWidget,
                              const SizedBox(height: 11),
                              DropDownButton(
                                dropdownValues,
                                hintWidget: CustomText(
                                  Languages.of(context)!.reasonForNotEligible,
                                  color: ColorResource.color666666,
                                  fontSize: FontSize.fifteen,
                                ),
                                selectedValue: selectedDropdownValue,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedDropdownValue = newValue.toString();
                                  });
                                },
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              CustomReadOnlyTextField(
                                Languages.of(context)!
                                    .remarks
                                    .replaceAll('*', ''),
                                remarksControlller,
                                isVoiceRecordWidget: true,
                                returnS2Tresponse: (dynamic val) {
                                  if (val is Speech2TextModel) {
                                    setState(() {
                                      returnS2Tdata = val;
                                    });
                                  }
                                },
                                checkRecord: (String? isRecord, String? text,
                                    Speech2TextModel returnS2Tdata) {
                                  setState(() {
                                    this.returnS2Tdata = returnS2Tdata;
                                    this.isRecord = isRecord;
                                    translateText = text!;
                                    isTranslate = true;
                                  });
                                },
                                isSubmit: isTranslate,
                                isLabel: true,
                              ),
                              const SizedBox(height: 15),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
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
                                  gradientColors: <Color>[
                                    ColorResource.colorFFFFFF,
                                    ColorResource.colorFFFFFF.withOpacity(0.7),
                                  ],
                                ),
                                fontSize: FontSize.sixteen,
                                cardShape: 5,
                                onTap: isSubmit
                                    ? () async {
                                        if (await AppUtils.checkGPSConnection(
                                            context)) {
                                          if (await AppUtils
                                              .checkLocationPermission(
                                                  context)) {
                                            submitNotEligibleEvent(true);
                                          }
                                        }
                                      }
                                    : () {},
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
                            gradientColors: <Color>[
                              ColorResource.colorFFFFFF,
                              ColorResource.colorFFFFFF.withOpacity(0.7),
                            ],
                          ),
                          fontSize: FontSize.sixteen,
                          cardShape: 5,
                          onTap: isSubmit
                              ? () async {
                                  if (await AppUtils.checkGPSConnection(
                                      context)) {
                                    if (await AppUtils.checkLocationPermission(
                                        context)) {
                                      submitNotEligibleEvent(false);
                                    }
                                  }
                                }
                              : () {},
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

  submitNotEligibleEvent(bool stopValue) async {
    if (isRecord == Constants.process) {
      AppUtils.showToast('Stop the Record then Submit');
    } else if (isRecord == Constants.stop) {
      AppUtils.showToast('Please wait audio is converting');
    } else {
      if (isRecord == Constants.submit) {
        setState(() => remarksControlller.text = translateText);
        setState(() => isTranslate = false);
      }
      if (_formKey.currentState!.validate()) {
        setState(() => isSubmit = false);
        bool isNotAutoCalling = true;
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
          final NotEligiblePostEvent requestBodyData = NotEligiblePostEvent(
            eventId: ConstantEventValues.notEligibleEventId,
            eventType: Constants.notEligible,
            caseId: widget.caseId,
            eventCode: ConstantEventValues.notEligibleEvenCode,
            voiceCallEventCode: ConstantEventValues.voiceCallEventCode,
            callerServiceID: Singleton.instance.callerServiceID,
            createdBy: Singleton.instance.agentRef ?? '',
            agentName: Singleton.instance.agentName ?? '',
            agrRef: Singleton.instance.agrRef ?? '',
            contractor: Singleton.instance.contractor ?? '',
            eventModule: 'Telecalling',
            eventAttr: EventAttr(
              reasonForNotEligible: selectedDropdownValue,
              remarks: remarksControlller.text,
              reginalText: returnS2Tdata.result?.reginalText,
              translatedText: returnS2Tdata.result?.translatedText,
              audioS3Path: returnS2Tdata.result?.audioS3Path,
            ),
            callID: Singleton.instance.callID,
            callingID: Singleton.instance.callingID,
            invalidNumber: Singleton.instance.invalidNumber,
            contact: Contact(
              cType: widget.postValue['cType'],
              value: widget.postValue['value'],
              health: ConstantEventValues.remainderHealth,
              resAddressId0: Singleton.instance.resAddressId_0 ?? '',
              contactId0: Singleton.instance.contactId_0 ?? '',
            ),
          );

          if (ConnectivityResult.none ==
              await Connectivity().checkConnectivity()) {
            //todo
            // await FirebaseUtils.storeEvents(
            //         eventsDetails: requestBodyData.toJson(),
            //         caseId: widget.caseId,
            //         // selectedFollowUpDate: nextActionDateControlller.text,
            //         selectedClipValue: Constants.notEligible,
            //         bloc: widget.bloc)
            //     .whenComplete(() {
            //   AppUtils.topSnackBar(context, Constants.successfullySubmitted);
            // });
          } else {
            final Map<String, dynamic> postResult =
                await APIRepository.apiRequest(
              APIRequestType.post,
              HttpUrl.notEligible,
              requestBodydata: jsonEncode(requestBodyData),
            );
            if (postResult[Constants.success]) {
              //todo
              // await FirebaseUtils.storeEvents(
              //         eventsDetails: requestBodyData.toJson(),
              //         caseId: widget.caseId,
              //         // selectedFollowUpDate: nextActionDateControlller.text,
              //         selectedClipValue: Constants.notEligible,
              //         bloc: widget.bloc)
              //     .whenComplete(() {});
              // // here update followUpPriority value.
              // widget.bloc.caseDetailsAPIValue.result!.caseDetails!
              //         .followUpPriority =
              //     requestBodyData.eventAttr?.followUpPriority;

              widget.bloc.add(
                ChangeIsSubmitForMyVisitEvent(
                  Constants.notEligible,
                ),
              );
              // set speech to text data is null
              returnS2Tdata.result?.reginalText = null;
              returnS2Tdata.result?.translatedText = null;
              returnS2Tdata.result?.audioS3Path = null;

              if (!(widget.userType == Constants.fieldagent &&
                  widget.isCall!)) {
                widget.bloc.add(
                  ChangeIsSubmitEvent(selectedClipValue: Constants.notEligible),
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
          }
        }
      }
    }
    setState(() => isSubmit = true);
  }
}
