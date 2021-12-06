import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:origa/http/api_repository.dart';
import 'package:origa/http/httpurls.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/models/dispute_post_model/dispute_post_model.dart';
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

class CustomDisputeBottomSheet extends StatefulWidget {
  const CustomDisputeBottomSheet(
    this.cardTitle, {
    Key? key,
  }) : super(key: key);
  final String cardTitle;

  @override
  State<CustomDisputeBottomSheet> createState() =>
      _CustomDisputeBottomSheetState();
}

class _CustomDisputeBottomSheetState extends State<CustomDisputeBottomSheet> {
  TextEditingController nextActionDateControlller = TextEditingController();
  TextEditingController remarksControlller = TextEditingController();

  String disputeDropDownValue = 'select';

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // DateTime currentDateTime = DateTime.now();
    // nextActionDateControlller.text =
    //     DateFormat('dd-MM-yyyy').format(currentDateTime).toString();
    // remarksControlller.text = 'ABC';
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
                        const CustomLoanUserDetails(
                          userName: 'DEBASISH PATNAIK',
                          userId: 'TVSF_BFRT6458922993',
                          userAmount: 397553.67,
                        ),
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
                    Languages.of(context)!.submit.toUpperCase(),
                    fontSize: FontSize.sixteen,
                    fontWeight: FontWeight.w600,
                    onTap: () async {
                      if (_formKey.currentState!.validate() &&
                          (disputeDropDownValue != 'select')) {
                        var requestBodyData = DisputePostModel(
                          eventType: 'DISPUTE',
                          eventCode: 'TELEVT005',
                          contractor: '0',
                          agrRef: '0',
                          eventAttr: EventAttr(
                              actionDate: nextActionDateControlller.text,
                              remarks: remarksControlller.text,
                              disputereasons: disputeDropDownValue,
                              agentLocation: AgentLocation()),
                          contact: Contact(),
                          createdBy: DateTime.now().toString(),
                          callID: '0',
                          callingID: '0',
                        );

                        Map<String, dynamic> postResult =
                            await APIRepository.apiRequest(
                                APIRequestType.POST,
                                HttpUrl.disputePostUrl(
                                  'dispute',
                                  'FIELDAGENT',
                                ),
                                requestBodydata: jsonEncode(requestBodyData));
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
    String formattedDate = DateFormat('yyyy-MM-dd').format(newDate);
    setState(() {
      controller.text = formattedDate;
      // _formKey.currentState!.validate();
    });
  }
}
