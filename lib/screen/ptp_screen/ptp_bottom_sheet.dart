import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:origa/http/api_repository.dart';
import 'package:origa/http/httpurls.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/models/payment_mode_button_model.dart';
import 'package:origa/models/ptp_post_model/ptp_post_model.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/constants.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/widgets/bottomsheet_appbar.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_read_only_text_field.dart';
import 'package:origa/widgets/custom_text.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

class CustomPtpBottomSheet extends StatefulWidget {
  const CustomPtpBottomSheet(
    this.cardTitle, {
    Key? key,
    required this.caseId,
    required this.customerLoanUserWidget,
    required this.userType,
    required this.agentName,
    required this.argRef,
    required this.eventCode,
    this.postValue,
    this.isCall,
  }) : super(key: key);
  final String cardTitle;
  final String caseId;
  final String argRef;
  final String agentName;
  final Widget customerLoanUserWidget;
  final String userType;
  final String eventCode;
  final bool? isCall;
  final dynamic postValue;

  @override
  State<CustomPtpBottomSheet> createState() => _CustomPtpBottomSheetState();
}

class _CustomPtpBottomSheetState extends State<CustomPtpBottomSheet> {
  TextEditingController ptpDateControlller = TextEditingController();
  TextEditingController ptpTimeControlller = TextEditingController();
  TextEditingController ptpAmountControlller = TextEditingController();
  TextEditingController referenceControlller = TextEditingController();
  TextEditingController remarksControlller = TextEditingController();
  TextEditingController loanDurationController = TextEditingController();

  FocusNode ptpDataFocusNode = FocusNode();
  FocusNode ptpReferenceFocusNode = FocusNode();
  FocusNode ptpRemarksFocusNode = FocusNode();

  String selectedPaymentModeButton = '';

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<PaymentModeButtonModel> paymentModeButtonList = [
      PaymentModeButtonModel(Languages.of(context)!.cheque),
      PaymentModeButtonModel(Languages.of(context)!.selfPay),
    ];
    return WillPopScope(
      onWillPop: () async => false,
      child: SizedBox(
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                    width:
                                        (MediaQuery.of(context).size.width) / 2,
                                    child: CustomReadOnlyTextField(
                                      '',
                                      ptpDateControlller,
                                      isReadOnly: true,
                                      validationRules: const ['required'],
                                      onTapped: () =>
                                          pickDate(context, ptpDateControlller),
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
                                    Languages.of(context)!.ptpTime,
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
                                      ptpTimeControlller,
                                      validatorCallBack: () {},
                                      isReadOnly: true,
                                      validationRules: const ['required'],
                                      onTapped: () =>
                                          pickTime(context, ptpTimeControlller),
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
                            focusNode: ptpDataFocusNode,
                            validatorCallBack: () {},
                            keyBoardType: TextInputType.number,
                            validationRules: const ['required'],
                            isLabel: true,
                            onEditing: () {
                              ptpReferenceFocusNode.requestFocus();
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
                            runSpacing: 10,
                            spacing: 18,
                            children:
                                _buildPaymentButton(paymentModeButtonList),
                          ),
                          const SizedBox(height: 21),
                          CustomReadOnlyTextField(
                            Languages.of(context)!.reference,
                            referenceControlller,
                            focusNode: ptpReferenceFocusNode,
                            validationRules: const ['required'],
                            isLabel: true,
                            validatorCallBack: () {},
                            onEditing: () => ptpRemarksFocusNode.requestFocus(),
                          ),
                          const SizedBox(height: 20),
                          CustomReadOnlyTextField(
                            Languages.of(context)!.remarks,
                            remarksControlller,
                            focusNode: ptpRemarksFocusNode,
                            validationRules: const ['required'],
                            isLabel: true,
                            validatorCallBack: () {},
                            onEditing: () => ptpRemarksFocusNode.unfocus(),
                          ),
                          const SizedBox(height: 15)
                        ],
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
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          if (selectedPaymentModeButton != '') {
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
                                      desiredAccuracy: LocationAccuracy.best);
                              setState(() {
                                position = res;
                              });
                            }
                            var requestBodyData = PTPPostModel(
                              eventType:
                                  (widget.userType == Constants.telecaller)
                                      ? 'TC : PTP'
                                      : 'PTP',
                              eventCode: widget.eventCode,
                              caseId: widget.caseId,
                              eventAttr: EventAttr(
                                date: ptpDateControlller.text,
                                time: ptpTimeControlller.text,
                                remarks: remarksControlller.text,
                                ptpAmount: int.parse(ptpAmountControlller.text),
                                reference: referenceControlller.text,
                                mode: selectedPaymentModeButton,
                                followUpPriority: 'PTP',
                                longitude: position.longitude,
                                latitude: position.latitude,
                                accuracy: position.accuracy,
                                altitude: position.altitude,
                                heading: position.heading,
                                speed: position.speed,
                              ),
                              createdBy: widget.agentName,
                              agentName: widget.agentName,
                              eventModule: widget.isCall!
                                  ? 'Telecalling'
                                  : 'Field Allocation',
                              agrRef: widget.argRef,
                              contact: PTPContact(
                                cType: widget.postValue['cType'],
                                value: widget.postValue['value'],
                              ),
                            );

                            Map<String, dynamic> postResult =
                                await APIRepository.apiRequest(
                              APIRequestType.POST,
                              HttpUrl.ptpPostUrl(
                                'ptp',
                                widget.userType,
                              ),
                              requestBodydata: jsonEncode(requestBodyData),
                            );
                            if (postResult[Constants.success]) {
                              AppUtils.topSnackBar(
                                  context, Constants.successfullySubmitted);
                              Navigator.pop(context);
                            }
                          } else {
                            AppUtils.showToast(
                                Constants.pleaseSelectPaymentMode);
                          }
                        }
                      },
                      cardShape: 5,
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
          width: 150,
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
                  radius: 20,
                  backgroundColor: ColorResource.colorFFFFFF,
                  child: Center(
                    child: SvgPicture.asset(ImageResource.money),
                  ),
                ),
                const SizedBox(width: 7),
                CustomText(
                  element.title,
                  color: ColorResource.colorFFFFFF,
                  fontWeight: FontWeight.w700,
                  lineHeight: 1,
                  fontSize: FontSize.sixteen,
                  fontStyle: FontStyle.normal,
                )
              ],
            ),
          ),
        ),
      ));
    }
    return widgets;
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
