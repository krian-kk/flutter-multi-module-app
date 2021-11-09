// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/models/payment_mode_button_model.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/widgets/bottomsheet_appbar.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_loan_user_details.dart';
import 'package:origa/widgets/custom_read_only_text_field.dart';
import 'package:origa/widgets/custom_text.dart';
import 'package:intl/intl.dart';

class CustomPtpBottomSheet extends StatefulWidget {
  CustomPtpBottomSheet(
    this.cardTitle, {
    Key? key,
  }) : super(key: key);
  final String cardTitle;

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

  @override
  void initState() {
    super.initState();
    DateTime currentDateTime = DateTime.now();
    final hours = currentDateTime.hour.toString().padLeft(2, '0');
    final minutes = currentDateTime.minute.toString().padLeft(2, '0');

    ptpDateControlller.text =
        DateFormat('dd-MM-yyyy').format(currentDateTime).toString();

    ptpTimeControlller.text = '$hours:$minutes';
    ptpAmountControlller.text = "0";
    referenceControlller.text = "ABC";
    remarksControlller.text = "ABC";
  }

  @override
  Widget build(BuildContext context) {
    List<PaymentModeButtonModel> paymentModeButtonList = [
      PaymentModeButtonModel(Languages.of(context)!.pickUp),
      PaymentModeButtonModel(Languages.of(context)!.selfPay),
    ];
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.89,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BottomSheetAppbar(
              title: widget.cardTitle,
              padding: EdgeInsets.fromLTRB(23, 16, 15, 5)),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CustomLoanUserDetails(
                      userName: 'DEBASISH PATNAIK',
                      userId: 'TVSF_BFRT6458922993',
                      userAmount: 397553.67,
                    ),
                    SizedBox(height: 11),
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
                              width: (MediaQuery.of(context).size.width) / 2,
                              child: CustomReadOnlyTextField(
                                '',
                                ptpDateControlller,
                                isReadOnly: true,
                                onTapped: () =>
                                    pickDate(context, ptpDateControlller),
                                suffixWidget: ImageIcon(
                                  AssetImage(ImageResource.calendar),
                                  color: ColorResource.colorC4C4C4,
                                ),
                              ),
                            ),
                          ],
                        )),
                        SizedBox(width: 7),
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
                              width: (MediaQuery.of(context).size.width) / 2,
                              child: CustomReadOnlyTextField(
                                '',
                                ptpTimeControlller,
                                isReadOnly: true,
                                onTapped: () =>
                                    pickTime(context, ptpTimeControlller),
                                suffixWidget: ImageIcon(
                                  AssetImage(ImageResource.calendar),
                                  color: ColorResource.colorC4C4C4,
                                ),
                              ),
                            ),
                          ],
                        )),
                      ],
                    ),
                    SizedBox(height: 15),
                    Flexible(
                        child: CustomReadOnlyTextField(
                      Languages.of(context)!.ptpAmount,
                      ptpAmountControlller,
                      isLabel: true,
                    )),
                    SizedBox(height: 15),
                    CustomText(
                      Languages.of(context)!.paymentMode,
                      fontSize: FontSize.fourteen,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                      color: ColorResource.color101010,
                    ),
                    SizedBox(height: 8),
                    Wrap(
                      runSpacing: 10,
                      spacing: 18,
                      children: _buildPaymentButton(paymentModeButtonList),
                    ),
                    SizedBox(height: 21),
                    CustomReadOnlyTextField(
                      Languages.of(context)!.reference,
                      referenceControlller,
                      isLabel: true,
                    ),
                    SizedBox(height: 20),
                    CustomReadOnlyTextField(
                      Languages.of(context)!.remarks,
                      remarksControlller,
                      isLabel: true,
                    ),
                    SizedBox(height: 15)
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.1,
            decoration: BoxDecoration(
              color: ColorResource.colorFFFFFF,
              boxShadow: [
                BoxShadow(
                  color: ColorResource.color000000.withOpacity(.25),
                  blurRadius: 2.0,
                  offset: Offset(1.0, 1.0),
                ),
              ],
            ),
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: 95,
                      child: Center(
                          child: CustomText(
                        Languages.of(context)!.cancel.toUpperCase(),
                        onTap: () => Navigator.pop(context),
                        color: ColorResource.colorEA6D48,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.normal,
                        fontSize: FontSize.sixteen,
                      ))),
                  SizedBox(width: 25),
                  SizedBox(
                    width: 191,
                    child: CustomButton(
                      Languages.of(context)!.submit.toUpperCase(),
                      fontSize: FontSize.sixteen,
                      fontWeight: FontWeight.w600,
                      // onTap: () => bloc.add(ClickMessageEvent()),
                      cardShape: 5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildPaymentButton(List<PaymentModeButtonModel> list) {
    List<Widget> widgets = [];
    for (var element in list) {
      widgets.add(InkWell(
        onTap: () {
          // widget.bloc.selectedInvalidClip = element.clipTitle;
          setState(() {});
        },
        child: Container(
          width: 150,
          height: 50,
          decoration: BoxDecoration(
              color: ColorResource.color23375A,
              boxShadow: [
                BoxShadow(
                  color: ColorResource.color000000.withOpacity(0.2),
                  blurRadius: 2.0,
                  offset: Offset(1.0, 1.0), // shadow direction: bottom right
                )
              ],
              borderRadius: BorderRadius.all(Radius.circular(50.0))),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: ColorResource.colorFFFFFF,
                  child: Center(
                    child: Image.asset(ImageResource.money),
                  ),
                ),
                SizedBox(width: 7),
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
              textTheme: TextTheme(
                subtitle1: TextStyle(fontSize: 10.0),
                headline1: TextStyle(fontSize: 8.0),
              ),
              colorScheme: ColorScheme.light(
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
    String formattedDate = DateFormat('dd-MM-yyyy').format(newDate);
    setState(() {
      controller.text = formattedDate;
    });
  }

  Future pickTime(
      BuildContext context, TextEditingController controller) async {
    final initialTime = TimeOfDay(hour: 9, minute: 0);
    final newTime = await showTimePicker(
        context: context,
        initialTime: initialTime,
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              textTheme: TextTheme(
                subtitle1: TextStyle(fontSize: 10.0),
                headline1: TextStyle(fontSize: 8.0),
              ),
              colorScheme: ColorScheme.light(
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
    setState(() => controller.text = '$hours:$minutes');
  }
}
