import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:origa/http/api_repository.dart';
import 'package:origa/http/httpurls.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/models/repo_post_model/repo_post_model.dart';
import 'package:origa/singleton.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/constant_event_values.dart';
import 'package:origa/utils/constants.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/widgets/bottomsheet_appbar.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_read_only_text_field.dart';
import 'package:origa/widgets/custom_text.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

class CustomRepoBottomSheet extends StatefulWidget {
  const CustomRepoBottomSheet(
    this.cardTitle, {
    Key? key,
    required this.caseId,
    required this.customerLoanUserWidget,
    this.postValue,
    required this.userType,
  }) : super(key: key);
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

  bool isSubmit = true;

  List uploadFileLists = [];

  FocusNode modelMakeFocusNode = FocusNode();
  FocusNode registraionNoFocusNode = FocusNode();
  FocusNode chassisNoFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
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
                                        ImageResource.clock,
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
                      isSubmit
                          ? Languages.of(context)!.submit.toUpperCase()
                          : null,
                      isLeading: !isSubmit,
                      trailingWidget: const Center(
                        child: CircularProgressIndicator(
                          color: ColorResource.colorFFFFFF,
                        ),
                      ),
                      fontSize: FontSize.sixteen,
                      fontWeight: FontWeight.w600,
                      onTap: isSubmit
                          ? () async {
                              if (_formKey.currentState!.validate() &&
                                  dateControlller.text != '' &&
                                  timeControlller.text != '') {
                                if (uploadFileLists.isEmpty) {
                                  AppUtils.showToast(
                                    Constants.uploadDepositSlip,
                                    gravity: ToastGravity.CENTER,
                                  );
                                } else {
                                  setState(() => isSubmit = false);
                                  Position position = Position(
                                    longitude: 0,
                                    latitude: 0,
                                    timestamp: DateTime.now(),
                                    accuracy: 0,
                                    altitude: 0,
                                    heading: 0,
                                    speed: 0,
                                    speedAccuracy: 0,
                                  );
                                  if (Geolocator.checkPermission().toString() !=
                                      PermissionStatus.granted.toString()) {
                                    Position res =
                                        await Geolocator.getCurrentPosition(
                                            desiredAccuracy:
                                                LocationAccuracy.best);
                                    setState(() {
                                      position = res;
                                    });
                                  }
                                  var requestBodyData = RepoPostModel(
                                      eventId: ConstantEventValues.repoEventId,
                                      eventType: Constants.repo,
                                      caseId: widget.caseId,
                                      eventCode: 'TELEVT016',
                                      callerServiceID: 'Kaleyra_123',
                                      voiceCallEventCode: ConstantEventValues
                                          .voiceCallEventCode,
                                      createdBy:
                                          Singleton.instance.agentRef ?? '',
                                      agentName:
                                          Singleton.instance.agentName ?? '',
                                      agrRef: Singleton.instance.agrRef ?? '',
                                      eventModule: (widget.userType ==
                                              Constants.telecaller)
                                          ? 'Telecalling'
                                          : 'Field Allocation',
                                      contact: [
                                        RepoContact(
                                          cType: widget.postValue['cType'],
                                          value: widget.postValue['value'],
                                          health:
                                              ConstantEventValues.repoHealth,
                                          resAddressId0: Singleton
                                                  .instance.resAddressId_0 ??
                                              '',
                                          contactId0:
                                              Singleton.instance.contactId_0 ??
                                                  '',
                                        )
                                      ],
                                      callID: Singleton.instance.callID,
                                      callingID: Singleton.instance.callingID,
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
                                        customerName: '',
                                        longitude: position.longitude,
                                        latitude: position.latitude,
                                        accuracy: position.accuracy,
                                        altitude: position.altitude,
                                        heading: position.heading,
                                        speed: position.speed,
                                      ));
                                  Map<String, dynamic> postResult =
                                      await APIRepository.apiRequest(
                                    APIRequestType.POST,
                                    HttpUrl.repoPostUrl(
                                        'repo', widget.userType),
                                    requestBodydata:
                                        jsonEncode(requestBodyData.toJson()),
                                  );
                                  if (postResult[Constants.success]) {
                                    AppUtils.topSnackBar(context,
                                        Constants.successfullySubmitted);
                                    Navigator.pop(context);
                                  }
                                }
                              }
                              setState(() => isSubmit = true);
                            }
                          : () {},
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
    });
  }
}
