import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/models/imagecaptured_post_model.dart';
import 'package:origa/screen/case_details_screen/bloc/case_details_bloc.dart';
import 'package:origa/singleton.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/constant_event_values.dart';
import 'package:origa/utils/constants.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/widgets/bottomsheet_appbar.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_cancel_button.dart';
import 'package:origa/widgets/custom_loading_widget.dart';
import 'package:origa/widgets/custom_read_only_text_field.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../models/speech2text_model.dart';

class CustomCaptureImageBottomSheet extends StatefulWidget {
  const CustomCaptureImageBottomSheet(
    this.cardTitle, {
    Key? key,
    required this.customerLoanUserDetailsWidget,
    required this.bloc,
  }) : super(key: key);
  final String cardTitle;
  final Widget customerLoanUserDetailsWidget;
  final CaseDetailsBloc bloc;

  @override
  State<CustomCaptureImageBottomSheet> createState() =>
      _CustomCaptureImageBottomSheetState();
}

class _CustomCaptureImageBottomSheetState
    extends State<CustomCaptureImageBottomSheet> {
  late TextEditingController remarksControlller;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<File> uploadFileLists = <File>[];

  bool isSubmit = true;

  String? isRecord;
  String translateText = '';
  bool isTranslate = true;

  //Returned speech to text AAPI data
  Speech2TextModel returnS2Tdata = Speech2TextModel();

  @override
  void initState() {
    remarksControlller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    remarksControlller.dispose();
    super.dispose();
  }

  getFiles() async {
    final FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result != null) {
      uploadFileLists =
          result.paths.map((String? path) => File(path!)).toList();
    } else {
      AppUtils.showToast(Languages.of(context)!.canceled,
          gravity: ToastGravity.CENTER);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CaseDetailsBloc, CaseDetailsState>(
      bloc: widget.bloc,
      listener: (BuildContext context, CaseDetailsState state) {
        if (state is EnableCaptureImageBtnState) {
          setState(() => isSubmit = true);
        }
        if (state is DisableCaptureImageBtnState) {
          setState(() => isSubmit = false);
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
                              widget.customerLoanUserDetailsWidget,
                              const SizedBox(height: 11),
                              CustomButton(
                                Languages.of(context)!.customUpload,
                                fontWeight: FontWeight.w700,
                                trailingWidget:
                                    SvgPicture.asset(ImageResource.upload),
                                fontSize: FontSize.sixteen,
                                buttonBackgroundColor:
                                    ColorResource.color23375A,
                                borderColor: ColorResource.colorDADADA,
                                cardShape: 50,
                                cardElevation: 1,
                                isLeading: true,
                                onTap: () async {
                                  getFiles();
                                },
                              ),
                              const SizedBox(height: 15),
                              // Flexible(
                              //     child: CustomReadOnlyTextField(
                              //   Languages.of(context)!.remarks,
                              //   remarksControlller,
                              //   validationRules: const ['required'],
                              //   isLabel: true,
                              // )),
                              Flexible(
                                  child: Stack(
                                children: <Widget>[
                                  CustomReadOnlyTextField(
                                    Languages.of(context)!.remarks,
                                    remarksControlller,
                                    validationRules: const <String>['required'],
                                    isLabel: true,
                                    isVoiceRecordWidget: true,
                                    returnS2Tresponse: (dynamic val) {
                                      if (val is Speech2TextModel) {
                                        setState(() {
                                          returnS2Tdata = val;
                                        });
                                      }
                                    },
                                    checkRecord: (String? isRecord,
                                        String? text,
                                        Speech2TextModel returnS2Tdata) {
                                      setState(() {
                                        this.isRecord = isRecord;
                                        this.returnS2Tdata = returnS2Tdata;
                                        translateText = text!;
                                        isTranslate = true;
                                      });
                                    },
                                    isSubmit: isTranslate,
                                  ),
                                ],
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5.0),
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
                                    if (_formKey.currentState!.validate()) {
                                      if (uploadFileLists.isNotEmpty) {
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
                                        if (Geolocator.checkPermission()
                                                .toString() !=
                                            PermissionStatus.granted
                                                .toString()) {
                                          final Position res = await Geolocator
                                              .getCurrentPosition();
                                          setState(() {
                                            position = res;
                                          });
                                        }
                                        final PostImageCapturedModel
                                            requestBodyData =
                                            PostImageCapturedModel(
                                          eventId: ConstantEventValues
                                              .captureImageEventId,
                                          eventCode: ConstantEventValues
                                              .captureImageEvenCode,
                                          caseId: widget.bloc.caseId.toString(),
                                          contractor:
                                              Singleton.instance.contractor ??
                                                  '',
                                          voiceCallEventCode:
                                              ConstantEventValues
                                                  .voiceCallEventCode,
                                          // createdAt: (ConnectivityResult.none ==
                                          //         await Connectivity()
                                          //             .checkConnectivity())
                                          //     ? DateTime.now().toString()
                                          //     : null,
                                          createdBy:
                                              Singleton.instance.agentRef ?? '',
                                          agentName:
                                              Singleton.instance.agentName ??
                                                  '',
                                          agrRef:
                                              Singleton.instance.agrRef ?? '',
                                          callerServiceID: Singleton
                                              .instance.callerServiceID
                                              .toString(),
                                          callID: Singleton.instance.callID
                                              .toString(),
                                          callingID: Singleton
                                              .instance.callingID
                                              .toString(),
                                          invalidNumber: Singleton
                                              .instance.invalidNumber
                                              .toString(),
                                          eventType: 'IMAGE CAPTURED',
                                          eventModule: (widget.bloc.userType ==
                                                  Constants.telecaller)
                                              ? 'Telecalling'
                                              : 'Field Allocation',
                                          eventAttr: EventAttr(
                                            remarks: remarksControlller.text,
                                            imageLocation: <String>[],
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
                                          ),
                                        );

                                        debugPrint(
                                            "requestg body data for capture image ----> ${jsonEncode(requestBodyData)}");

                                        widget.bloc.add(PostImageCapturedEvent(
                                            postData: requestBodyData,
                                            fileData: uploadFileLists,
                                            context: context));
                                      } else {
                                        AppUtils.showToast(
                                          Languages.of(context)!.uploadImage,
                                          gravity: ToastGravity.CENTER,
                                        );
                                      }
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
}
