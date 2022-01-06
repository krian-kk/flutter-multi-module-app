import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:origa/http/api_repository.dart';
import 'package:origa/http/httpurls.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/models/ots_post_model/contact.dart';
import 'package:origa/models/ots_post_model/event_attr.dart';
import 'package:origa/models/ots_post_model/ots_post_model.dart';
import 'package:origa/singleton.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/constant_event_values.dart';
import 'package:origa/utils/constants.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/widgets/bottomsheet_appbar.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_read_only_text_field.dart';
import 'package:origa/widgets/custom_text.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

class CustomOtsBottomSheet extends StatefulWidget {
  const CustomOtsBottomSheet(
    this.cardTitle, {
    Key? key,
    required this.customerLoanUserWidget,
    this.isCall,
    required this.caseId,
    required this.userType,
    required this.postValue,
  }) : super(key: key);
  final String cardTitle;
  final Widget customerLoanUserWidget;
  final bool? isCall;
  final String caseId;
  final String userType;
  final dynamic postValue;

  @override
  State<CustomOtsBottomSheet> createState() => _CustomOtsBottomSheetState();
}

class _CustomOtsBottomSheetState extends State<CustomOtsBottomSheet> {
  TextEditingController otsProposedAmountControlller = TextEditingController();
  TextEditingController otsPaymentDateControlller = TextEditingController();
  TextEditingController otsPaymentTimeControlller = TextEditingController();
  TextEditingController remarksControlller = TextEditingController();

  FocusNode otsProposedAmountFocusNode = FocusNode();

  final _formKey = GlobalKey<FormState>();

  bool isSubmit = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.89,
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: Colors.transparent,
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
                    child: KeyboardActions(
                      config: KeyboardActionsConfig(
                        actions: [
                          KeyboardActionsItem(
                            focusNode: otsProposedAmountFocusNode,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              widget.customerLoanUserWidget,
                              const SizedBox(height: 11),
                              const SizedBox(height: 15),
                              Flexible(
                                  child: CustomReadOnlyTextField(
                                Languages.of(context)!.otsProposedAmount,
                                otsProposedAmountControlller,
                                validationRules: const ['required'],
                                isLabel: true,
                                focusNode: otsProposedAmountFocusNode,
                                keyBoardType: TextInputType.number,
                                // inputformaters: [
                                //   FilteringTextInputFormatter.allow(
                                //       RegExp(r'[0-9]')),
                                // ],
                              )),
                              const SizedBox(height: 17),
                              Row(
                                children: [
                                  Flexible(
                                      child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      CustomText(
                                        Languages.of(context)!.otsPaymentDate,
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
                                          '',
                                          otsPaymentDateControlller,
                                          validationRules: const ['required'],
                                          isReadOnly: true,
                                          onTapped: () => pickDate(context,
                                              otsPaymentDateControlller),
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
                                      CustomText(
                                        Languages.of(context)!.otsPaymentTime,
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
                                          '',
                                          otsPaymentTimeControlller,
                                          validationRules: const ['required'],
                                          isReadOnly: true,
                                          onTapped: () => pickTime(context,
                                              otsPaymentTimeControlller),
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
                                validationRules: const ['required'],
                                isLabel: true,
                              )),
                              const SizedBox(height: 15),
                            ],
                          ),
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
                        trailingWidget: const Center(
                          child: CircularProgressIndicator(
                            color: ColorResource.colorFFFFFF,
                          ),
                        ),
                        fontSize: FontSize.sixteen,
                        fontWeight: FontWeight.w600,
                        onTap: isSubmit
                            ? () async {
                                if (_formKey.currentState!.validate()) {
                                  setState(() => isSubmit = false);
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
                                    Position res =
                                        await Geolocator.getCurrentPosition(
                                            desiredAccuracy:
                                                LocationAccuracy.best);
                                    setState(() {
                                      position = res;
                                    });
                                  }
                                  var requestBodyData = OtsPostModel(
                                    eventId: ConstantEventValues.otsEventId,
                                    eventType: (widget.userType ==
                                                Constants.telecaller ||
                                            widget.isCall!)
                                        ? 'TC : OTS'
                                        : 'OTS',
                                    caseId: widget.caseId,
                                    eventAttr: OTSEventAttr(
                                        date: otsPaymentDateControlller.text,
                                        remarkOts: remarksControlller.text,
                                        amntOts:
                                            otsProposedAmountControlller.text,
                                        appStatus: 'OTS',
                                        mode: 'CASH',
                                        altitude: position.altitude,
                                        accuracy: position.accuracy,
                                        heading: position.heading,
                                        speed: position.speed,
                                        latitude: position.latitude,
                                        longitude: position.longitude),
                                    eventCode: ConstantEventValues.otsEvenCode,
                                    createdBy:
                                        Singleton.instance.agentRef ?? '',
                                    agentName:
                                        Singleton.instance.agentName ?? '',
                                    eventModule: widget.isCall!
                                        ? 'Telecalling'
                                        : 'Field Allocation',
                                    contact: OTSContact(
                                      cType: widget.postValue['cType'],
                                      health: ConstantEventValues.otsHealth,
                                      value: widget.postValue['value'],
                                    ),
                                    callId: Singleton.instance.callID,
                                    callingId: Singleton.instance.callingID,
                                    callerServiceId:
                                        Singleton.instance.callerServiceID ??
                                            '',
                                    voiceCallEventCode:
                                        ConstantEventValues.voiceCallEventCode,
                                    agrRef: Singleton.instance.agrRef ?? '',
                                    contractor:
                                        Singleton.instance.contractor ?? '',
                                  );

                                  Map<String, dynamic> postResult =
                                      await APIRepository.apiRequest(
                                          APIRequestType.POST,
                                          HttpUrl.otsPostUrl,
                                          requestBodydata:
                                              jsonEncode(requestBodyData));
                                  if (postResult[Constants.success]) {
                                    AppUtils.topSnackBar(
                                        context, "Event updated successfully.");
                                    Navigator.pop(context);
                                  }
                                }
                                setState(() => isSubmit = true);
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

  Future pickTime(
      BuildContext context, TextEditingController controller) async {
    const initialTime = TimeOfDay(hour: 9, minute: 0);
    final newTime = await showTimePicker(
        context: context,
        initialTime: initialTime,
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
    if (newTime == null) return;

    final hours = newTime.hour.toString().padLeft(2, '0');
    final minutes = newTime.minute.toString().padLeft(2, '0');
    setState(() {
      controller.text = '$hours:$minutes';
    });
  }
}
