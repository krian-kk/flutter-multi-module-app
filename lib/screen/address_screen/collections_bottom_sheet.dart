// ignore_for_file: prefer_const_constructors, unnecessary_new, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/models/payment_mode_button_model.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/widgets/bottomsheet_appbar.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_drop_down_button.dart';
import 'package:origa/widgets/custom_loan_user_details.dart';
import 'package:origa/widgets/custom_read_only_text_field.dart';
import 'package:origa/widgets/custom_text.dart';
import 'package:intl/intl.dart';

class CustomCollectionsBottomSheet extends StatefulWidget {
  CustomCollectionsBottomSheet(
    this.cardTitle, {
    Key? key,
  }) : super(key: key);
  final String cardTitle;

  @override
  State<CustomCollectionsBottomSheet> createState() =>
      _CustomCollectionsBottomSheetState();
}

class _CustomCollectionsBottomSheetState
    extends State<CustomCollectionsBottomSheet> {
  TextEditingController amountCollectedControlller = TextEditingController();
  TextEditingController dateControlller = TextEditingController();
  TextEditingController chequeControlller = TextEditingController();
  TextEditingController remarksControlller = TextEditingController();
  String selectedPaymentModeButton = '';

  List<String> amountCollectionDropDownList = ['One', 'Two', 'Three', 'Four'];

  @override
  void initState() {
    super.initState();
    dateControlller.text = '12-1-2021';
    chequeControlller.text = '123';
    remarksControlller.text = 'ABC';
  }

  @override
  Widget build(BuildContext context) {
    List<PaymentModeButtonModel> paymentModeButtonList = [
      PaymentModeButtonModel(Languages.of(context)!.pickUp),
      PaymentModeButtonModel(Languages.of(context)!.selfPay),
      PaymentModeButtonModel(Languages.of(context)!.digital),
      PaymentModeButtonModel(Languages.of(context)!.qrCode),
    ];
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.89,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Padding(
          //   padding: const EdgeInsets.fromLTRB(23, 16, 15, 5),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       CustomText(
          //         widget.cardTitle,
          //         color: ColorResource.color101010,
          //         fontWeight: FontWeight.w700,
          //         fontSize: FontSize.sixteen,
          //         fontStyle: FontStyle.normal,
          //       ),
          //       GestureDetector(
          //           onTap: () => Navigator.pop(context),
          //           child: Image.asset(ImageResource.close))
          //     ],
          //   ),
          // ),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: CustomDropDownButton(
                            Languages.of(context)!.amountCollected,
                            amountCollectionDropDownList,
                            icon: ImageIcon(
                              AssetImage(ImageResource.dropDownArrow),
                            ),
                          ),
                        ),
                        SizedBox(width: 7),
                        Flexible(
                            child: SizedBox(
                          child: Column(
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
                              CustomReadOnlyTextField(
                                '',
                                dateControlller,
                                suffixWidget: GestureDetector(
                                    onTap: () =>
                                        pickDate(context, dateControlller),
                                    child: ImageIcon(
                                      AssetImage(ImageResource.calendar),
                                      color: ColorResource.colorC4C4C4,
                                    )),
                                // focusColor: ColorResource.colorE5EAF6,
                              ),
                            ],
                          ),
                        )),
                      ],
                    ),
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
                    SizedBox(height: 15),
                    Flexible(
                        child: CustomReadOnlyTextField(
                      Languages.of(context)!.refCheque,
                      chequeControlller,
                      isLabel: true,
                    )),
                    SizedBox(height: 15),
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
                      fontWeight: FontWeight.w700,
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

  List<Widget> _buildPaymentButton(List<PaymentModeButtonModel> list) {
    List<Widget> widgets = [];
    list.forEach((element) {
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
                  offset: Offset(1.0, 1.0),
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
    });
    return widgets;
  }
}
