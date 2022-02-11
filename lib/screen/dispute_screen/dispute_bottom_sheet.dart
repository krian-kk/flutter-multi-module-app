import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:origa/http/api_repository.dart';
import 'package:origa/http/httpurls.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/models/dispute_post_model/dispute_post_model.dart';
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
import 'package:origa/widgets/bottomsheet_appbar.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_drop_down_button.dart';
import 'package:origa/widgets/custom_loading_widget.dart';
import 'package:origa/widgets/custom_read_only_text_field.dart';
import 'package:origa/widgets/custom_text.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

class CustomDisputeBottomSheet extends StatefulWidget {
  const CustomDisputeBottomSheet(
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
  }) : super(key: key);
  final String cardTitle;
  final String caseId;
  final Widget customerLoanUserWidget;
  final String userType;
  final dynamic postValue;
  final bool? isCall;
  final bool isAutoCalling;
  final AllocationBloc? allocationBloc;
  final dynamic paramValue;
  final CaseDetailsBloc bloc;

  @override
  State<CustomDisputeBottomSheet> createState() =>
      _CustomDisputeBottomSheetState();
}

class _CustomDisputeBottomSheetState extends State<CustomDisputeBottomSheet> {
  TextEditingController nextActionDateControlller = TextEditingController();
  // String selectedDate = '';
  TextEditingController remarksControlller = TextEditingController();

  String disputeDropDownValue = 'select';
  bool isSubmit = true;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    setState(() {
      nextActionDateControlller.text = DateFormat('yyyy-MM-dd')
          .format(DateTime.now().add(const Duration(days: 7)));
    });
  }

  @override
  Widget build(BuildContext context) {
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15)
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
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomText(
                              Languages.of(context)!.nextActionTime,
                              fontSize: FontSize.twelve,
                              fontWeight: FontWeight.w400,
                              color: ColorResource.color666666,
                              fontStyle: FontStyle.normal,
                            ),
                            SizedBox(
                              width:
                                  (MediaQuery.of(context).size.width - 46) / 2,
                              child: CustomReadOnlyTextField(
                                '',
                                nextActionDateControlller,
                                validationRules: const ['required'],
                                isReadOnly: true,
                                onTapped: () => pickDate(
                                    context, nextActionDateControlller),
                                suffixWidget: SvgPicture.asset(
                                  ImageResource.calendar,
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Flexible(
                            child: CustomReadOnlyTextField(
                          Languages.of(context)!.remarks,
                          remarksControlller,
                          validationRules: const ['required'],
                          isLabel: true,
                        )),
                        const SizedBox(height: 15),
                        Flexible(
                          child: CustomDropDownButton(
                            Languages.of(context)!.disputeReason,
                            [
                              'select',
                              Languages.of(context)!.businessLoss,
                              Languages.of(context)!.covidImpacted,
                              Languages.of(context)!.dispute,
                              Languages.of(context)!.financialReason,
                              Languages.of(context)!.incomeLossInTheFamily,
                              Languages.of(context)!.intention,
                              Languages.of(context)!.jobLoss,
                              Languages.of(context)!.jobUncertaintly,
                              Languages.of(context)!.medicalIssue,
                              Languages.of(context)!.salaryIssue,
                            ],
                            menuMaxHeight: 200,
                            selectedValue: disputeDropDownValue,
                            onChanged: (newValue) => setState(() =>
                                disputeDropDownValue = newValue.toString()),
                          ),
                        ),
                        const SizedBox(height: 15)
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
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: SizedBox(
                      width: 95,
                      child: Center(
                          child: CustomText(
                        Languages.of(context)!.cancel.toUpperCase(),
                        color: ColorResource.colorEA6D48,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.normal,
                        fontSize: FontSize.sixteen,
                      ))),
                ),
                const SizedBox(width: 25),
                SizedBox(
                  width: 191,
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
                    onTap: isSubmit
                        ? () async {
                            if (_formKey.currentState!.validate()) {
                              // if (disputeDropDownValue != 'select') {
                              setState(() => isSubmit = false);
                              bool isNotAutoCalling = true;
                              if (widget.isAutoCalling) {
                                await CallCustomerStatus.callStatusCheck(
                                        callId: widget.paramValue['callId'])
                                    .then((value) {
                                  isNotAutoCalling = value;
                                });
                              }
                              if (isNotAutoCalling) {
                                LatLng latLng = const LatLng(0, 0);
                                if (Geolocator.checkPermission().toString() !=
                                    PermissionStatus.granted.toString()) {
                                  Position res =
                                      await Geolocator.getCurrentPosition(
                                          desiredAccuracy:
                                              LocationAccuracy.best);
                                  setState(() {
                                    latLng =
                                        LatLng(res.latitude, res.longitude);
                                  });
                                }
                                var requestBodyData = DisputePostModel(
                                  eventId: ConstantEventValues.disputeEventId,
                                  eventType: (widget.userType ==
                                              Constants.telecaller ||
                                          widget.isCall!)
                                      ? 'TC : DISPUTE'
                                      : 'DISPUTE',
                                  caseId: widget.caseId,
                                  eventCode:
                                      ConstantEventValues.disputeEventCode,
                                  voiceCallEventCode:
                                      ConstantEventValues.voiceCallEventCode,
                                  createdBy: Singleton.instance.agentRef ?? '',
                                  agentName: Singleton.instance.agentName ?? '',
                                  contractor:
                                      Singleton.instance.contractor ?? '',
                                  agrRef: Singleton.instance.agrRef ?? '',
                                  eventModule: widget.isCall!
                                      ? 'Telecalling'
                                      : 'Field Allocation',
                                  callID: Singleton.instance.callID,
                                  callerServiceID:
                                      Singleton.instance.callerServiceID ?? '',
                                  callingID: Singleton.instance.callingID,
                                  eventAttr: EventAttr(
                                    actionDate: nextActionDateControlller.text,
                                    remarks: remarksControlller.text,
                                    disputereasons:
                                        disputeDropDownValue != 'select'
                                            ? disputeDropDownValue
                                            : '',
                                    longitude: latLng.longitude,
                                    latitude: latLng.latitude,
                                  ),
                                  contact: Contact(
                                    cType: widget.postValue['cType'],
                                    value: widget.postValue['value'],
                                    health: ConstantEventValues.disputeHealth,
                                    resAddressId0:
                                        Singleton.instance.resAddressId_0 ?? '',
                                    contactId0:
                                        Singleton.instance.contactId_0 ?? '',
                                  ),
                                );
                                Map<String, dynamic> postResult =
                                    await APIRepository.apiRequest(
                                        APIRequestType.POST,
                                        HttpUrl.disputePostUrl(
                                          'dispute',
                                          widget.userType,
                                        ),
                                        requestBodydata:
                                            jsonEncode(requestBodyData));
                                if (postResult[Constants.success]) {
                                  widget.bloc.add(
                                    ChangeIsSubmitForMyVisitEvent(
                                      Constants.dispute,
                                    ),
                                  );
                                  if (!(widget.userType ==
                                          Constants.fieldagent &&
                                      widget.isCall!)) {
                                    widget.bloc.add(
                                      ChangeIsSubmitEvent(),
                                    );
                                  }

                                  widget.bloc.add(
                                    ChangeHealthStatusEvent(),
                                  );

                                  if (widget.isAutoCalling) {
                                    Navigator.pop(widget.paramValue['context']);
                                    Navigator.pop(widget.paramValue['context']);
                                    widget.allocationBloc!
                                        .add(StartCallingEvent(
                                      customerIndex:
                                          widget.paramValue['customerIndex'] +
                                              1,
                                      phoneIndex: 0,
                                      isIncreaseCount: true,
                                    ));
                                  } else {
                                    AppUtils.topSnackBar(context,
                                        Constants.successfullySubmitted);
                                    Navigator.pop(context);
                                  }
                                }
                              }
                              // } else {
                              //   AppUtils.showToast(
                              //       Constants.pleaseSelectDropDownValue);
                              // }
                              setState(() => isSubmit = true);
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
  }

  Future pickDate(
      BuildContext context, TextEditingController controller) async {
    final newDate = await showDatePicker(
        context: context,
        initialDatePickerMode: DatePickerMode.year,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year + 5),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              textTheme: const TextTheme(
                subtitle1: TextStyle(fontSize: 10.0),
                headline1: TextStyle(fontSize: 8.0),
              ),
              colorScheme: const ColorScheme.light(
                primary: ColorResource.color23375A,
                onPrimary: ColorResource.colorFFFFFF,
                onSurface: ColorResource.color23375A,
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  primary: ColorResource.color23375A,
                ),
              ),
            ),
            child: child!,
          );
        });

    if (newDate == null) return null;
    String formattedDate = DateFormat('yyyy-MM-dd').format(newDate);
    setState(() {
      controller.text = formattedDate;
    });
  }
}
