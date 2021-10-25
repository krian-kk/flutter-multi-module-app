// ignore_for_file: prefer_const_constructors, unnecessary_new, prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/widgets/bottomsheet_appbar.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_drop_down_button.dart';
import 'package:origa/widgets/custom_read_only_text_field.dart';
import 'package:origa/widgets/custom_text.dart';
import 'package:intl/intl.dart';

class CustomRtpBottomSheet extends StatefulWidget {
  CustomRtpBottomSheet(
    this.cardTitle, {
    Key? key,
  }) : super(key: key);
  final String cardTitle;

  @override
  State<CustomRtpBottomSheet> createState() => _CustomRtpBottomSheetState();
}

class _CustomRtpBottomSheetState extends State<CustomRtpBottomSheet> {
  TextEditingController ptpDateControlller = TextEditingController();
  TextEditingController nextActionDateControlller = TextEditingController();
  TextEditingController remarksControlller = TextEditingController();

  @override
  void initState() {
    nextActionDateControlller.text = '12-1-2021';
    remarksControlller.text = 'ABC';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.88,
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
                    Container(
                      width: double.infinity,
                      decoration: new BoxDecoration(
                          color: ColorResource.colorF7F8FA,
                          borderRadius:
                              new BorderRadius.all(Radius.circular(10.0))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 14),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomText(
                              'DEBASISH PATNAIK',
                              fontWeight: FontWeight.w700,
                              fontSize: FontSize.fourteen,
                              fontStyle: FontStyle.normal,
                              color: ColorResource.color333333,
                            ),
                            SizedBox(height: 7),
                            CustomText(
                              'TVSF_BFRT6458922993',
                              fontWeight: FontWeight.w400,
                              fontSize: FontSize.fourteen,
                              fontStyle: FontStyle.normal,
                              color: ColorResource.color333333,
                            ),
                            SizedBox(height: 17),
                            CustomText(
                              Languages.of(context)!.overdueAmount,
                              fontWeight: FontWeight.w400,
                              fontSize: FontSize.twelve,
                              fontStyle: FontStyle.normal,
                              color: ColorResource.color666666,
                            ),
                            SizedBox(height: 9),
                            CustomText(
                              '397553.67',
                              fontWeight: FontWeight.w700,
                              fontSize: FontSize.twentyFour,
                              fontStyle: FontStyle.normal,
                              color: ColorResource.color333333,
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 11),
                    SizedBox(
                      width: (MediaQuery.of(context).size.width - 36) / 2,
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
                            width: (MediaQuery.of(context).size.width - 42) / 2,
                            child: CustomReadOnlyTextField(
                              '',
                              nextActionDateControlller,
                              suffixWidget: GestureDetector(
                                  onTap: () => pickDate(
                                      context, nextActionDateControlller),
                                  child: ImageIcon(
                                    AssetImage(ImageResource.calendar),
                                    color: ColorResource.colorC4C4C4,
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    Flexible(
                        child: CustomReadOnlyTextField(
                      Languages.of(context)!.remarks,
                      remarksControlller,
                      isLabel: true,
                    )),
                    SizedBox(height: 15),
                    CustomDropDownButton(
                      Languages.of(context)!.rtpDenialReason,
                      ['One', 'Two', 'Three', 'Four'],
                    ),
                    SizedBox(height: 15),
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
                new BoxShadow(
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
}
