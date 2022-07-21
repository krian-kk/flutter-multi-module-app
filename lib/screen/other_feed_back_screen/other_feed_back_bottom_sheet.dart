import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:origa/http/api_repository.dart';
import 'package:origa/http/httpurls.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/models/add_new_contact_model.dart';
import 'package:origa/models/contractor_detail_model.dart';
import 'package:origa/models/other_feed_back_post_model/other_feed_back_post_model.dart';
import 'package:origa/models/update_health_model.dart';
import 'package:origa/screen/allocation/bloc/allocation_bloc.dart';
import 'package:origa/screen/case_details_screen/bloc/case_details_bloc.dart';
import 'package:origa/singleton.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/call_status_utils.dart';
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
import 'package:origa/widgets/custom_drop_down_button.dart';
import 'package:origa/widgets/custom_loading_widget.dart';
import 'package:origa/widgets/custom_read_only_text_field.dart';
import 'package:origa/widgets/custom_text.dart';
import 'package:origa/widgets/ios_keyboard_actions.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../models/speech2text_model.dart';
import '../../utils/string_resource.dart';
import '../../widgets/get_followuppriority_value.dart';

class CustomOtherFeedBackBottomSheet extends StatefulWidget {
  const CustomOtherFeedBackBottomSheet(
    this.cardTitle,
    this.bloc, {
    Key? key,
    required this.caseId,
    required this.customerLoanUserWidget,
    required this.userType,
    this.postValue,
    this.isCall,
    required this.health,
    this.isAutoCalling = false,
    this.allocationBloc,
    this.paramValue,
    this.isCallFromCaseDetails = false,
    this.callId,
  }) : super(key: key);
  final CaseDetailsBloc bloc;

  final String cardTitle;
  final String caseId;
  final Widget customerLoanUserWidget;
  final String userType;
  final dynamic postValue;
  final bool? isCall;
  final String health;
  final bool isAutoCalling;
  final AllocationBloc? allocationBloc;
  final dynamic paramValue;
  final bool isCallFromCaseDetails;
  final String? callId;

  @override
  State<CustomOtherFeedBackBottomSheet> createState() =>
      _CustomOtherFeedBackBottomSheetState();
}

class _CustomOtherFeedBackBottomSheetState
    extends State<CustomOtherFeedBackBottomSheet> {
  late TextEditingController dateControlller;
  late TextEditingController remarksController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<File> uploadFileLists = <File>[];
  bool isSubmit = true;

  List<AddNewContactFieldModel> listOfContact = <AddNewContactFieldModel>[
    AddNewContactFieldModel(TextEditingController(), '', FocusNode()),
  ];

  List<dynamic> otherFeedbackContact = <dynamic>[];

  // check vehicle available or not
  bool isVehicleAvailable = false;

  List<String> collectorFeedBackValueDropdownList = <String>[];
  String? collectorFeedBackValue;

  List<String> actionproposedDropdownValue = <String>[];
  String? actionproposedValue;

  //Returned speech to text AAPI data
  Speech2TextModel returnS2Tdata = Speech2TextModel();

  String? isRecord;
  String translateText = '';
  bool isTranslate = true;

  getFiles() async {
    final FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result != null) {
      if ((result.files.first.size) / 1048576.ceil() > 5) {
        AppUtils.showToast(
          Languages.of(context)!.pleaseSelectMaximum5MbFile,
          gravity: ToastGravity.CENTER,
        );
      } else {
        uploadFileLists =
            result.paths.map((String? path) => File(path!)).toList();
        AppUtils.showToast(StringResource.fileUploadMessage);
      }
    } else {
      AppUtils.showToast(Languages.of(context)!.canceled);
    }
  }

  @override
  void initState() {
    dateControlller = TextEditingController();
    remarksController = TextEditingController();
    if (Singleton.instance.feedbackTemplate?.result!.feedbackTemplate != null) {
      isVehicleAvailable = Singleton.instance.feedbackTemplate?.result!
              .feedbackTemplate![0].data![0].value ??
          false;
    }
    setState(() {
      dateControlller.text = DateFormat('yyyy-MM-dd')
          .format(DateTime.now().add(const Duration(days: 1)));
      widget.bloc.add(ChangeFollowUpDateEvent(
          followUpDate:
              DateTime.now().add(const Duration(days: 1)).toString()));
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    dateControlller.dispose();
    remarksController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CaseDetailsBloc, CaseDetailsState>(
      bloc: widget.bloc,
      listener: (BuildContext context, CaseDetailsState state) {
        if (state is UpdateHealthStatusState) {
          final UpdateHealthStatusModel data = UpdateHealthStatusModel.fromJson(
              Map<String, dynamic>.from(Singleton.instance.updateHealthStatus));

          setState(() {
            switch (data.tabIndex) {
              case 0:
                widget.bloc.caseDetailsAPIValue.result
                    ?.callDetails![data.selectedHealthIndex!]['health'] = '2';
                break;
              case 1:
                widget.bloc.caseDetailsAPIValue.result
                    ?.callDetails![data.selectedHealthIndex!]['health'] = '1';
                break;
              case 2:
                widget.bloc.caseDetailsAPIValue.result
                    ?.callDetails![data.selectedHealthIndex!]['health'] = '0';
                break;
              default:
                widget.bloc.caseDetailsAPIValue.result
                        ?.callDetails![data.selectedHealthIndex!]['health'] =
                    data.currentHealth;
                break;
            }
          });
        }
      },
      child: BlocBuilder<CaseDetailsBloc, CaseDetailsState>(
        bloc: widget.bloc,
        builder: (BuildContext context, CaseDetailsState state) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.89,
            child: Scaffold(
              backgroundColor: Colors.transparent,
              resizeToAvoidBottomInset: true,
              body: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    BottomSheetAppbar(
                      title: widget.cardTitle,
                      padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15)
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  // CustomText(
                                  //   Languages.of(context)!.nextActionDate,
                                  //   fontSize: FontSize.twelve,
                                  //   fontWeight: FontWeight.w400,
                                  //   color: ColorResource.color666666,
                                  //   fontStyle: FontStyle.normal,
                                  // ),
                                  SizedBox(
                                    width: (MediaQuery.of(context).size.width -
                                            44) /
                                        2,
                                    child: CustomReadOnlyTextField(
                                      Languages.of(context)!.nextActionDate,
                                      dateControlller,
                                      validationRules: const <String>[
                                        'required'
                                      ],
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
                                          widget.bloc.add(
                                              ChangeFollowUpDateEvent(
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
                              ),
                              const SizedBox(height: 20),
                              expandList(<FeedbackTemplate>[
                                FeedbackTemplate(
                                    name: Languages.of(context)!.addNewContact,
                                    expanded: false,
                                    data: <Data>[Data(name: 'addNewContact')])
                              ], 0),
                              ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: Singleton.instance.feedbackTemplate
                                          ?.result?.feedbackTemplate?.length ??
                                      0,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return expandList(
                                        Singleton.instance.feedbackTemplate!
                                            .result!.feedbackTemplate!,
                                        index);
                                  }),
                              const SizedBox(height: 5),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 13),
                                child: CustomReadOnlyTextField(
                                  Languages.of(context)!.remark + '*',
                                  remarksController,
                                  validationRules: const <String>['required'],
                                  isLabel: true,
                                  isVoiceRecordWidget: true,
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
                                  returnS2Tresponse: (dynamic val) {
                                    if (val is Speech2TextModel) {
                                      setState(() {
                                        returnS2Tdata = val;
                                      });
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(height: 25),
                              GestureDetector(
                                onTap: () {},
                                child: SizedBox(
                                  width: double.infinity,
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
                                      child: InkWell(
                                        onTap: () => getFiles(),
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              8, 10, 5, 15),
                                          child: Column(
                                            children: <Widget>[
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  SvgPicture.asset(
                                                      ImageResource.upload),
                                                  const SizedBox(width: 7),
                                                  Flexible(
                                                    child: CustomText(
                                                      Languages.of(context)!
                                                          .uploadFile,
                                                      color: ColorResource
                                                          .colorFFFFFF,
                                                      fontSize:
                                                          FontSize.sixteen,
                                                      lineHeight: 1,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              const SizedBox(height: 3),
                                              CustomText(
                                                Languages.of(context)!.upto5mb,
                                                lineHeight: 1,
                                                color:
                                                    ColorResource.colorFFFFFF,
                                                fontSize: FontSize.twelve,
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Singleton.instance.startCalling ?? false
                          ? const SizedBox()
                          : Expanded(
                              child: CustomCancelButton.cancelButton(context),
                            ),
                      SizedBox(
                          width: Singleton.instance.startCalling ?? false
                              ? 0
                              : 25),
                      Singleton.instance.startCalling ?? false
                          ? SizedBox(
                              width: Singleton.instance.startCalling ?? false
                                  ? 150
                                  : 191,
                              child: CustomButton(
                                isSubmit
                                    ? Languages.of(context)!
                                            .stop
                                            .toUpperCase() +
                                        ' & \n' +
                                        Languages.of(context)!
                                            .submit
                                            .toUpperCase()
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
                                        if (await AppUtils.checkGPSConnection(
                                            context)) {
                                          if (await AppUtils
                                              .checkLocationPermission(
                                                  context)) {
                                            submitOtherFeedbackEvent(true);
                                          }
                                        }
                                      }
                                    : () {},
                                cardShape: 5,
                              ),
                            )
                          : const SizedBox(),
                      SizedBox(
                        width: Singleton.instance.startCalling ?? false
                            ? 150
                            : 191,
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
                                  if (await AppUtils.checkGPSConnection(
                                      context)) {
                                    if (await AppUtils.checkLocationPermission(
                                        context)) {
                                      submitOtherFeedbackEvent(false);
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
        },
      ),
    );
  }

  submitOtherFeedbackEvent(bool stopValue) async {
    setState(() {});
    otherFeedbackContact.clear();
    for (int i = 0; i < (listOfContact.length); i++) {
      if (listOfContact[i].controller.text.isNotEmpty) {
        otherFeedbackContact.add(OtherFeedBackContact(
            cType: listOfContact[i].formValue.toLowerCase(),
            value: listOfContact[i].controller.text,
            contactId0: '',
            resAddressId0: ''));
      } else {
        // otherFeedbackContact.clear();
      }
    }
    // SharedPreferences _pref =
    //     await SharedPreferences.getInstance();
    if (isRecord == Constants.process) {
      AppUtils.showToast('Stop the Record then Submit');
    } else if (isRecord == Constants.stop) {
      AppUtils.showToast('Please wait audio is converting');
    } else {
      if (isRecord == Constants.submit) {
        setState(() => remarksController.text = translateText);
        setState(() => isTranslate = false);
      }
      if (_formKey.currentState!.validate()) {
        // if (uploadFileLists.isEmpty) {
        //   AppUtils.showToast(
        //     'upload of audio file',
        //     gravity: ToastGravity.CENTER,
        //   );
        // } else {
        setState(() => isSubmit = false);
        bool isNotAutoCalling = true;

        if (widget.isAutoCalling ||
            (widget.isCallFromCaseDetails && widget.callId != null)) {
          await CallCustomerStatus.callStatusCheck(
                  callId: (widget.isCallFromCaseDetails)
                      ? widget.callId
                      : widget.paramValue['callId'],
                  context: context)
              .then((bool value) {
            isNotAutoCalling = value;
          });
        }
        if (isNotAutoCalling) {
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

          final GeolocatorPlatform geolocatorPlatform =
              GeolocatorPlatform.instance;

          final Position res = await geolocatorPlatform.getCurrentPosition();
          if (mounted) {
            setState(() {
              position = res;
            });
          }
          final OtherFeedBackPostModel requestBodyData = OtherFeedBackPostModel(
            eventId: ConstantEventValues.otherFeedbackEventId,
            eventType:
                (widget.userType == Constants.telecaller || widget.isCall!)
                    ? 'TC : FEEDBACK'
                    : 'FEEDBACK',
            voiceCallEventCode: ConstantEventValues.voiceCallEventCode,
            // createdAt: (ConnectivityResult.none ==
            //         await Connectivity().checkConnectivity())
            //     ? DateTime.now().toString()
            //     : null,
            createdBy: Singleton.instance.agentRef ?? '',
            agentName: Singleton.instance.agentName ?? '',
            agrRef: Singleton.instance.agrRef ?? '',
            contractor: Singleton.instance.contractor ?? '',
            callID: Singleton.instance.callID,
            callerServiceID: Singleton.instance.callerServiceID,
            callingID: Singleton.instance.callingID,
            caseId: widget.caseId,
            eventCode: ConstantEventValues.otherFeedbackEvenCode,
            eventModule: widget.isCall! ? 'Telecalling' : 'Field Allocation',
            invalidNumber: Singleton.instance.invalidNumber.toString(),
            eventAttr: EventAttr(
              remarks: remarksController.text,
              vehicleavailable: isVehicleAvailable,
              collectorfeedback: collectorFeedBackValue ?? '',
              actionproposed: actionproposedValue ?? '',
              actionDate: dateControlller.text,
              imageLocation: <String>[],
              longitude: position.longitude,
              latitude: position.latitude,
              accuracy: position.accuracy,
              altitude: position.altitude,
              heading: position.heading,
              speed: position.speed,
              altitudeAccuracy: 0,
              // agentLocation: AgentLocation(),
              followUpPriority: EventFollowUpPriority.connectedFollowUpPriority(
                currentCaseStatus: widget.bloc.caseDetailsAPIValue.result!
                    .caseDetails!.telSubStatus!,
                eventType: 'Feedback',
                currentFollowUpPriority: widget.bloc.caseDetailsAPIValue.result!
                    .caseDetails!.followUpPriority!,
              ),
              contact:
                  otherFeedbackContact.isNotEmpty ? otherFeedbackContact : null,
              reginalText: returnS2Tdata.result?.reginalText,
              translatedText: returnS2Tdata.result?.translatedText,
              audioS3Path: returnS2Tdata.result?.audioS3Path,
            ),
            contact: OtherFeedBackContact(
              cType: widget.postValue['cType'],
              health: widget.health,
              value: widget.postValue['value'],
              resAddressId0: widget.postValue['resAddressId_0'] ?? '',
              contactId0: widget.postValue['contactId0'] ?? '',
            ),
          );
          final Map<String, dynamic> postdata =
              jsonDecode(jsonEncode(requestBodyData.toJson()))
                  as Map<String, dynamic>;
          final List<dynamic> value = <dynamic>[];
          for (File element in uploadFileLists) {
            value.add(await MultipartFile.fromFile(element.path.toString()));
          }
          postdata.addAll(<String, dynamic>{
            'files': value,
          });

          if (ConnectivityResult.none ==
              await Connectivity().checkConnectivity()) {
            final Map<String, dynamic> firebaseObject =
                requestBodyData.toJson();
            try {
              firebaseObject.addAll(
                  await FirebaseUtils.toPrepareFileStoringModel(
                      uploadFileLists));
            } catch (e) {
              debugPrint('Exception while converting base64 ${e.toString()}');
            }

            await FirebaseUtils.storeEvents(
                    eventsDetails: firebaseObject,
                    caseId: widget.caseId,
                    selectedFollowUpDate: dateControlller.text,
                    selectedClipValue: Constants.otherFeedback,
                    bloc: widget.bloc)
                .whenComplete(() {
              AppUtils.topSnackBar(context, Constants.successfullySubmitted);
            });
          } else {
            final Map<String, dynamic> postResult =
                await APIRepository.apiRequest(
              APIRequestType.upload,
              HttpUrl.otherFeedBackPostUrl('feedback', widget.userType),
              formDatas: FormData.fromMap(postdata),
            );
            if (postResult[Constants.success]) {
              final Map<String, dynamic> firebaseObject =
                  requestBodyData.toJson();
              try {
                firebaseObject.addAll(
                    await FirebaseUtils.toPrepareFileStoringModel(
                        uploadFileLists));
              } catch (e) {
                debugPrint('Exception while converting base64 ${e.toString()}');
              }
              await FirebaseUtils.storeEvents(
                      eventsDetails: firebaseObject,
                      caseId: widget.caseId,
                      selectedFollowUpDate: dateControlller.text,
                      selectedClipValue: Constants.otherFeedback,
                      bloc: widget.bloc)
                  .whenComplete(() {});
              // here update followUpPriority value.
              widget.bloc.caseDetailsAPIValue.result!.caseDetails!
                      .followUpPriority =
                  requestBodyData.eventAttr.followUpPriority;

              widget.bloc.add(
                ChangeIsSubmitForMyVisitEvent(
                  Constants.otherFeedback,
                ),
              );
              widget.bloc.add(
                ChangeHealthStatusEvent(),
              );

              // set speech to text data is null
              returnS2Tdata.result?.reginalText = null;
              returnS2Tdata.result?.translatedText = null;
              returnS2Tdata.result?.audioS3Path = null;

              if (widget.isAutoCalling) {
                Navigator.pop(widget.paramValue['context']);
                Navigator.pop(widget.paramValue['context']);
                Singleton.instance.startCalling = false;
                if (!stopValue) {
                  widget.allocationBloc!.add(StartCallingEvent(
                    customerIndex: widget.paramValue['customerIndex'] + 1,
                    phoneIndex: 0,
                    isIncreaseCount: true,
                  ));
                } else {
                  if (widget.health == ConstantEventValues.healthTwo) {
                    widget.allocationBloc!.add(ConnectedStopAndSubmitEvent(
                      customerIndex: widget.paramValue['customerIndex'],
                    ));
                  }
                }
              } else {
                AppUtils.topSnackBar(context, Constants.successfullySubmitted);
                if (widget.isCall!) {
                  setState(() {
                    for (int i = 0; i < (otherFeedbackContact.length); i++) {
                      widget.bloc.listOfCallDetails?.add(
                          jsonDecode(jsonEncode(otherFeedbackContact[i])));
                    }
                  });
                  widget.bloc.add(AddedNewCallContactListEvent());
                } else {
                  setState(() {
                    for (int i = 0; i < (otherFeedbackContact.length); i++) {
                      widget.bloc.listOfAddressDetails?.add(
                          jsonDecode(jsonEncode(otherFeedbackContact[i])));
                    }
                    // }
                  });
                  widget.bloc.add(AddedNewAddressListEvent());
                }

                Navigator.pop(context);
              }
            }
          }
        }
      }
    }
    setState(() => isSubmit = true);
  }

  expandList(List<FeedbackTemplate> list, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
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
                  list[index].name!,
                  fontWeight: FontWeight.w700,
                  color: ColorResource.color000000,
                ),
                iconColor: ColorResource.color000000,
                collapsedIconColor: ColorResource.color000000,
                children: <Widget>[
                  if (list[index].data![0].name == 'vehicleavailable')
                    CupertinoSwitch(
                      value: isVehicleAvailable,
                      onChanged: (bool value) {
                        setState(() {
                          isVehicleAvailable = value;
                        });
                      },
                      // activeColor: CupertinoColors.activeOrange,
                      // trackColor: CupertinoColors.systemBlue,
                    ),
                  if (list[index].data![0].name == 'collectorfeedback')
                    CustomDropDownButton(
                      list[index].data![0].label!,
                      collectorFeedBackValueDropdownList,
                      hintWidget: const Text('Select'),
                      selectedValue: collectorFeedBackValue,
                      underline: Container(
                        height: 1,
                        width: double.infinity,
                        color: ColorResource.colorffffff,
                      ),
                      onChanged: (String? newValue) => setState(
                          () => collectorFeedBackValue = newValue.toString()),
                      icon: SvgPicture.asset(ImageResource.downShape),
                      valueTextStyle: const TextStyle(height: 1),
                    ),
                  if (list[index].data![0].name == 'actionproposed')
                    CustomDropDownButton(
                      list[index].data![0].label!,
                      actionproposedDropdownValue,
                      hintWidget: const Text('Select'),
                      selectedValue: actionproposedValue,
                      underline: Container(
                        height: 1,
                        width: double.infinity,
                        color: ColorResource.colorffffff,
                      ),
                      onChanged: (String? newValue) => setState(
                          () => actionproposedValue = newValue.toString()),
                      icon: SvgPicture.asset(ImageResource.downShape),
                    ),
                  if (list[index].data![0].name == 'addNewContact')
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            itemCount: listOfContact.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 25),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Flexible(
                                        child: CustomDropDownButton(
                                      Languages.of(context)!
                                          .customerContactType,
                                      const <String>[
                                        '',
                                        'Residence Address',
                                        'Mobile',
                                        'Office Address',
                                        'Office Contact No.',
                                        'Email Id',
                                        'Residence Contact No.'
                                      ],
                                      underlineColor: ColorResource.color000000,
                                      selectedValue:
                                          listOfContact[index].formValue,
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          listOfContact[index].formValue =
                                              newValue.toString();
                                        });
                                        otherFeedbackContact.clear();
                                        for (int i = 0;
                                            i < (listOfContact.length - 1);
                                            i++) {
                                          if (listOfContact[i]
                                              .controller
                                              .text
                                              .isNotEmpty) {
                                            otherFeedbackContact
                                                .add(OtherFeedBackContact(
                                              cType: listOfContact[i]
                                                      .controller
                                                      .text
                                                      .isNotEmpty
                                                  ? listOfContact[i]
                                                      .formValue
                                                      .toLowerCase()
                                                  : '',
                                              value: listOfContact[i]
                                                  .controller
                                                  .text,
                                              contactId0: '',
                                              resAddressId0: '',
                                            ));
                                          }
                                        }
                                        setState(() {});
                                      },
                                      icon: SvgPicture.asset(
                                          ImageResource.downShape),
                                    )),
                                    GestureDetector(
                                      onTap: () {
                                        if (listOfContact[index].formValue ==
                                            '') {
                                          AppUtils.showToast(
                                            Languages.of(context)!
                                                .pleaseSelectCustomerContactType,
                                          );
                                        }
                                      },
                                      child: IOSKeyboardActionWidget(
                                        focusNode:
                                            listOfContact[index].focusNode,
                                        child: CustomReadOnlyTextField(
                                          (listOfContact[index].formValue == '')
                                              ? Languages.of(context)!.contact
                                              : (listOfContact[index]
                                                              .formValue ==
                                                          'Mobile' ||
                                                      listOfContact[index]
                                                              .formValue ==
                                                          'Office Contact No.' ||
                                                      listOfContact[index]
                                                              .formValue ==
                                                          'Residence Contact No.')
                                                  ? Languages.of(context)!
                                                      .contact
                                                  : (listOfContact[index]
                                                              .formValue ==
                                                          'Email Id')
                                                      ? Languages.of(context)!
                                                          .email
                                                      : 'Address',
                                          listOfContact[index].controller,
                                          isLabel: true,
                                          focusNode:
                                              listOfContact[index].focusNode,
                                          isEnable:
                                              (listOfContact[index].formValue !=
                                                  ''),
                                          borderColor:
                                              ColorResource.color000000,
                                          keyBoardType: (listOfContact[index]
                                                          .formValue ==
                                                      'Mobile' ||
                                                  listOfContact[index]
                                                          .formValue ==
                                                      'Office Contact No.' ||
                                                  listOfContact[index]
                                                          .formValue ==
                                                      'Residence Contact No.')
                                              ? TextInputType.number
                                              : (listOfContact[index]
                                                          .formValue ==
                                                      'Email Id')
                                                  ? TextInputType.emailAddress
                                                  : TextInputType.name,
                                          inputformaters: (listOfContact[index]
                                                          .formValue ==
                                                      'Mobile' ||
                                                  listOfContact[index]
                                                          .formValue ==
                                                      'Office Contact No.' ||
                                                  listOfContact[index]
                                                          .formValue ==
                                                      'Residence Contact No.')
                                              ? <TextInputFormatter>[
                                                  LengthLimitingTextInputFormatter(
                                                      10),
                                                  FilteringTextInputFormatter
                                                      .digitsOnly,
                                                  FilteringTextInputFormatter
                                                      .deny(
                                                          Constants.rEGEXEMOJI),
                                                  if (listOfContact[index]
                                                      .controller
                                                      .text
                                                      .isEmpty)
                                                    FilteringTextInputFormatter
                                                        .deny(' '),
                                                ]
                                              : <TextInputFormatter>[
                                                  FilteringTextInputFormatter
                                                      .deny(
                                                          Constants.rEGEXEMOJI),
                                                  // if (listOfContact[index]
                                                  //     .controller
                                                  //     .text
                                                  //     .isEmpty)
                                                  //   FilteringTextInputFormatter
                                                  //       .deny(' ')
                                                ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                        const SizedBox(height: 20),
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              if ((listOfContact.last.formValue == '' ||
                                  listOfContact.last.controller.text.isEmpty)) {
                                AppUtils.showErrorToast(
                                    'Please fill the contact');
                              } else {
                                setState(() {
                                  listOfContact.add(AddNewContactFieldModel(
                                    TextEditingController(),
                                    '',
                                    FocusNode(),
                                  ));
                                });
                              }
                            },
                            child: Container(
                              height: 45,
                              decoration: BoxDecoration(
                                  color: ColorResource.colorFFFFFF,
                                  border: Border.all(
                                      color: ColorResource.color23375A,
                                      width: 0.5),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(50.0))),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 11),
                                child: CustomText(
                                  Languages.of(context)!.addMoreContact,
                                  fontWeight: FontWeight.w700,
                                  fontSize: FontSize.thirteen,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(
                    height: 13,
                  )
                ],
                onExpansionChanged: (bool status) {
                  setState(() {
                    if (list[index].data![0].name == 'actionproposed' &&
                        status &&
                        actionproposedDropdownValue.isEmpty) {
                      Singleton.instance.feedbackTemplate!.result!
                          .feedbackTemplate![index].data![0].options
                          ?.forEach((element) {
                        actionproposedDropdownValue
                            .add(element.viewValue.toString());
                      });
                    } else if (list[index].data![0].name ==
                            'collectorfeedback' &&
                        status &&
                        collectorFeedBackValueDropdownList.isEmpty) {
                      Singleton.instance.feedbackTemplate!.result!
                          .feedbackTemplate![index].data![0].options
                          ?.forEach((element) {
                        collectorFeedBackValueDropdownList
                            .add(element.viewValue.toString());
                      });
                    }

                    list[index].expanded = !list[index].expanded!;
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
