import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/widgets/bottomsheet_appbar.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_loan_user_details.dart';
import 'package:origa/widgets/custom_read_only_text_field.dart';
import 'package:origa/widgets/custom_text.dart';
import 'package:intl/intl.dart';

class CustomOtsBottomSheet extends StatefulWidget {
  const CustomOtsBottomSheet(
    this.cardTitle, {
    Key? key,
  }) : super(key: key);
  final String cardTitle;

  @override
  State<CustomOtsBottomSheet> createState() => _CustomOtsBottomSheetState();
}

class _CustomOtsBottomSheetState extends State<CustomOtsBottomSheet> {
  TextEditingController otsProposedAmountControlller = TextEditingController();
  TextEditingController otsPaymentDateControlller = TextEditingController();
  TextEditingController otsPaymentTimeControlller = TextEditingController();
  TextEditingController remarksControlller = TextEditingController();

  @override
  void initState() {
    super.initState();
    DateTime currentDateTime = DateTime.now();
    final hours = currentDateTime.hour.toString().padLeft(2, '0');
    final minutes = currentDateTime.minute.toString().padLeft(2, '0');

    otsProposedAmountControlller.text = '0';
    otsPaymentDateControlller.text =
        DateFormat('dd-MM-yyyy').format(currentDateTime).toString();
    otsPaymentTimeControlller.text = '$hours:$minutes';
    remarksControlller.text = 'ABC';
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.89,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BottomSheetAppbar(
              title: widget.cardTitle,
              padding: const EdgeInsets.fromLTRB(23, 16, 15, 5)),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const CustomLoanUserDetails(
                      userName: 'DEBASISH PATNAIK',
                      userId: 'TVSF_BFRT6458922993',
                      userAmount: 397553.67,
                    ),
                    const SizedBox(height: 11),
                    const SizedBox(height: 15),
                    Flexible(
                        child: CustomReadOnlyTextField(
                      Languages.of(context)!.otsProposedAmount,
                      otsProposedAmountControlller,
                      isLabel: true,
                    )),
                    const SizedBox(height: 17),
                    Row(
                      children: [
                        Flexible(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                              width: (MediaQuery.of(context).size.width) / 2,
                              child: CustomReadOnlyTextField(
                                '',
                                otsPaymentDateControlller,
                                isReadOnly: true,
                                onTapped: () => pickDate(
                                    context, otsPaymentDateControlller),
                                suffixWidget: SvgPicture.asset(
                                  ImageResource.calendar,
                                  fit: BoxFit.scaleDown,
                                ),
                                // focusColor: ColorResource.colorE5EAF6,
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
                              Languages.of(context)!.otsPaymentTime,
                              fontSize: FontSize.twelve,
                              fontWeight: FontWeight.w400,
                              color: ColorResource.color666666,
                              fontStyle: FontStyle.normal,
                            ),
                            SizedBox(
                              width: (MediaQuery.of(context).size.width) / 2,
                              child: CustomReadOnlyTextField(
                                '',
                                otsPaymentTimeControlller,
                                isReadOnly: true,
                                onTapped: () => pickTime(
                                    context, otsPaymentTimeControlller),
                                suffixWidget: SvgPicture.asset(
                                  ImageResource.calendar,
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
                      isLabel: true,
                    )),
                    const SizedBox(height: 15),
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
                  const SizedBox(width: 25),
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
    String formattedDate = DateFormat('dd-MM-yyyy').format(newDate);
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
    setState(() => controller.text = '$hours:$minutes');
  }
}