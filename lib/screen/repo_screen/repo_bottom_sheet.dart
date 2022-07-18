import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:origa/http/api_repository.dart';
import 'package:origa/http/httpurls.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/models/repo_post_model/repo_post_model.dart';
import 'package:origa/screen/case_details_screen/bloc/case_details_bloc.dart';
import 'package:origa/singleton.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/constant_event_values.dart';
import 'package:origa/utils/constants.dart';
import 'package:origa/utils/firebase.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/utils/pick_date_time_utils.dart';
import 'package:origa/widgets/bottomsheet_appbar.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_cancel_button.dart';
import 'package:origa/widgets/custom_loading_widget.dart';
import 'package:origa/widgets/custom_read_only_text_field.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../models/speech2text_model.dart';
import '../../utils/string_resource.dart';
import '../../widgets/get_followuppriority_value.dart';

class CustomRepoBottomSheet extends StatefulWidget {
  const CustomRepoBottomSheet(
    this.cardTitle, {
    Key? key,
    required this.caseId,
    required this.customerLoanUserWidget,
    required this.bloc,
    this.postValue,
    required this.userType,
    required this.health,
  }) : super(key: key);
  final String cardTitle;
  final String caseId;
  final Widget customerLoanUserWidget;
  final String userType;
  final dynamic postValue;
  final String health;
  final CaseDetailsBloc bloc;

  @override
  State<CustomRepoBottomSheet> createState() => _CustomRepoBottomSheetState();
}

class _CustomRepoBottomSheetState extends State<CustomRepoBottomSheet> {
  late TextEditingController dateControlller;
  late TextEditingController timeControlller;
  late TextEditingController modelMakeControlller;
  late TextEditingController registrationNoControlller;
  late TextEditingController chassisNoControlller;
  late TextEditingController remarksControlller;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isSubmit = true;

  List<File> uploadFileLists = <File>[];

  String? isRecord;
  String translateText = '';
  bool isTranslate = true;

  late FocusNode modelMakeFocusNode;
  late FocusNode registraionNoFocusNode;
  late FocusNode chassisNoFocusNode;

  //Returned speech to text AAPI data
  Speech2TextModel returnS2Tdata = Speech2TextModel();

  @override
  void initState() {
    dateControlller = TextEditingController();
    timeControlller = TextEditingController();
    modelMakeControlller = TextEditingController();
    registrationNoControlller = TextEditingController();
    chassisNoControlller = TextEditingController();
    remarksControlller = TextEditingController();
    modelMakeFocusNode = FocusNode();
    registraionNoFocusNode = FocusNode();
    chassisNoFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    dateControlller.dispose();
    timeControlller.dispose();
    modelMakeControlller.dispose();
    registrationNoControlller.dispose();
    chassisNoControlller.dispose();
    remarksControlller.dispose();
    modelMakeFocusNode.dispose();
    registraionNoFocusNode.dispose();
    chassisNoFocusNode.dispose();
    super.dispose();
  }

  getFiles() async {
    final FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result != null) {
      uploadFileLists =
          result.paths.map((String? path) => File(path!)).toList();
      AppUtils.showToast(StringResource.fileUploadMessage);
    } else {
      AppUtils.showToast(Languages.of(context)!.canceled);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.89,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.transparent,
        body: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
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
                          children: <Widget>[
                            Flexible(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                // CustomText(
                                //   Languages.of(context)!.date,
                                //   fontSize: FontSize.twelve,
                                //   fontWeight: FontWeight.w400,
                                //   color: ColorResource.color666666,
                                //   fontStyle: FontStyle.normal,
                                // ),
                                SizedBox(
                                  width:
                                      (MediaQuery.of(context).size.width) / 2,
                                  child: CustomReadOnlyTextField(
                                    Languages.of(context)!.date,
                                    dateControlller,
                                    validationRules: const <String>['required'],
                                    isReadOnly: true,
                                    isLabel: true,
                                    onTapped: () =>
                                        PickDateAndTimeUtils.pickDate(context,
                                            (String? newDate,
                                                String? followUpDate) {
                                      if (newDate != null &&
                                          followUpDate != null) {
                                        setState(() {
                                          dateControlller.text = newDate;
                                        });
                                        widget.bloc.add(ChangeFollowUpDateEvent(
                                            followUpDate: followUpDate));
                                      }
                                    }),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                // CustomText(
                                //   Languages.of(context)!.time,
                                //   fontSize: FontSize.twelve,
                                //   fontWeight: FontWeight.w400,
                                //   color: ColorResource.color666666,
                                //   fontStyle: FontStyle.normal,
                                // ),
                                SizedBox(
                                  width:
                                      (MediaQuery.of(context).size.width) / 2,
                                  child: CustomReadOnlyTextField(
                                    Languages.of(context)!.time,
                                    timeControlller,
                                    isReadOnly: true,
                                    isLabel: true,
                                    validationRules: const <String>['required'],
                                    onTapped: () =>
                                        PickDateAndTimeUtils.pickTime(context,
                                            (String? newTime) {
                                      if (newTime != null) {
                                        setState(() {
                                          timeControlller.text = newTime.trim();
                                        });
                                      }
                                    }),
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
                          validationRules: const <String>['required'],
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
                          validationRules: const <String>['required'],
                          isLabel: true,
                          onEditing: () => chassisNoFocusNode.requestFocus(),
                        )),
                        const SizedBox(height: 17),
                        Flexible(
                            child: CustomReadOnlyTextField(
                          Languages.of(context)!.chassisNo,
                          chassisNoControlller,
                          focusNode: chassisNoFocusNode,
                          validationRules: const <String>['required'],
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
                          validationRules: const <String>['required'],
                          isVoiceRecordWidget: true,
                          returnS2Tresponse: (dynamic val) {
                            if (val is Speech2TextModel) {
                              setState(() {
                                returnS2Tdata = val;
                              });
                            }
                          },
                          checkRecord: (String? isRecord, String? text,
                              Speech2TextModel returnS2Tdata) {
                            setState(() {
                              this.returnS2Tdata = returnS2Tdata;
                              this.isRecord = isRecord;
                              translateText = text!;
                              isTranslate = true;
                            });
                          },
                          isSubmit: isTranslate,
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
            boxShadow: <BoxShadow>[
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
              children: <Widget>[
                Expanded(
                  child: CustomCancelButton.cancelButton(context),
                ),
                const SizedBox(width: 25),
                SizedBox(
                  width: 191,
                  child: CustomButton(
                    isSubmit
                        ? Languages.of(context)!.submit.toUpperCase()
                        : null,
                    isLeading: !isSubmit,
                    trailingWidget: CustomLoadingWidget(
                      gradientColors: <Color>[
                        ColorResource.colorFFFFFF,
                        ColorResource.colorFFFFFF.withOpacity(0.7),
                      ],
                    ),
                    fontSize: FontSize.sixteen,
                    onTap: isSubmit
                        ? () async {
                            if (await AppUtils.checkGPSConnection(context)) {
                              if (await AppUtils.checkLocationPermission()) {
                                if (isRecord == Constants.process) {
                                  AppUtils.showToast(
                                      'Stop the Record then Submit');
                                } else if (isRecord == Constants.stop) {
                                  AppUtils.showToast(
                                      'Please wait audio is converting');
                                } else {
                                  if (isRecord == Constants.submit) {
                                    setState(() => remarksControlller.text =
                                        translateText);
                                    setState(() => isTranslate = false);
                                  }
                                  if (_formKey.currentState!.validate() &&
                                      dateControlller.text != '' &&
                                      timeControlller.text != '') {
                                    if (uploadFileLists.isEmpty) {
                                      AppUtils.showToast(
                                        Languages.of(context)!.uploadImage,
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

                                      final GeolocatorPlatform
                                          geolocatorPlatform =
                                          GeolocatorPlatform.instance;

                                      final Position res =
                                          await geolocatorPlatform
                                              .getCurrentPosition();
                                      setState(() {
                                        position = res;
                                      });
                                      final RepoPostModel requestBodyData =
                                          RepoPostModel(
                                              eventId: ConstantEventValues
                                                  .repoEventId,
                                              eventType: Constants.repo,
                                              caseId: widget.caseId,
                                              eventCode: ConstantEventValues
                                                  .repoEvenCode,
                                              voiceCallEventCode: ConstantEventValues
                                                  .voiceCallEventCode,
                                              // createdAt: (ConnectivityResult.none ==
                                              //         await Connectivity()
                                              //             .checkConnectivity())
                                              //     ? DateTime.now().toString()
                                              //     : null,
                                              createdBy:
                                                  Singleton.instance.agentRef ??
                                                      '',
                                              agentName:
                                                  Singleton.instance.agentName ??
                                                      '',
                                              agrRef: Singleton.instance.agrRef ??
                                                  '',
                                              contractor:
                                                  Singleton.instance.contractor ??
                                                      '',
                                              eventModule: (widget.userType ==
                                                      Constants.telecaller)
                                                  ? 'Telecalling'
                                                  : 'Field Allocation',
                                              contact: RepoContact(
                                                cType:
                                                    widget.postValue['cType'],
                                                value:
                                                    widget.postValue['value'],
                                                health: widget.health,
                                              ),
                                              callID: Singleton.instance.callID
                                                  .toString(),
                                              callingID: Singleton
                                                  .instance.callingID
                                                  .toString(),
                                              callerServiceID: Singleton
                                                  .instance.callerServiceID
                                                  .toString(),
                                              invalidNumber: Singleton
                                                  .instance.invalidNumber
                                                  .toString(),
                                              eventAttr: EventAttr(
                                                modelMake:
                                                    modelMakeControlller.text,
                                                registrationNo:
                                                    registrationNoControlller
                                                        .text,
                                                chassisNo:
                                                    chassisNoControlller.text,
                                                remarks:
                                                    remarksControlller.text,
                                                repo: Repo(),
                                                date: dateControlller.text
                                                        .trim() +
                                                    'T' +
                                                    timeControlller.text
                                                        .trim() +
                                                    ':00.000Z',
                                                imageLocation: <String>[],
                                                customerName: Singleton.instance
                                                        .caseCustomerName ??
                                                    '',
                                                followUpPriority:
                                                    EventFollowUpPriority
                                                        .connectedFollowUpPriority(
                                                  currentCaseStatus: widget
                                                      .bloc
                                                      .caseDetailsAPIValue
                                                      .result!
                                                      .caseDetails!
                                                      .telSubStatus!,
                                                  eventType: 'REPO',
                                                  currentFollowUpPriority:
                                                      widget
                                                          .bloc
                                                          .caseDetailsAPIValue
                                                          .result!
                                                          .caseDetails!
                                                          .followUpPriority!,
                                                ),
                                                longitude: position.longitude,
                                                latitude: position.latitude,
                                                accuracy: position.accuracy,
                                                altitude: position.altitude,
                                                heading: position.heading,
                                                speed: position.speed,
                                                reginalText: returnS2Tdata
                                                    .result?.reginalText,
                                                translatedText: returnS2Tdata
                                                    .result?.translatedText,
                                                audioS3Path: returnS2Tdata
                                                    .result?.audioS3Path,
                                              ));

                                      debugPrint(
                                          "requestg body data for REPO ----> ${jsonEncode(requestBodyData)}");

                                      final Map<String, dynamic> postdata =
                                          jsonDecode(jsonEncode(
                                                  requestBodyData.toJson()))
                                              as Map<String, dynamic>;
                                      final List<dynamic> value = <dynamic>[];
                                      for (File element in uploadFileLists) {
                                        value.add(await MultipartFile.fromFile(
                                            element.path.toString()));
                                      }
                                      postdata.addAll(<String, dynamic>{
                                        'files': value,
                                      });

                                      if (ConnectivityResult.none ==
                                          await Connectivity()
                                              .checkConnectivity()) {
                                        final Map<String, dynamic>
                                            firebaseObject =
                                            requestBodyData.toJson();
                                        try {
                                          firebaseObject.addAll(
                                              await FirebaseUtils
                                                  .toPrepareFileStoringModel(
                                                      uploadFileLists));
                                        } catch (e) {
                                          debugPrint(
                                              'Exception while converting base64 ${e.toString()}');
                                        }
                                        await FirebaseUtils.storeEvents(
                                                eventsDetails: firebaseObject,
                                                caseId: widget.caseId,
                                                selectedFollowUpDate:
                                                    dateControlller.text,
                                                selectedClipValue:
                                                    Constants.repo,
                                                bloc: widget.bloc)
                                            .whenComplete(() {
                                          AppUtils.topSnackBar(context,
                                              Constants.successfullySubmitted);
                                        });
                                      } else {
                                        final Map<String, dynamic> postResult =
                                            await APIRepository.apiRequest(
                                          APIRequestType.upload,
                                          HttpUrl.repoPostUrl(
                                              'repo', widget.userType),
                                          formDatas: FormData.fromMap(postdata),
                                        );
                                        if (postResult[Constants.success]) {
                                          final Map<String, dynamic>
                                              firebaseObject =
                                              requestBodyData.toJson();
                                          try {
                                            firebaseObject.addAll(
                                                await FirebaseUtils
                                                    .toPrepareFileStoringModel(
                                                        uploadFileLists));
                                          } catch (e) {
                                            debugPrint(
                                                'Exception while converting base64 ${e.toString()}');
                                          }
                                          await FirebaseUtils.storeEvents(
                                                  eventsDetails: firebaseObject,
                                                  caseId: widget.caseId,
                                                  selectedFollowUpDate:
                                                      dateControlller.text,
                                                  selectedClipValue:
                                                      Constants.repo,
                                                  bloc: widget.bloc)
                                              .whenComplete(() {});
                                          // here update followUpPriority value.
                                          widget
                                                  .bloc
                                                  .caseDetailsAPIValue
                                                  .result!
                                                  .caseDetails!
                                                  .followUpPriority =
                                              requestBodyData
                                                  .eventAttr.followUpPriority;

                                          widget.bloc.add(
                                            ChangeIsSubmitForMyVisitEvent(
                                              Constants.repo,
                                            ),
                                          );
                                          // set speech to text data is null
                                          returnS2Tdata.result?.reginalText =
                                              null;
                                          returnS2Tdata.result?.translatedText =
                                              null;
                                          returnS2Tdata.result?.audioS3Path =
                                              null;
                                          AppUtils.topSnackBar(context,
                                              Constants.successfullySubmitted);
                                          widget.bloc.add(
                                            ChangeHealthStatusEvent(),
                                          );
                                          Navigator.pop(context);
                                        }
                                      }
                                    }
                                  }
                                }
                                setState(() => isSubmit = true);
                              }
                            }
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
    );
  }
}
