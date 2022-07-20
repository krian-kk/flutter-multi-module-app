import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:origa/http/api_repository.dart';
import 'package:origa/http/httpurls.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/models/reminder_post_model/reminder_post_model.dart';
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
import 'package:permission_handler/permission_handler.dart';

import '../../models/speech2text_model.dart';
import '../../widgets/get_followuppriority_value.dart';

class CustomRemainderBottomSheet extends StatefulWidget {
  const CustomRemainderBottomSheet(
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
  State<CustomRemainderBottomSheet> createState() =>
      _CustomRemainderBottomSheetState();
}

class _CustomRemainderBottomSheetState
    extends State<CustomRemainderBottomSheet> {
  late TextEditingController nextActionDateControlller;
  late TextEditingController nextActionTimeControlller;
  late TextEditingController remarksControlller;

  bool isSubmit = true;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? isRecord;
  String translateText = '';
  bool isTranslate = true;

  //Returned speech to text AAPI data
  Speech2TextModel returnS2Tdata = Speech2TextModel();

  @override
  void initState() {
    nextActionDateControlller = TextEditingController();
    nextActionTimeControlller = TextEditingController();
    remarksControlller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nextActionDateControlller.dispose();
    nextActionTimeControlller.dispose();
    remarksControlller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CaseDetailsBloc, CaseDetailsState>(
      bloc: widget.bloc,
      listener: (BuildContext context, CaseDetailsState state) {
        if (state is UpdateHealthStatusState) {
          final UpdateHealthStatusModel data = UpdateHealthStatusModel.fromJson(
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
                              Row(
                                children: <Widget>[
                                  Flexible(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      // CustomText(
                                      //   Languages.of(context)!.nextActionDate,
                                      //   fontSize: FontSize.twelve,
                                      //   fontWeight: FontWeight.w400,
                                      //   color: ColorResource.color666666,
                                      //   fontStyle: FontStyle.normal,
                                      // ),
                                      SizedBox(
                                        width: (MediaQuery.of(context)
                                                .size
                                                .width) /
                                            2,
                                        child: CustomReadOnlyTextField(
                                          Languages.of(context)!.nextActionDate,
                                          nextActionDateControlller,
                                          validationRules: const <String>[
                                            'required'
                                          ],
                                          isReadOnly: true,
                                          isLabel: true,
                                          onTapped: () =>
                                              PickDateAndTimeUtils.pickDate(
                                                  context, (String? newDate,
                                                      String? followUpDate) {
                                            if (newDate != null &&
                                                followUpDate != null) {
                                              setState(() {
                                                nextActionDateControlller.text =
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      // CustomText(
                                      //   Languages.of(context)!.nextActionTime,
                                      //   fontSize: FontSize.twelve,
                                      //   fontWeight: FontWeight.w400,
                                      //   color: ColorResource.color666666,
                                      //   fontStyle: FontStyle.normal,
                                      // ),
                                      SizedBox(
                                        width: (MediaQuery.of(context)
                                                .size
                                                .width) /
                                            2,
                                        child: CustomReadOnlyTextField(
                                          Languages.of(context)!.nextActionTime,
                                          nextActionTimeControlller,
                                          validationRules: const <String>[
                                            'required'
                                          ],
                                          isReadOnly: true,
                                          isLabel: true,
                                          onTapped: () =>
                                              PickDateAndTimeUtils.pickTime(
                                                  context, (String? newTime) {
                                            if (newTime != null) {
                                              setState(() {
                                                nextActionTimeControlller.text =
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
                                Languages.of(context)!.remarks,
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
                                validationRules: const <String>['required'],
                                isLabel: true,
                              )),
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
                                            submitRemainderEvent(true);
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
                                      submitRemainderEvent(false);
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

  submitRemainderEvent(bool stopValue) async {
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
          LatLng latLng = const LatLng(0, 0);

          final GeolocatorPlatform geolocatorPlatform =
              GeolocatorPlatform.instance;

          final Position res = await geolocatorPlatform.getCurrentPosition();
          setState(() {
            position = res;
            latLng = LatLng(res.latitude, res.longitude);
          });

          final ReminderPostAPI requestBodyData = ReminderPostAPI(
            eventId: ConstantEventValues.remainderEventId,
            eventType:
                (widget.userType == Constants.telecaller || widget.isCall!)
                    ? 'TC : REMINDER'
                    : 'REMINDER',
            caseId: widget.caseId,
            eventCode: ConstantEventValues.remainderEvenCode,
            voiceCallEventCode: ConstantEventValues.voiceCallEventCode,
            callerServiceID: Singleton.instance.callerServiceID,
            createdBy: Singleton.instance.agentRef ?? '',
            agentName: Singleton.instance.agentName ?? '',
            agrRef: Singleton.instance.agrRef ?? '',
            contractor: Singleton.instance.contractor ?? '',
            eventModule: widget.isCall! ? 'Telecalling' : 'Field Allocation',
            eventAttr: EventAttr(
              reminderDate: nextActionDateControlller.text,
              time: nextActionTimeControlller.text,
              remarks: remarksControlller.text,
              longitude: latLng.longitude,
              latitude: latLng.latitude,
              accuracy: position.accuracy,
              followUpPriority: EventFollowUpPriority.connectedFollowUpPriority(
                currentCaseStatus: widget.bloc.caseDetailsAPIValue.result!
                    .caseDetails!.telSubStatus!,
                eventType: 'Reminder',
                currentFollowUpPriority: widget.bloc.caseDetailsAPIValue.result!
                    .caseDetails!.followUpPriority!,
              ),
              reginalText: returnS2Tdata.result?.reginalText,
              translatedText: returnS2Tdata.result?.translatedText,
              audioS3Path: returnS2Tdata.result?.audioS3Path,
            ),
            contact: Contact(
              cType: widget.postValue['cType'],
              value: widget.postValue['value'],
              health: ConstantEventValues.remainderHealth,
              resAddressId0: Singleton.instance.resAddressId_0 ?? '',
              contactId0: Singleton.instance.contactId_0 ?? '',
            ),
            callID: Singleton.instance.callID,
            callingID: Singleton.instance.callingID,
            invalidNumber: Singleton.instance.invalidNumber,
          );

          if (ConnectivityResult.none ==
              await Connectivity().checkConnectivity()) {
            await FirebaseUtils.storeEvents(
                    eventsDetails: requestBodyData.toJson(),
                    caseId: widget.caseId,
                    selectedFollowUpDate: nextActionDateControlller.text,
                    selectedClipValue: Constants.remainder,
                    bloc: widget.bloc)
                .whenComplete(() {
              AppUtils.topSnackBar(context, Constants.successfullySubmitted);
            });
          } else {
            final Map<String, dynamic> postResult =
                await APIRepository.apiRequest(
              APIRequestType.post,
              HttpUrl.reminderPostUrl('reminder', widget.userType),
              requestBodydata: jsonEncode(requestBodyData),
            );
            if (postResult[Constants.success]) {
              await FirebaseUtils.storeEvents(
                      eventsDetails: requestBodyData.toJson(),
                      caseId: widget.caseId,
                      selectedFollowUpDate: nextActionDateControlller.text,
                      selectedClipValue: Constants.remainder,
                      bloc: widget.bloc)
                  .whenComplete(() {
                AppUtils.topSnackBar(context, Constants.successfullySubmitted);
              });
              // here update followUpPriority value.
              widget.bloc.caseDetailsAPIValue.result!.caseDetails!
                      .followUpPriority =
                  requestBodyData.eventAttr.followUpPriority;

              widget.bloc.add(
                ChangeIsSubmitForMyVisitEvent(
                  Constants.remainder,
                ),
              );
              // set speech to text data is null
              returnS2Tdata.result?.reginalText = null;
              returnS2Tdata.result?.translatedText = null;
              returnS2Tdata.result?.audioS3Path = null;

              if (!(widget.userType == Constants.fieldagent &&
                  widget.isCall!)) {
                widget.bloc.add(
                  ChangeIsSubmitEvent(selectedClipValue: Constants.remainder),
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
