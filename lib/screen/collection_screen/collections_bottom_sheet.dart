import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:origa/http/api_repository.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/models/collection_post_model/collection_post_model.dart';
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

class CustomCollectionsBottomSheet extends StatefulWidget {
  const CustomCollectionsBottomSheet(
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

  final _formKey = GlobalKey<FormState>();

  FocusNode chequeFocusNode = FocusNode();
  FocusNode remarksFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // DateTime currentDateTime = DateTime.now();

    // dateControlller.text =
    //     DateFormat('dd-MM-yyyy').format(currentDateTime).toString();
    // chequeControlller.text = '123';
    // remarksControlller.text = 'ABC';
  }

  @override
  Widget build(BuildContext context) {
    List<PaymentModeButtonModel> paymentModeButtonList = [
      PaymentModeButtonModel(Languages.of(context)!.cheque),
      PaymentModeButtonModel(Languages.of(context)!.cash),
      PaymentModeButtonModel(Languages.of(context)!.digital),
    ];
    return SizedBox(
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
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Flexible(
                            //   child: SizedBox(
                            //     width: (MediaQuery.of(context).size.width) / 2,
                            //     child: CustomReadOnlyTextField(
                            //       '',
                            //       amountCollectedControlller,
                            //       validatorCallBack: () {},
                            //       isReadOnly: true,
                            //       validationRules: const ['required'],
                            //     ),
                            //   ),
                            //   // child: CustomDropDownButton(
                            //   //   Languages.of(context)!.amountCollected,
                            //   //   amountCollectionDropDownList,
                            //   //   selectedValue: amountCollectionDropDownValue,
                            //   //   onChanged: (newValue) {
                            //   //     setState(() {
                            //   //       amountCollectionDropDownValue =
                            //   //           newValue.toString();
                            //   //     });
                            //   //   },
                            //   //   icon: SvgPicture.asset(
                            //   //       ImageResource.dropDownArrow),
                            //   // ),
                            // ),
                            Flexible(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CustomText(
                                  Languages.of(context)!.amountCollected,
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
                                    amountCollectedControlller,
                                    contentPadding:
                                        const EdgeInsets.fromLTRB(1, 23, 5, 10),
                                    validatorCallBack: () {},
                                    keyBoardType: TextInputType.number,
                                    validationRules: const ['required'],
                                    suffixWidget: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              amountCollectedControlller
                                                  .text = (int.parse(
                                                          amountCollectedControlller
                                                              .text) +
                                                      1)
                                                  .toString();
                                            });
                                          },
                                          child: SvgPicture.asset(
                                            ImageResource.dropDownIncreaseArrow,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              amountCollectedControlller
                                                  .text = (int.parse(
                                                          amountCollectedControlller
                                                              .text) -
                                                      1)
                                                  .toString();
                                            });
                                          },
                                          child: SvgPicture.asset(
                                            ImageResource.dropDownDecreaseArrow,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )),
                            const SizedBox(width: 7),
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
                                    validationRules: const ['required'],
                                    isReadOnly: true,
                                    onTapped: () =>
                                        pickDate(context, dateControlller),
                                    suffixWidget: SvgPicture.asset(
                                      ImageResource.calendar,
                                      fit: BoxFit.scaleDown,
                                    ),
                                    // focusColor: ColorResource.colorE5EAF6,
                                  ),
                                ],
                              ),
                            )),
                          ],
                        ),
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
                          children: _buildPaymentButton(paymentModeButtonList),
                        ),
                        const SizedBox(height: 15),
                        Flexible(
                            child: CustomReadOnlyTextField(
                          Languages.of(context)!.refCheque,
                          chequeControlller,
                          focusNode: chequeFocusNode,
                          validationRules: const ['required'],
                          isLabel: true,
                          onEditing: () => remarksFocusNode.requestFocus(),
                        )),
                        const SizedBox(height: 15),
                        CustomReadOnlyTextField(
                          Languages.of(context)!.remarks,
                          remarksControlller,
                          focusNode: remarksFocusNode,
                          validationRules: const ['required'],
                          isLabel: true,
                          onEditing: () => remarksFocusNode.unfocus(),
                        ),
                        const SizedBox(height: 15),
                        CustomButton(
                          Languages.of(context)!.customUpload,
                          fontWeight: FontWeight.w700,
                          trailingWidget:
                              SvgPicture.asset(ImageResource.upload),
                          fontSize: FontSize.sixteen,
                          buttonBackgroundColor: ColorResource.color23375A,
                          borderColor: ColorResource.colorDADADA,
                          cardShape: 50,
                          cardElevation: 1,
                          isLeading: true,
                        ),
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
                    Languages.of(context)!.submit.toUpperCase(),
                    fontSize: FontSize.sixteen,
                    fontWeight: FontWeight.w700,
                    onTap: () async {
                      if (_formKey.currentState!.validate() &&
                          selectedPaymentModeButton != '') {
                        var requestBodyData = CollectionPostModel(
                            eventType: 'RECEIPT',
                            caseId: '618e382004d8d040ac18841b',
                            eventAttr: EventAttr(
                                date: dateControlller.text,
                                remarks: remarksControlller.text,
                                mode: selectedPaymentModeButton,
                                imageLocation: ['dkjd'],
                                agentLocation: AgentLocation()),
                            createdAt: DateTime.now().toString(),
                            lastAction: DateTime.now().toString());
                        Map<String, dynamic> postResult =
                            await APIRepository.apiRequest(APIRequestType.POST,
                                'https://devapi.instalmint.com/v1/agent/case-details-events/collection?userType=FIELDAGENT',
                                requestBodydata: jsonEncode(requestBodyData));
                        print(postResult);
                        if (postResult['success']) {
                          Navigator.pop(context);
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
      // _formKey.currentState!.validate();
    });
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
}
