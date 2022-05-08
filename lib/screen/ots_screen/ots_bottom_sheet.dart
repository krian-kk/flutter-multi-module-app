import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:origa/http/api_repository.dart';
import 'package:origa/http/httpurls.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/models/ots_post_model/contact.dart';
import 'package:origa/models/ots_post_model/event_attr.dart';
import 'package:origa/models/ots_post_model/ots_post_model.dart';
import 'package:origa/models/payment_mode_button_model.dart';
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
import 'package:origa/widgets/custom_loading_widget.dart';
import 'package:origa/widgets/custom_read_only_text_field.dart';
import 'package:origa/widgets/custom_text.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../models/speech2text_model.dart';
import '../../utils/language_to_constant_convert.dart';

class CustomOtsBottomSheet extends StatefulWidget {
  const CustomOtsBottomSheet(
    this.cardTitle, {
    Key? key,
    required this.customerLoanUserWidget,
    required this.bloc,
    this.isCall,
    required this.caseId,
    required this.userType,
    required this.postValue,
    this.isAutoCalling = false,
    this.allocationBloc,
    this.paramValue,
    this.isCallFromCaseDetails = false,
    this.callId,
  }) : super(key: key);
  final String cardTitle;
  final Widget customerLoanUserWidget;
  final bool? isCall;
  final String caseId;
  final String userType;
  final dynamic postValue;
  final bool isAutoCalling;
  final AllocationBloc? allocationBloc;
  final dynamic paramValue;
  final CaseDetailsBloc bloc;
  final bool isCallFromCaseDetails;
  final String? callId;

  @override
  State<CustomOtsBottomSheet> createState() => _CustomOtsBottomSheetState();
}

class _CustomOtsBottomSheetState extends State<CustomOtsBottomSheet> {
  late TextEditingController otsProposedAmountControlller;
  late TextEditingController otsPaymentDateControlller;
  late TextEditingController remarksControlller;
  String selectedPaymentModeButton = '';

  late FocusNode otsProposedAmountFocusNode;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isSubmit = true;
  List<File> uploadFileLists = <File>[];

  String? isRecord;
  String translateText = '';
  bool isTranslate = true;

  //Returned speech to text AAPI data
  Speech2TextModel returnS2Tdata = Speech2TextModel();

  @override
  void initState() {
    otsProposedAmountControlller = TextEditingController();
    otsPaymentDateControlller = TextEditingController();
    remarksControlller = TextEditingController();
    otsProposedAmountFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    otsProposedAmountControlller.dispose();
    otsPaymentDateControlller.dispose();
    remarksControlller.dispose();
    otsProposedAmountFocusNode.dispose();
    super.dispose();
  }

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
      }
    } else {
      AppUtils.showToast(
        Languages.of(context)!.canceled,
        gravity: ToastGravity.CENTER,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<PaymentModeButtonModel> paymentModeButtonList =
        <PaymentModeButtonModel>[
      PaymentModeButtonModel(Languages.of(context)!.cheque),
      PaymentModeButtonModel(Languages.of(context)!.cash),
      PaymentModeButtonModel(Languages.of(context)!.digital),
    ];
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
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SizedBox(
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
                        padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15)
                            .copyWith(bottom: 5),
                      ),
                      Expanded(
                        child: KeyboardActions(
                          enable: (Platform.isIOS),
                          config: KeyboardActionsConfig(
                            keyboardActionsPlatform:
                                KeyboardActionsPlatform.IOS,
                            actions: <KeyboardActionsItem>[
                              KeyboardActionsItem(
                                focusNode: otsProposedAmountFocusNode,
                                displayArrows: false,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 18.0),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  widget.customerLoanUserWidget,
                                  // const SizedBox(height: 11),
                                  const SizedBox(height: 25),
                                  Flexible(
                                      child: CustomReadOnlyTextField(
                                    Languages.of(context)!.otsProposedAmount,
                                    otsProposedAmountControlller,
                                    validationRules: const <String>['required'],
                                    isLabel: true,
                                    focusNode: otsProposedAmountFocusNode,
                                    keyBoardType: TextInputType.number,
                                    isNumberOnly: true,
                                  )),
                                  const SizedBox(height: 17),
                                  Row(
                                    children: <Widget>[
                                      Flexible(
                                          child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          // CustomText(
                                          //   Languages.of(context)!
                                          //       .otsPaymentDate,
                                          //   fontSize: FontSize.twelve,
                                          //   fontWeight: FontWeight.w400,
                                          //   color: ColorResource.color666666,
                                          //   fontStyle: FontStyle.normal,
                                          // ),
                                          SizedBox(
                                            width: (MediaQuery.of(context)
                                                    .size
                                                    .width) /
                                                2,
                                            child: CustomReadOnlyTextField(
                                              Languages.of(context)!
                                                  .otsPaymentDate,
                                              otsPaymentDateControlller,
                                              validationRules: const <String>[
                                                'required'
                                              ],
                                              isReadOnly: true,
                                              isLabel: true,
                                              onTapped: () =>
                                                  PickDateAndTimeUtils.pickDate(
                                                      context, (String? newDate,
                                                          String?
                                                              followUpDate) {
                                                if (newDate != null &&
                                                    followUpDate != null) {
                                                  setState(() {
                                                    otsPaymentDateControlller
                                                        .text = newDate;
                                                  });
                                                  widget.bloc.add(
                                                      ChangeFollowUpDateEvent(
                                                          followUpDate:
                                                              followUpDate));
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
                                    ],
                                  ),
                                  const SizedBox(height: 15),
                                  Flexible(
                                      child: CustomReadOnlyTextField(
                                    Languages.of(context)!.remarks,
                                    remarksControlller,
                                    validationRules: const <String>['required'],
                                    isLabel: true,
                                    isVoiceRecordWidget: true,
                                    checkRecord: (String? isRecord,
                                        String? text,
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

                                    // suffixWidget: VoiceRecodingWidget(),
                                  )),
                                  const SizedBox(height: 15),
                                  CustomText(
                                    Languages.of(context)!.paymentMode,
                                    fontWeight: FontWeight.w700,
                                    color: ColorResource.color101010,
                                  ),
                                  const SizedBox(height: 8),
                                  Wrap(
                                    runSpacing: 8,
                                    spacing: 10,
                                    children: _buildPaymentButton(
                                        paymentModeButtonList),
                                  ),
                                  const SizedBox(height: 25),
                                  SizedBox(
                                    width: double.infinity,
                                    child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50),
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
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: <Widget>[
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    SvgPicture.asset(
                                                        ImageResource.upload),
                                                    const SizedBox(width: 5),
                                                    CustomText(
                                                      Languages.of(context)!
                                                          .uploadFile,
                                                      color: ColorResource
                                                          .colorFFFFFF,
                                                      fontSize:
                                                          FontSize.sixteen,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      lineHeight: 1,
                                                    )
                                                  ],
                                                ),
                                                CustomText(
                                                  Languages.of(context)!
                                                      .upto5mb,
                                                  lineHeight: 1,
                                                  color:
                                                      ColorResource.colorFFFFFF,
                                                  fontSize: FontSize.twelve,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                                const SizedBox(height: 5),
                                              ],
                                            ),
                                          ),
                                        )),
                                  ),
                                ],
                              ),
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 5.0),
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
                                      ColorResource.colorFFFFFF
                                          .withOpacity(0.7),
                                    ],
                                  ),
                                  fontSize: FontSize.sixteen,
                                  onTap: isSubmit
                                      ? () => submitOTSEvent(true)
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
                            onTap:
                                isSubmit ? () => submitOTSEvent(false) : () {},
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
        },
      ),
    );
  }

  submitOTSEvent(bool stopValue) async {
    if (isRecord == Constants.process) {
      AppUtils.showToast('Stop the Record then Submit');
    } else if (isRecord == Constants.stop) {
      AppUtils.showToast('Please wait audio is converting');
    } else {
      if (isRecord == Constants.submit) {
        setState(() => remarksControlller.text = translateText);
        setState(() => isTranslate = false);
      }
      if (_formKey.currentState!.validate()) {
        if (selectedPaymentModeButton == '') {
          AppUtils.showToast(Languages.of(context)!.pleaseSelectOptions);
        } else {
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
            if (Geolocator.checkPermission().toString() !=
                PermissionStatus.granted.toString()) {
              final Position res = await Geolocator.getCurrentPosition();
              setState(() {
                position = res;
              });
            }
            final OtsPostModel requestBodyData = OtsPostModel(
              eventId: ConstantEventValues.otsEventId,
              eventType:
                  (widget.userType == Constants.telecaller || widget.isCall!)
                      ? 'TC : OTS'
                      : 'OTS',
              caseId: widget.caseId,
              imageLocation: <String>[],
              eventAttr: OTSEventAttr(
                date: otsPaymentDateControlller.text,
                remarkOts: remarksControlller.text,
                amntOts: otsProposedAmountControlller.text,
                appStatus: 'OTS',
                mode: ConvertString.convertLanguageToConstant(
                    selectedPaymentModeButton, context),
                altitude: position.altitude,
                accuracy: position.accuracy,
                heading: position.heading,
                speed: position.speed,
                latitude: position.latitude,
                longitude: position.longitude,
                reginalText: returnS2Tdata.result?.reginalText,
                translatedText: returnS2Tdata.result?.translatedText,
                audioS3Path: returnS2Tdata.result?.audioS3Path,
              ),
              eventCode: ConstantEventValues.otsEvenCode,
              createdBy: Singleton.instance.agentRef ?? '',
              agentName: Singleton.instance.agentName ?? '',
              eventModule: widget.isCall! ? 'Telecalling' : 'Field Allocation',
              contact: OTSContact(
                cType: widget.postValue['cType'],
                health: ConstantEventValues.otsHealth,
                value: widget.postValue['value'],
              ),
              callId: Singleton.instance.callID,
              callingId: Singleton.instance.callingID,
              callerServiceId: Singleton.instance.callerServiceID,
              voiceCallEventCode: ConstantEventValues.voiceCallEventCode,
              agrRef: Singleton.instance.agrRef ?? '',
              contractor: Singleton.instance.contractor ?? '',
            );

            // requestBodyData
            //     .toJson()
            //     .remove((key, value) => value == requestBodyData.createdAt);
            //  remove(requestBodyData.createdAt);

            // debugPrint(
            //     "new res data ------------------> ${jsonEncode(requestBodyData.toJson())}");

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
                      selectedFollowUpDate: otsPaymentDateControlller.text,
                      selectedClipValue: Constants.ots,
                      bloc: widget.bloc)
                  .whenComplete(() {
                AppUtils.topSnackBar(context, Constants.successfullySubmitted);
              });
            } else {
              final Map<String, dynamic> postResult =
                  await APIRepository.apiRequest(
                APIRequestType.upload,
                HttpUrl.otsPostUrl,
                formDatas: FormData.fromMap(postdata),
              );
              if (postResult[Constants.success]) {
                widget.bloc.add(
                  ChangeIsSubmitForMyVisitEvent(
                    Constants.ots,
                  ),
                );
                if (!(widget.userType == Constants.fieldagent &&
                    widget.isCall!)) {
                  widget.bloc.add(
                      ChangeIsSubmitEvent(selectedClipValue: Constants.ots));
                }

                widget.bloc.add(
                  ChangeHealthStatusEvent(),
                );

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
                    widget.allocationBloc!.add(ConnectedStopAndSubmitEvent(
                      customerIndex: widget.paramValue['customerIndex'],
                    ));
                  }
                } else {
                  AppUtils.topSnackBar(
                      context, Constants.successfullySubmitted);
                  Navigator.pop(context);
                }
              }
            }
          }
        }
      }
    }

    setState(() => isSubmit = true);
  }

  List<Widget> _buildPaymentButton(List<PaymentModeButtonModel> list) {
    final List<Widget> widgets = <Widget>[];
    for (PaymentModeButtonModel element in list) {
      widgets.add(InkWell(
        onTap: () {
          setState(() {
            selectedPaymentModeButton = element.title;
          });
        },
        child: Container(
          width: 156,
          height: 50,
          decoration: BoxDecoration(
              color: element.title == selectedPaymentModeButton
                  ? ColorResource.color23375A
                  : ColorResource.colorBEC4CF,
              boxShadow: <BoxShadow>[
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
              children: <Widget>[
                CircleAvatar(
                  radius: 19,
                  backgroundColor: ColorResource.colorFFFFFF,
                  child: Center(
                    child: SvgPicture.asset(ImageResource.money),
                  ),
                ),
                const SizedBox(width: 5),
                Flexible(
                  child: CustomText(
                    element.title,
                    color: ColorResource.colorFFFFFF,
                    fontWeight: FontWeight.w700,
                    lineHeight: 1,
                    fontSize: FontSize.sixteen,
                  ),
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
