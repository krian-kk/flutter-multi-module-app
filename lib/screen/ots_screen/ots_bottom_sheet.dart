import 'dart:convert';
import 'dart:io';

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
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/widgets/bottomsheet_appbar.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_loading_widget.dart';
import 'package:origa/widgets/custom_read_only_text_field.dart';
import 'package:origa/widgets/custom_text.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

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

  final _formKey = GlobalKey<FormState>();

  bool isSubmit = true;
  List<File> uploadFileLists = [];

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
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(allowMultiple: true, type: FileType.image);
    if (result != null) {
      if ((result.files.first.size) / 1048576.ceil() > 5) {
        AppUtils.showToast('Please Select Maximum 5 MB File.',
            gravity: ToastGravity.CENTER);
      } else {
        uploadFileLists = result.paths.map((path) => File(path!)).toList();
      }
    } else {
      AppUtils.showToast('Canceled', gravity: ToastGravity.CENTER);
    }
  }

  @override
  Widget build(BuildContext context) {
    List<PaymentModeButtonModel> paymentModeButtonList = [
      PaymentModeButtonModel(Languages.of(context)!.cheque),
      PaymentModeButtonModel(Languages.of(context)!.cash),
      PaymentModeButtonModel(Languages.of(context)!.digital),
    ];
    return BlocListener<CaseDetailsBloc, CaseDetailsState>(
      bloc: widget.bloc,
      listener: (context, state) {
        if (state is UpdateHealthStatusState) {
          UpdateHealthStatusModel data = UpdateHealthStatusModel.fromJson(
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
        builder: (context, state) {
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
                    children: [
                      BottomSheetAppbar(
                        title: widget.cardTitle,
                        padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15)
                            .copyWith(bottom: 5),
                      ),
                      Expanded(
                        child: KeyboardActions(
                          config: KeyboardActionsConfig(
                            keyboardActionsPlatform:
                                KeyboardActionsPlatform.IOS,
                            actions: [
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
                                    validationRules: const ['required'],
                                    isLabel: true,
                                    focusNode: otsProposedAmountFocusNode,
                                    keyBoardType: TextInputType.number,
                                  )),
                                  const SizedBox(height: 17),
                                  Row(
                                    children: [
                                      Flexible(
                                          child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          CustomText(
                                            Languages.of(context)!
                                                .otsPaymentDate,
                                            fontSize: FontSize.twelve,
                                            fontWeight: FontWeight.w400,
                                            color: ColorResource.color666666,
                                            fontStyle: FontStyle.normal,
                                          ),
                                          SizedBox(
                                            width: (MediaQuery.of(context)
                                                    .size
                                                    .width) /
                                                2,
                                            child: CustomReadOnlyTextField(
                                              '',
                                              otsPaymentDateControlller,
                                              validationRules: const [
                                                'required'
                                              ],
                                              isReadOnly: true,
                                              onTapped: () => pickDate(context,
                                                  otsPaymentDateControlller),
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
                                    validationRules: const ['required'],
                                    isLabel: true,
                                    // suffixWidget: VoiceRecodingWidget(),
                                  )),
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
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SvgPicture.asset(
                                                        ImageResource.upload),
                                                    const SizedBox(width: 5),
                                                    const CustomText(
                                                      'UPLOAD FILE',
                                                      color: ColorResource
                                                          .colorFFFFFF,
                                                      fontSize:
                                                          FontSize.sixteen,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    )
                                                  ],
                                                ),
                                                const CustomText(
                                                  'UPTO 5MB',
                                                  lineHeight: 1,
                                                  color:
                                                      ColorResource.colorFFFFFF,
                                                  fontSize: FontSize.twelve,
                                                  fontStyle: FontStyle.normal,
                                                  fontWeight: FontWeight.w700,
                                                )
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 5.0),
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
                        SizedBox(
                            width: Singleton.instance.startCalling ?? false
                                ? 5
                                : 25),
                        Singleton.instance.startCalling ?? false
                            ? SizedBox(
                                width: Singleton.instance.startCalling ?? false
                                    ? 125
                                    : 191,
                                child: CustomButton(
                                  isSubmit
                                      ? Languages.of(context)!
                                              .stop
                                              .toUpperCase() +
                                          ' & ' +
                                          Languages.of(context)!
                                              .submit
                                              .toUpperCase()
                                      : null,
                                  isLeading: !isSubmit,
                                  trailingWidget: CustomLoadingWidget(
                                    gradientColors: [
                                      ColorResource.colorFFFFFF,
                                      ColorResource.colorFFFFFF
                                          .withOpacity(0.7),
                                    ],
                                  ),
                                  fontSize: FontSize.sixteen,
                                  fontWeight: FontWeight.w600,
                                  onTap: isSubmit
                                      ? () => submitOTSEvent(true)
                                      : () {},
                                  cardShape: 5,
                                ),
                              )
                            : const SizedBox(),
                        SizedBox(
                          width: Singleton.instance.startCalling ?? false
                              ? 95
                              : 191,
                          child: CustomButton(
                            isSubmit
                                ? Languages.of(context)!.submit.toUpperCase()
                                : null,
                            isLeading: !isSubmit,
                            trailingWidget: CustomLoadingWidget(
                              gradientColors: [
                                ColorResource.colorFFFFFF,
                                ColorResource.colorFFFFFF.withOpacity(0.7),
                              ],
                            ),
                            fontSize: FontSize.sixteen,
                            fontWeight: FontWeight.w600,
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
    if (_formKey.currentState!.validate()) {
      if (selectedPaymentModeButton == '') {
        AppUtils.showToast(Constants.pleaseSelectOptions);
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
              .then((value) {
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
            Position res = await Geolocator.getCurrentPosition(
                desiredAccuracy: LocationAccuracy.best);
            setState(() {
              position = res;
            });
          }
          var requestBodyData = OtsPostModel(
            eventId: ConstantEventValues.otsEventId,
            eventType:
                (widget.userType == Constants.telecaller || widget.isCall!)
                    ? 'TC : OTS'
                    : 'OTS',
            caseId: widget.caseId,
            imageLocation: [''],
            eventAttr: OTSEventAttr(
              date: otsPaymentDateControlller.text,
              remarkOts: remarksControlller.text,
              amntOts: otsProposedAmountControlller.text,
              appStatus: 'OTS',
              mode: selectedPaymentModeButton,
              altitude: position.altitude,
              accuracy: position.accuracy,
              heading: position.heading,
              speed: position.speed,
              latitude: position.latitude,
              longitude: position.longitude,
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
            callId: Singleton.instance.callID ?? '0',
            callingId: Singleton.instance.callingID ?? '0',
            callerServiceId: Singleton.instance.callerServiceID ?? '',
            voiceCallEventCode: ConstantEventValues.voiceCallEventCode,
            agrRef: Singleton.instance.agrRef ?? '',
            contractor: Singleton.instance.contractor ?? '',
          );

          final Map<String, dynamic> postdata =
              jsonDecode(jsonEncode(requestBodyData.toJson()))
                  as Map<String, dynamic>;
          List<dynamic> value = [];
          for (var element in uploadFileLists) {
            value.add(await MultipartFile.fromFile(element.path.toString()));
          }
          postdata.addAll({
            'files': value,
          });

          Map<String, dynamic> postResult = await APIRepository.apiRequest(
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
            if (!(widget.userType == Constants.fieldagent && widget.isCall!)) {
              widget.bloc.add(ChangeIsSubmitEvent());
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
              }
            } else {
              AppUtils.topSnackBar(context, Constants.successfullySubmitted);
              Navigator.pop(context);
            }
          }
        }
      }
    }

    setState(() => isSubmit = true);
  }

  Future pickDate(
      BuildContext context, TextEditingController controller) async {
    final newDate = await showDatePicker(
        context: context,
        initialDatePickerMode: DatePickerMode.day,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year + 3),
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
    // const initialTime = TimeOfDay(hour: 9, minute: 0);
    final newTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
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

    final time = newTime.format(context).toString();
    setState(() {
      controller.text = time;
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
