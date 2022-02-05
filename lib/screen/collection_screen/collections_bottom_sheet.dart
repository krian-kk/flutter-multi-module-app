import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:origa/http/api_repository.dart';
import 'package:origa/http/httpurls.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/models/collection_post_model/collection_post_model.dart';
import 'package:origa/models/payment_mode_button_model.dart';
import 'package:origa/screen/allocation/bloc/allocation_bloc.dart';
import 'package:origa/models/receipt_sendsms_model.dart';
import 'package:origa/singleton.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/constant_event_values.dart';
import 'package:origa/utils/constants.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/utils/string_resource.dart';
import 'package:origa/widgets/bottomsheet_appbar.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_dialog.dart';
import 'package:origa/widgets/custom_loading_widget.dart';
import 'package:origa/widgets/custom_read_only_text_field.dart';
import 'package:origa/widgets/custom_text.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

class CustomCollectionsBottomSheet extends StatefulWidget {
  const CustomCollectionsBottomSheet(
    this.cardTitle, {
    Key? key,
    required this.caseId,
    required this.customerLoanUserWidget,
    required this.userType,
    this.postValue,
    this.isCall,
    this.custName,
    this.isAutoCalling = false,
    this.allocationBloc,
    this.paramValue,
  }) : super(key: key);
  final String cardTitle;
  final String caseId;
  final Widget customerLoanUserWidget;
  final String userType;
  final dynamic postValue;
  final String? custName;
  final bool? isCall;
  final bool isAutoCalling;
  final AllocationBloc? allocationBloc;
  final dynamic paramValue;

  @override
  State<CustomCollectionsBottomSheet> createState() =>
      _CustomCollectionsBottomSheetState();
}

class _CustomCollectionsBottomSheetState
    extends State<CustomCollectionsBottomSheet> {
  TextEditingController amountCollectedControlller = TextEditingController();
  TextEditingController dateControlller = TextEditingController();
  String selectedDate = '';
  TextEditingController chequeControlller = TextEditingController();
  TextEditingController remarksControlller = TextEditingController();
  String selectedPaymentModeButton = '';

  final _formKey = GlobalKey<FormState>();
  List<File> uploadFileLists = [];

  bool isSubmit = true;

  FocusNode amountCollectedFocusNode = FocusNode();
  FocusNode chequeFocusNode = FocusNode();
  FocusNode remarksFocusNode = FocusNode();

  getFiles() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(allowMultiple: true, type: FileType.image);
    if (result != null) {
      uploadFileLists = result.paths.map((path) => File(path!)).toList();
    } else {
      AppUtils.showToast(StringResource.canceled, gravity: ToastGravity.CENTER);
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      selectedDate = DateTime.now().toString();

      dateControlller.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    });
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
                child: KeyboardActions(
                  config: KeyboardActionsConfig(
                    keyboardActionsPlatform: KeyboardActionsPlatform.IOS,
                    actions: [
                      KeyboardActionsItem(
                        focusNode: amountCollectedFocusNode,
                        displayArrows: false,
                      ),
                    ],
                  ),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
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
                                      contentPadding: const EdgeInsets.fromLTRB(
                                          1, 23, 5, 10),
                                      validatorCallBack: () {},
                                      keyBoardType: TextInputType.number,
                                      focusNode: amountCollectedFocusNode,
                                      validationRules: const ['required'],
                                      suffixWidget: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
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
                                              ImageResource
                                                  .dropDownIncreaseArrow,
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
                                              ImageResource
                                                  .dropDownDecreaseArrow,
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
                            children:
                                _buildPaymentButton(paymentModeButtonList),
                          ),
                          const SizedBox(height: 15),
                          Flexible(
                              child: CustomReadOnlyTextField(
                            Languages.of(context)!.refCheque,
                            chequeControlller,
                            focusNode: chequeFocusNode,
                            // validationRules: const ['required'],
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
                            onTap: () => getFiles(),
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
                  onTap: () {
                    AppUtils.showToast('Unable to send SMS');
                    Navigator.pop(context);
                  },
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
                    trailingWidget: CustomLoadingWidget(
                      gradientColors: [
                        ColorResource.colorFFFFFF,
                        ColorResource.colorFFFFFF.withOpacity(0.7),
                      ],
                    ),
                    fontSize: FontSize.sixteen,
                    fontWeight: FontWeight.w700,
                    onTap: isSubmit
                        ? () async {
                            if (_formKey.currentState!.validate()) {
                              if (selectedPaymentModeButton == '') {
                                AppUtils.showToast(
                                    Constants.pleaseSelectOptions);
                              } else {
                                if (selectedPaymentModeButton == "DIGITAL") {
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
                                  var requestBodyData = CollectionPostModel(
                                      eventId:
                                          ConstantEventValues.collectionEventId,
                                      eventCode: ConstantEventValues
                                          .collectionEvenCode,
                                      eventType: (widget.userType ==
                                                  Constants.telecaller ||
                                              widget.isCall!)
                                          ? 'TC : RECEIPT'
                                          : 'RECEIPT',
                                      caseId: widget.caseId,
                                      contact: CollectionsContact(
                                        cType: widget.postValue['cType'],
                                        value: widget.postValue['value'],
                                        health: ConstantEventValues
                                            .collectionHealth,
                                        resAddressId0:
                                            Singleton.instance.resAddressId_0 ??
                                                '',
                                        contactId0:
                                            Singleton.instance.contactId_0 ??
                                                '',
                                      ),
                                      eventAttr: EventAttr(
                                        amountCollected:
                                            amountCollectedControlller.text,
                                        chequeRefNo: chequeControlller.text,
                                        date: selectedDate,
                                        remarks: remarksControlller.text,
                                        mode: selectedPaymentModeButton,
                                        customerName: widget.custName!,
                                        followUpPriority: 'REVIEW',
                                        imageLocation: [''],
                                        longitude: position.longitude,
                                        latitude: position.latitude,
                                        accuracy: position.accuracy,
                                        altitude: position.altitude,
                                        heading: position.heading,
                                        speed: position.speed,
                                        deposition: CollectionsDeposition(
                                            status: "pending"),
                                      ),
                                      callID: Singleton.instance.callID ?? '0',
                                      callingID:
                                          Singleton.instance.callingID ?? '0',
                                      callerServiceID:
                                          Singleton.instance.callerServiceID ??
                                              '',
                                      voiceCallEventCode: ConstantEventValues
                                          .voiceCallEventCode,
                                      createdBy:
                                          Singleton.instance.agentRef ?? '',
                                      agentName:
                                          Singleton.instance.agentName ?? '',
                                      agrRef: Singleton.instance.agrRef ?? '',
                                      contractor:
                                          Singleton.instance.contractor ?? '',
                                      eventModule: widget.isCall!
                                          ? 'Telecalling'
                                          : 'Field Allocation',
                                      invalidNumber: false);

                                  // print(jsonEncode(requestBodyData.toJson()));

                                  final Map<String, dynamic> postdata =
                                      jsonDecode(jsonEncode(
                                              requestBodyData.toJson()))
                                          as Map<String, dynamic>;
                                  List<dynamic> value = [];
                                  for (var element in uploadFileLists) {
                                    value.add(await MultipartFile.fromFile(
                                        element.path.toString()));
                                  }
                                  postdata.addAll({
                                    'files': value,
                                  });

                                  Map<String, dynamic> postResult =
                                      await APIRepository.apiRequest(
                                    APIRequestType.UPLOAD,
                                    HttpUrl.collectionPostUrl(
                                        'collection', widget.userType),
                                    formDatas: FormData.fromMap(postdata),
                                  );

                                  if (postResult[Constants.success]) {
                                    AppUtils.topSnackBar(context,
                                        Constants.successfullySubmitted);
                                    Navigator.pop(context);
                                  }
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
                                  var requestBodyData = CollectionPostModel(
                                      eventId:
                                          ConstantEventValues.collectionEventId,
                                      eventCode: ConstantEventValues
                                          .collectionEvenCode,
                                      eventType: (widget.userType ==
                                                  Constants.telecaller ||
                                              widget.isCall!)
                                          ? 'TC : RECEIPT'
                                          : 'RECEIPT',
                                      caseId: widget.caseId,
                                      contact: CollectionsContact(
                                        cType: widget.postValue['cType'],
                                        value: widget.postValue['value'],
                                        health: ConstantEventValues
                                            .collectionHealth,
                                        resAddressId0:
                                            Singleton.instance.resAddressId_0 ??
                                                '',
                                        contactId0:
                                            Singleton.instance.contactId_0 ??
                                                '',
                                      ),
                                      eventAttr: EventAttr(
                                        amountCollected:
                                            amountCollectedControlller.text,
                                        chequeRefNo: chequeControlller.text,
                                        date: selectedDate,
                                        remarks: remarksControlller.text,
                                        mode: selectedPaymentModeButton,
                                        customerName: widget.custName!,
                                        followUpPriority: 'REVIEW',
                                        imageLocation: [''],
                                        longitude: position.longitude,
                                        latitude: position.latitude,
                                        accuracy: position.accuracy,
                                        altitude: position.altitude,
                                        heading: position.heading,
                                        speed: position.speed,
                                        deposition: CollectionsDeposition(
                                            status: "pending"),
                                      ),
                                      callID: Singleton.instance.callID ?? '0',
                                      callingID:
                                          Singleton.instance.callingID ?? '0',
                                      callerServiceID:
                                          Singleton.instance.callerServiceID ??
                                              '',
                                      voiceCallEventCode: ConstantEventValues
                                          .voiceCallEventCode,
                                      createdBy:
                                          Singleton.instance.agentRef ?? '',
                                      agentName:
                                          Singleton.instance.agentName ?? '',
                                      agrRef: Singleton.instance.agrRef ?? '',
                                      contractor:
                                          Singleton.instance.contractor ?? '',
                                      eventModule: widget.isCall!
                                          ? 'Telecalling'
                                          : 'Field Allocation',
                                      invalidNumber: false);

                                  // print(jsonEncode(requestBodyData.toJson()));

                                  final Map<String, dynamic> postdata =
                                      jsonDecode(jsonEncode(
                                              requestBodyData.toJson()))
                                          as Map<String, dynamic>;
                                  List<dynamic> value = [];
                                  for (var element in uploadFileLists) {
                                    value.add(await MultipartFile.fromFile(
                                        element.path.toString()));
                                  }
                                  postdata.addAll({
                                    'files': value,
                                  });
                                  setState(() => isSubmit = true);
                                  DialogUtils.showDialog(
                                    buildContext: context,
                                    title: Constants.reciptsAlertMesg,
                                    description: '',
                                    okBtnText: Languages.of(context)!
                                        .submit
                                        .toUpperCase(),
                                    cancelBtnText: Languages.of(context)!
                                        .cancel
                                        .toUpperCase(),
                                    okBtnFunction: (val) async {
                                      // pop or remove the AlertDialouge Box
                                      Navigator.pop(context);

                                      setState(() => isSubmit = false);

                                      Map<String, dynamic> postResult =
                                          await APIRepository.apiRequest(
                                        APIRequestType.UPLOAD,
                                        HttpUrl.collectionPostUrl(
                                            'collection', widget.userType),
                                        formDatas: FormData.fromMap(postdata),
                                      );

                                      if (postResult[Constants.success]) {
                                        if (widget.isAutoCalling) {
                                          Navigator.pop(
                                              widget.paramValue['context']);
                                          Navigator.pop(
                                              widget.paramValue['context']);
                                          widget.allocationBloc!
                                              .add(StartCallingEvent(
                                            customerIndex: widget.paramValue[
                                                    'customerIndex'] +
                                                1,
                                            phoneIndex: 0,
                                            isIncreaseCount: true,
                                          ));
                                        } else {
                                          AppUtils.topSnackBar(context,
                                              "Event updated successfully.");
                                          Navigator.pop(context);
                                        }

                                        if (Singleton
                                                .instance
                                                .contractorInformations!
                                                .result!
                                                .sendSms! &&
                                            Singleton.instance.usertype ==
                                                Constants.fieldagent) {
                                          var requestBodyData = ReceiptSendSMS(
                                            agrRef: Singleton.instance.agrRef,
                                            agentRef:
                                                Singleton.instance.agentRef,
                                            borrowerMobile: Singleton.instance
                                                    .customerContactNo ??
                                                "0",
                                            type: Constants
                                                .receiptAcknowledgementType,
                                            receiptAmount: int.parse(
                                                amountCollectedControlller
                                                    .text),
                                            receiptDate: selectedDate,
                                            paymentMode:
                                                selectedPaymentModeButton,
                                            messageBody: 'message',
                                          );
                                          Map<String, dynamic> postResult =
                                              await APIRepository.apiRequest(
                                            APIRequestType.POST,
                                            HttpUrl.sendSMSurl,
                                            requestBodydata:
                                                jsonEncode(requestBodyData),
                                          );
                                          if (postResult[Constants.success]) {
                                            AppUtils.showToast(
                                                Constants.successfullySMSsend);
                                          }
                                        } else {
                                          AppUtils.showErrorToast(
                                              "SMS is not activated");
                                        }
                                      }
                                    },
                                  );
                                }
                              }
                              // }
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
      selectedDate = newDate.toString();
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
