import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:origa/http/api_repository.dart';
import 'package:origa/http/httpurls.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/models/other_feed_back_post_model/other_feed_back_post_model.dart';
import 'package:origa/models/other_feedback_model.dart';
import 'package:origa/screen/case_details_screen/bloc/case_details_bloc.dart';
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

class CustomOtherFeedBackBottomSheet extends StatefulWidget {
  final CaseDetailsBloc bloc;
  const CustomOtherFeedBackBottomSheet(this.cardTitle, this.bloc,
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
  State<CustomOtherFeedBackBottomSheet> createState() =>
      _CustomOtherFeedBackBottomSheetState();
}

class _CustomOtherFeedBackBottomSheetState
    extends State<CustomOtherFeedBackBottomSheet> {
  TextEditingController dateControlller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List uploadFileLists = [];

  getFiles() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(allowMultiple: true, type: FileType.audio);
    if (result != null) {
      if ((result.files.first.size) / 1048576.ceil() > 5) {
        AppUtils.showToast('Please Select Minimum 5 MB File.',
            gravity: ToastGravity.CENTER);
      } else {
        uploadFileLists =
            result.files.map((path) => path.path.toString()).toList();
      }
    } else {
      AppUtils.showToast('Canceled', gravity: ToastGravity.CENTER);
    }
  }

  @override
  void initState() {
    super.initState();
    // DateTime currentDateTime = DateTime.now();
    // dateControlller.text =
    //     DateFormat('dd-MM-yyyy').format(currentDateTime).toString();
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
                                width:
                                    (MediaQuery.of(context).size.width - 44) /
                                        2,
                                child: CustomReadOnlyTextField(
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
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 25),
                          CustomText(
                            Languages.of(context)!.customerMetCategory,
                            fontSize: FontSize.fourteen,
                            fontWeight: FontWeight.w700,
                            color: ColorResource.color000000,
                            fontStyle: FontStyle.normal,
                          ),
                          const SizedBox(height: 10),
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: widget.bloc.expandOtherFeedback.length,
                            itemBuilder: (context, int index) => expandList(
                                widget.bloc.expandOtherFeedback, index),
                          ),
                          const SizedBox(height: 25),
                          GestureDetector(
                            onTap: () {},
                            child: SizedBox(
                              width: double.infinity,
                              // height: 56,
                              child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                    side: const BorderSide(
                                      width: 0.5,
                                      color: ColorResource.colorDADADA,
                                    ),
                                  ),
                                  color: ColorResource.color23375A,
                                  elevation: 2,
                                  child: GestureDetector(
                                    onTap: () => getFiles(),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SvgPicture.asset(
                                                  ImageResource.upload),
                                              const SizedBox(width: 5),
                                              const CustomText(
                                                'UPLOAD AUDIO FILE',
                                                color:
                                                    ColorResource.colorFFFFFF,
                                                fontSize: FontSize.sixteen,
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.w700,
                                              )
                                            ],
                                          ),
                                          const CustomText(
                                            'UPTO 5MB',
                                            lineHeight: 1,
                                            color: ColorResource.colorFFFFFF,
                                            fontSize: FontSize.twelve,
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.w700,
                                          )
                                        ],
                                      ),
                                    ),
                                  )),
                            ),
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
                          if (uploadFileLists.isEmpty) {
                            AppUtils.showToast(
                              Constants.uploadDepositSlip,
                              gravity: ToastGravity.CENTER,
                            );
                          } else {
                            var requestBodyData = OtherFeedBackPostModel(
                                eventType: Constants.feedBack,
                                caseId: widget.caseId,
                                eventCode: 'TELEVT002',
                                eventAttr: EventAttr(
                                    actionDate: dateControlller.text,
                                    imageLocation:
                                        uploadFileLists as List<String>,
                                    agentLocation: AgentLocation()),
                                contact: [
                                  OtherFeedBackContact(
                                    cType: widget.postValue['cType'].toString(),
                                    value: widget.postValue['value'].toString(),
                                  )
                                ]);

                            Map<String, dynamic> postResult =
                                await APIRepository.apiRequest(
                              APIRequestType.POST,
                              HttpUrl.reminderPostUrl(
                                  'feedback', widget.userType),
                              requestBodydata:
                                  jsonEncode(requestBodyData.toJson()),
                            );
                            if (postResult['success']) {
                              AppUtils.topSnackBar(
                                  context, Constants.successfullySubmitted);
                              Navigator.pop(context);
                            } else {}
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

  expandList(List<OtherFeedbackExpandModel> expandedList, int index) {
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
                  const SizedBox(
                    height: 13,
                  )
                ],
                onExpansionChanged: (bool status) {
                  setState(() {
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
