import 'dart:convert';

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
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/utils/pick_date_time_utils.dart';
import 'package:origa/widgets/bottomsheet_appbar.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_cancel_button.dart';
import 'package:origa/widgets/custom_loading_widget.dart';
import 'package:origa/widgets/custom_read_only_text_field.dart';
import 'package:permission_handler/permission_handler.dart';

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

  final _formKey = GlobalKey<FormState>();

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
              backgroundColor: Colors.transparent,
              resizeToAvoidBottomInset: true,
              body: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
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
                                children: [
                                  Flexible(
                                      child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
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
                                          validationRules: const ['required'],
                                          isReadOnly: true,
                                          isLabel: true,
                                          onTapped: () =>
                                              PickDateAndTimeUtils.pickDate(
                                                  context, (newDate) {
                                            if (newDate != null) {
                                              setState(() {
                                                nextActionDateControlller.text =
                                                    newDate;
                                              });
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
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
                                          validationRules: const ['required'],
                                          isReadOnly: true,
                                          isLabel: true,
                                          onTapped: () =>
                                              PickDateAndTimeUtils.pickTime(
                                                  context, (newTime) {
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
                                // suffixWidget: VoiceRecodingWidget(),
                                validationRules: const ['required'],
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
                                cardShape: 5,
                                onTap: isSubmit
                                    ? () => submitRemainderEvent(true)
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
                            gradientColors: [
                              ColorResource.colorFFFFFF,
                              ColorResource.colorFFFFFF.withOpacity(0.7),
                            ],
                          ),
                          fontSize: FontSize.sixteen,
                          fontWeight: FontWeight.w600,
                          cardShape: 5,
                          onTap: isSubmit
                              ? () => submitRemainderEvent(false)
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
        ).then((value) {
          isNotAutoCalling = value;
        });
      }
      if (isNotAutoCalling) {
        LatLng latLng = const LatLng(0, 0);
        if (Geolocator.checkPermission().toString() !=
            PermissionStatus.granted.toString()) {
          Position res = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.best);
          setState(() {
            latLng = LatLng(res.latitude, res.longitude);
          });
        }
        var requestBodyData = ReminderPostAPI(
          eventId: ConstantEventValues.remainderEventId,
          eventType: (widget.userType == Constants.telecaller || widget.isCall!)
              ? 'TC : REMINDER'
              : 'REMINDER',
          caseId: widget.caseId,
          eventCode: ConstantEventValues.remainderEvenCode,
          voiceCallEventCode: ConstantEventValues.voiceCallEventCode,
          callerServiceID: Singleton.instance.callerServiceID ?? '',
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
        );
        Map<String, dynamic> postResult = await APIRepository.apiRequest(
          APIRequestType.post,
          HttpUrl.reminderPostUrl('reminder', widget.userType),
          requestBodydata: jsonEncode(requestBodyData),
        );
        if (postResult[Constants.success]) {
          widget.bloc.add(
            ChangeIsSubmitForMyVisitEvent(
              Constants.remainder,
            ),
          );
          if (!(widget.userType == Constants.fieldagent && widget.isCall!)) {
            widget.bloc.add(
              ChangeIsSubmitEvent(Constants.remainder),
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
    setState(() => isSubmit = true);
  }
}
