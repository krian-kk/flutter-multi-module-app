import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:origa/http/api_repository.dart';
import 'package:origa/http/httpurls.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/models/repo_post_model/repo_post_model.dart';
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

class CustomRepoBottomSheet extends StatefulWidget {
  const CustomRepoBottomSheet(this.cardTitle,
      {Key? key,
      required this.caseId,
      required this.customerLoanUserWidget,
      this.postValue,
      required this.userType})
      : super(key: key);
  final String cardTitle;
  final String caseId;
  final Widget customerLoanUserWidget;
  final String userType;
  final dynamic postValue;

  @override
  State<CustomRepoBottomSheet> createState() => _CustomRepoBottomSheetState();
}

class _CustomRepoBottomSheetState extends State<CustomRepoBottomSheet> {
  TextEditingController dateControlller = TextEditingController();
  TextEditingController timeControlller = TextEditingController();
  TextEditingController modelMakeControlller = TextEditingController();
  TextEditingController registrationNoControlller = TextEditingController();
  TextEditingController chassisNoControlller = TextEditingController();
  TextEditingController remarksControlller = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  List uploadFileLists = [];

  FocusNode modelMakeFocusNode = FocusNode();
  FocusNode registraionNoFocusNode = FocusNode();
  FocusNode chassisNoFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // DateTime currentDateTime = DateTime.now();
    // final hours = currentDateTime.hour.toString().padLeft(2, '0');
    // final minutes = currentDateTime.minute.toString().padLeft(2, '0');
    // dateControlller.text =
    //     DateFormat('dd-MM-yyyy').format(currentDateTime).toString();
    // timeControlller.text = '$hours:$minutes';
    // modelMakeControlller.text = '123';
    // registrationNoControlller.text = '123';
    // chassisNoControlller.text = '123';
    // remarksControlller.text = 'ABC';
  }

  getFiles() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(allowMultiple: true, type: FileType.any);
    if (result != null) {
      uploadFileLists =
          result.files.map((path) => path.path.toString()).toList();
    } else {
      AppUtils.showToast('Canceled', gravity: ToastGravity.CENTER);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: SizedBox(
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
                    padding: const EdgeInsets.fromLTRB(23, 16, 15, 5)),
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
                          Row(
                            children: [
                              Flexible(
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
                                  SizedBox(
                                    width:
                                        (MediaQuery.of(context).size.width) / 2,
                                    child: CustomReadOnlyTextField(
                                      '',
                                      dateControlller,
                                      validationRules: const ['required'],
                                      isReadOnly: true,
                                      onTapped: () => pickDate(
                                          context, dateControlller, _formKey),
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
                                    Languages.of(context)!.time,
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
                                      timeControlller,
                                      isReadOnly: true,
                                      validationRules: const ['required'],
                                      onTapped: () =>
                                          pickTime(context, timeControlller),
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
                          const SizedBox(height: 17),
                          Flexible(
                              child: CustomReadOnlyTextField(
                            Languages.of(context)!.modelMake,
                            modelMakeControlller,
                            focusNode: modelMakeFocusNode,
                            validationRules: const ['required'],
                            isLabel: true,
                            onEditing: () =>
                                registraionNoFocusNode.requestFocus(),
                          )),
                          const SizedBox(height: 17),
                          Flexible(
                              child: CustomReadOnlyTextField(
                            Languages.of(context)!.registrationNo,
                            registrationNoControlller,
                            focusNode: registraionNoFocusNode,
                            validationRules: const ['required'],
                            isLabel: true,
                            onEditing: () => chassisNoFocusNode.requestFocus(),
                          )),
                          const SizedBox(height: 17),
                          Flexible(
                              child: CustomReadOnlyTextField(
                            Languages.of(context)!.chassisNo,
                            chassisNoControlller,
                            focusNode: chassisNoFocusNode,
                            validationRules: const ['required'],
                            isLabel: true,
                            onEditing: () => chassisNoFocusNode.unfocus(),
                          )),
                          const SizedBox(height: 21),
                          CustomButton(
                            Languages.of(context)!.customUpload,
                            onTap: () => getFiles(),
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
                          const SizedBox(height: 17),
                          Flexible(
                              child: CustomReadOnlyTextField(
                            Languages.of(context)!.remarks,
                            remarksControlller,
                            validationRules: const ['required'],
                            isLabel: true,
                          )),
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
                        if (_formKey.currentState!.validate() &&
                            dateControlller.text != '' &&
                            timeControlller.text != '') {
                          if (uploadFileLists.isEmpty) {
                            AppUtils.showToast(
                              Constants.uploadDepositSlip,
                              gravity: ToastGravity.CENTER,
                            );
                          } else {
                            var requestBodyData = RepoPostModel(
                                eventType: Constants.repo,
                                caseId: widget.caseId,
                                eventCode: 'TELEVT016',
                                contact: [
                                  RepoContact(
                                    cType: widget.postValue['cType'],
                                    value: widget.postValue['value'],
                                  )
                                ],
                                eventAttr: EventAttr(
                                    modelMake: modelMakeControlller.text,
                                    registrationNo:
                                        registrationNoControlller.text,
                                    chassisNo: chassisNoControlller.text,
                                    remarks: remarksControlller.text,
                                    repo: Repo(),
                                    date: dateControlller.text,
                                    imageLocation:
                                        uploadFileLists as List<String>,
                                    agentLocation: AgentLocation()));
                            Map<String, dynamic> postResult =
                                await APIRepository.apiRequest(
                              APIRequestType.POST,
                              HttpUrl.repoPostUrl('repo', widget.userType),
                              requestBodydata:
                                  jsonEncode(requestBodyData.toJson()),
                            );
                            if (postResult['success']) {
                              AppUtils.topSnackBar(
                                  context, Constants.successfullySubmitted);
                              Navigator.pop(context);
                            }
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

  Future pickDate(BuildContext context, TextEditingController controller,
      GlobalKey<FormState> formKey) async {
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
      // formKey.currentState!.validate();
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
      // _formKey.currentState!.validate();
    });
  }
}
