import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:origa/http/api_repository.dart';
import 'package:origa/http/httpurls.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/models/reminder_post_model/reminder_post_model.dart';
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

class CustomRemainderBottomSheet extends StatefulWidget {
  const CustomRemainderBottomSheet(
    this.cardTitle, {
    Key? key,
    required this.caseId,
    required this.customerLoanUserWidget,
    required this.userType,
    required this.agentName,
    required this.argRef,
    this.postValue,
    this.isCall,
  }) : super(key: key);
  final String cardTitle;
  final String caseId;
  final Widget customerLoanUserWidget;
  final String userType;
  final dynamic postValue;
  final String argRef;
  final String agentName;
  final bool? isCall;

  @override
  State<CustomRemainderBottomSheet> createState() =>
      _CustomRemainderBottomSheetState();
}

class _CustomRemainderBottomSheetState
    extends State<CustomRemainderBottomSheet> {
  TextEditingController nextActionDateControlller = TextEditingController();
  TextEditingController nextActionTimeControlller = TextEditingController();
  TextEditingController remarksControlller = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: SizedBox(
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
                          Row(
                            children: [
                              Flexible(
                                  child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CustomText(
                                    Languages.of(context)!.nextActionDate,
                                    fontSize: FontSize.twelve,
                                    fontWeight: FontWeight.w400,
                                    color: ColorResource.color666666,
                                    fontStyle: FontStyle.normal,
                                  ),
                                  SizedBox(
                                    width:
                                        (MediaQuery.of(context).size.width) / 2,
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
                              )),
                              const SizedBox(width: 7),
                              Flexible(
                                  child: Column(
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
                                        (MediaQuery.of(context).size.width) / 2,
                                    child: CustomReadOnlyTextField(
                                      '',
                                      nextActionTimeControlller,
                                      validationRules: const ['required'],
                                      isReadOnly: true,
                                      onTapped: () => pickTime(
                                          context, nextActionTimeControlller),
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
                      Languages.of(context)!.submit.toUpperCase(),
                      fontSize: FontSize.sixteen,
                      fontWeight: FontWeight.w600,
                      cardShape: 5,
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
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
                          var requestBodyData = ReminderPostAPI(
                            eventId: ConstantEventValues.remainderEventId,
                            eventType: (widget.userType == Constants.telecaller)
                                ? 'TC : REMINDER'
                                : 'REMINDER',
                            caseId: widget.caseId,
                            eventCode: ConstantEventValues.remainderEvenCode,
                            voiceCallEventCode:
                                ConstantEventValues.voiceCallEventCode,
                            callerServiceID:
                                Singleton.instance.callerServiceID ?? '',
                            createdBy: Singleton.instance.agentRef ?? '',
                            agentName: Singleton.instance.agentName ?? '',
                            agrRef: Singleton.instance.agrRef ?? '',
                            eventModule: widget.isCall!
                                ? 'Telecalling'
                                : 'Field Allocation',
                            eventAttr: EventAttr(
                              reminderDate: nextActionDateControlller.text,
                              time: nextActionTimeControlller.text,
                              remarks: remarksControlller.text,
                              longitude: position.longitude,
                              latitude: position.latitude,
                              accuracy: position.accuracy,
                              altitude: position.altitude,
                              heading: position.heading,
                              speed: position.speed,
                            ),
                            contact: Contact(
                              cType: widget.postValue['cType'],
                              value: widget.postValue['value'],
                              health: ConstantEventValues.remainderHealth,
                            ),
                            callID: Singleton.instance.callID,
                            callingID: Singleton.instance.callingID,
                          );
                          Map<String, dynamic> postResult =
                              await APIRepository.apiRequest(
                            APIRequestType.POST,
                            HttpUrl.reminderPostUrl(
                                'reminder', widget.userType),
                            requestBodydata: jsonEncode(requestBodyData),
                          );
                          if (postResult[Constants.success]) {
                            AppUtils.topSnackBar(
                                context, Constants.successfullySubmitted);
                            Navigator.pop(context);
                          }
                        }
                      },
                    ),
                  ),
                ],
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
