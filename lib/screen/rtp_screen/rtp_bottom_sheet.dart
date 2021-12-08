import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:origa/http/api_repository.dart';
import 'package:origa/http/httpurls.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/models/denial_post_model/denial_post_model.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/utils/string_resource.dart';
import 'package:origa/widgets/bottomsheet_appbar.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_drop_down_button.dart';
import 'package:origa/widgets/custom_read_only_text_field.dart';
import 'package:origa/widgets/custom_text.dart';
import 'package:intl/intl.dart';

class CustomRtpBottomSheet extends StatefulWidget {
  const CustomRtpBottomSheet(this.cardTitle,
      {Key? key,
      required this.caseId,
      required this.customerLoanUserWidget,
      required this.userType,
      this.postValue})
      : super(key: key);
  final String cardTitle;
  final String caseId;
  final Widget customerLoanUserWidget;
  final String userType;
  final dynamic postValue;

  @override
  State<CustomRtpBottomSheet> createState() => _CustomRtpBottomSheetState();
}

class _CustomRtpBottomSheetState extends State<CustomRtpBottomSheet> {
  TextEditingController ptpDateControlller = TextEditingController();
  TextEditingController nextActionDateControlller = TextEditingController();
  TextEditingController remarksControlller = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  late String selectedDropdownValue = 'select';

  @override
  void initState() {
    // DateTime currentDateTime = DateTime.now();
    // nextActionDateControlller.text =
    //     DateFormat('dd-MM-yyyy').format(currentDateTime).toString();
    // remarksControlller.text = 'ABC';
    super.initState();
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
                        widget.customerLoanUserWidget,
                        const SizedBox(height: 11),
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
                                width:
                                    (MediaQuery.of(context).size.width - 42) /
                                        2,
                                child: CustomReadOnlyTextField(
                                  '',
                                  nextActionDateControlller,
                                  validationRules: const ['required'],
                                  isReadOnly: true,
                                  onEditing: () =>
                                      _formKey.currentState!.validate(),
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
                        CustomDropDownButton(
                          Languages.of(context)!.rtpDenialReason,
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
                          selectedValue: selectedDropdownValue,
                          menuMaxHeight: 200,
                          onChanged: (newValue) {
                            setState(() {
                              selectedDropdownValue = newValue.toString();
                            });
                          },
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
                    fontWeight: FontWeight.w600,
                    onTap: () async {
                      if (_formKey.currentState!.validate() &&
                          (selectedDropdownValue != 'select')) {
                        var requestBodyData = DenialPostModel(
                          eventType: 'DENIAL',
                          caseId: widget.caseId,
                          eventCode: 'TELEVT004',
                          contractor: '0',
                          agrRef: '0',
                          eventAttr: EventAttr(
                              actionDate: nextActionDateControlller.text,
                              remarks: remarksControlller.text,
                              reasons: selectedDropdownValue,
                              agentLocation: AgentLocation()),
                          contact: Contact(
                            cType: widget.postValue['cType'],
                            value: widget.postValue['value'],
                          ),
                          createdBy: DateTime.now().toString(),
                          callID: '0',
                          callingID: '0',
                        );
                        Map<String, dynamic> postResult =
                            await APIRepository.apiRequest(
                                APIRequestType.POST,
                                HttpUrl.denialPostUrl(
                                    'denial', widget.userType),
                                requestBodydata: jsonEncode(requestBodyData));
                        if (postResult['success']) {
                          AppUtils.topSnackBar(
                              context, StringResource.successfullySubmitted);
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
