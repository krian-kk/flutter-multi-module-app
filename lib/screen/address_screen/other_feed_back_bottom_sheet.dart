// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/models/other_feedback_model.dart';
import 'package:origa/screen/address_screen/bloc/address_bloc.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/widgets/bottomsheet_appbar.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_expanstion_tile.dart';
import 'package:origa/widgets/custom_loan_user_details.dart';
import 'package:origa/widgets/custom_read_only_text_field.dart';
import 'package:origa/widgets/custom_text.dart';
import 'package:intl/intl.dart';

class CustomOtherFeedBackBottomSheet extends StatefulWidget {
  final AddressBloc bloc;
  CustomOtherFeedBackBottomSheet(
    this.cardTitle,
    this.bloc, {
    Key? key,
  }) : super(key: key);
  final String cardTitle;

  @override
  State<CustomOtherFeedBackBottomSheet> createState() =>
      _CustomOtherFeedBackBottomSheetState();
}

class _CustomOtherFeedBackBottomSheetState
    extends State<CustomOtherFeedBackBottomSheet> {
  TextEditingController dateControlller = TextEditingController();
  TextEditingController timeControlller = TextEditingController();
  TextEditingController modelMakeControlller = TextEditingController();
  TextEditingController registrationNoControlller = TextEditingController();
  TextEditingController chassisNoControlller = TextEditingController();
  TextEditingController remarksControlller = TextEditingController();

  @override
  void initState() {
    super.initState();
    dateControlller.text = '12-1-2021';
    timeControlller.text = '7:00';
    modelMakeControlller.text = '123';
    registrationNoControlller.text = '123';
    chassisNoControlller.text = '123';
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
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomText(
                          Languages.of(context)!.date,
                          fontSize: FontSize.twelve,
                          fontWeight: FontWeight.w400,
                          color: ColorResource.color666666,
                          fontStyle: FontStyle.normal,
                        ),
                        SizedBox(
                          width: (MediaQuery.of(context).size.width - 44) / 2,
                          child: CustomReadOnlyTextField(
                            '',
                            dateControlller,
                            suffixWidget: GestureDetector(
                                onTap: () => pickDate(context, dateControlller),
                                child: ImageIcon(
                                  AssetImage(ImageResource.calendar),
                                  color: ColorResource.colorC4C4C4,
                                )),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 25),
                    CustomText(
                      Languages.of(context)!.customerMetCategory,
                      fontSize: FontSize.fourteen,
                      fontWeight: FontWeight.w700,
                      color: ColorResource.color000000,
                      fontStyle: FontStyle.normal,
                    ),
                    SizedBox(height: 10),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: widget.bloc.expandOtherFeedback.length,
                      itemBuilder: (context, int index) =>
                          expandList(widget.bloc.expandOtherFeedback, index),
                    ),
                    SizedBox(height: 25),
                    GestureDetector(
                      onTap: () {},
                      child: SizedBox(
                        width: double.infinity,
                        // height: 56,
                        child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                              side: BorderSide(
                                width: 0.5,
                                color: ColorResource.colorDADADA,
                              ),
                            ),
                            color: ColorResource.color23375A,
                            elevation: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(ImageResource.upload),
                                      SizedBox(width: 5),
                                      CustomText(
                                        'UPLOAD AUDIO FILE',
                                        color: ColorResource.colorFFFFFF,
                                        fontSize: FontSize.sixteen,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w700,
                                      )
                                    ],
                                  ),
                                  CustomText(
                                    'UPTO 5MB',
                                    lineHeight: 1,
                                    color: ColorResource.colorFFFFFF,
                                    fontSize: FontSize.twelve,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w700,
                                  )
                                ],
                              ),
                            )),
                      ),
                    ),
                    // CustomButton(
                    //   'UPLOAD AUDIO FILE',
                    //   fontWeight: FontWeight.w700,
                    //   trailingWidget: Image.asset(ImageResource.upload),
                    //   fontSize: FontSize.sixteen,
                    //   buttonBackgroundColor: ColorResource.color23375A,
                    //   borderColor: ColorResource.colorDADADA,
                    //   cardShape: 50,
                    //   cardElevation: 1,
                    //   isLeading: true,
                    // ),
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

  expandList(List<OtherFeedbackExpandModel> expandedList, int index) {
    int listcount = index;
    listcount++;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(
            bottom: 12,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: ColorResource.colorE7E7E7,
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.grey.withOpacity(0.2),
            //     spreadRadius: 2,
            //     blurRadius: 3,
            //     offset: Offset(0, 3), // changes position of shadow
            //   ),
            // ],
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 14, 0),
            child: Theme(
              data: ThemeData().copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                tilePadding: const EdgeInsetsDirectional.all(0),
                expandedCrossAxisAlignment: CrossAxisAlignment.start,
                expandedAlignment: Alignment.centerLeft,
                title: CustomText(
                  expandedList[index].header,
                  fontSize: FontSize.fourteen,
                  fontWeight: FontWeight.w700,
                  color: ColorResource.color000000,
                ),
                iconColor: ColorResource.color000000,
                collapsedIconColor: ColorResource.color000000,
                children: [
                  CustomText(
                    expandedList[index].subtitle,
                    fontSize: FontSize.fourteen,
                    fontWeight: FontWeight.w700,
                    color: ColorResource.color000000,
                  ),
                  SizedBox(
                    height: 13,
                  )
                ],
                onExpansionChanged: (bool status) {
                  setState(() {
                    // ignore: lines_longer_than_80_chars
                    expandedList[index].expanded =
                        !expandedList[index].expanded;
                  });
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
