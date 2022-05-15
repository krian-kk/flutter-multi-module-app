import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:origa/http/api_repository.dart';
import 'package:origa/http/httpurls.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/models/audio_convertion_model.dart';
import 'package:origa/models/event_details_model/result.dart';
import 'package:origa/screen/case_details_screen/bloc/case_details_bloc.dart';
import 'package:origa/screen/event_details_screen/bloc/event_details_bloc.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/constants.dart';
import 'package:origa/utils/date_formate_utils.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/widgets/bottomsheet_appbar.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_loading_widget.dart';
import 'package:origa/widgets/custom_text.dart';
import 'package:path_provider/path_provider.dart';

import '../../widgets/eventdetail_status.dart';

class CustomEventDetailsBottomSheet extends StatefulWidget {
  const CustomEventDetailsBottomSheet(
    this.cardTitle,
    this.bloc, {
    Key? key,
    required this.customeLoanUserWidget,
  }) : super(key: key);
  final CaseDetailsBloc bloc;
  final String cardTitle;
  final Widget customeLoanUserWidget;
  @override
  State<CustomEventDetailsBottomSheet> createState() =>
      _CustomEventDetailsBottomSheetState();
}

class _CustomEventDetailsBottomSheetState
    extends State<CustomEventDetailsBottomSheet> {
  String filePath = '';
  AudioConvertModel audioConvertyData = AudioConvertModel();
  late EventDetailsBloc bloc;

  static const MethodChannel platform = MethodChannel('recordAudioChannel');

  @override
  void initState() {
    super.initState();
    bloc = EventDetailsBloc()
      ..add(EventDetailsInitialEvent(
        widget.bloc.caseId.toString(),
        widget.bloc.userType.toString(),
      ));
    getFileDirectory();
  }

  getFileDirectory() async {
    final String dir = ((await getApplicationDocumentsDirectory()).path) +
        '/TemporaryAudioFile.wav';
    setState(() {
      filePath = dir;
    });
  }

  playAudio(String? audioPath, int index) async {
    setState(() {
      bloc.eventDetailsPlayAudioModel[index].loadingAudio = true;
    });
    final Map<String, dynamic> postResult = await APIRepository.apiRequest(
      APIRequestType.post,
      HttpUrl.getAudioFile,
      requestBodydata: <String, dynamic>{'pathOfFile': audioPath},
    );
    if (postResult[Constants.success]) {
      final AudioConvertModel audioConvertyData =
          AudioConvertModel.fromJson(postResult['data']);
      final String base64 = const Base64Encoder()
          .convert(List<int>.from(audioConvertyData.result!.body!.data!));

      final Uint8List audioBytes = const Base64Codec().decode(base64);
      await File(filePath).writeAsBytes(audioBytes);
      await platform.invokeMethod('playRecordAudio',
          <String, dynamic>{'filePath': filePath}).then((dynamic value) {
        if (value) {
          setState(
              () => bloc.eventDetailsPlayAudioModel[index].isPlaying = true);
          setState(() =>
              bloc.eventDetailsPlayAudioModel[index].loadingAudio = false);
        }
      });
      await platform.invokeMethod('completeRecordAudio',
          <String, dynamic>{'filePath': filePath}).then((dynamic value) {
        if (value != null) {
          setState(() {
            bloc.eventDetailsPlayAudioModel[index].isPlaying = false;
            bloc.eventDetailsPlayAudioModel[index].isPaused = false;
          });
        }
      });
    } else {
      AppUtils.showErrorToast("Did't get audio file");
    }
    setState(() => bloc.eventDetailsPlayAudioModel[index].loadingAudio = false);
  }

  stopAudio(int index) async {
    await platform.invokeMethod('stopPlayingAudio',
        <String, dynamic>{'filePath': filePath}).then((dynamic value) {
      if (value) {
        setState(() {
          bloc.eventDetailsPlayAudioModel[index].isPlaying = false;
          bloc.eventDetailsPlayAudioModel[index].isPaused = false;
        });
      }
    });
  }

  pauseAudio(int index) async {
    await platform.invokeMethod('pausePlayingAudio',
        <String, dynamic>{'filePath': filePath}).then((dynamic value) {
      if (value) {
        setState(() {
          bloc.eventDetailsPlayAudioModel[index].isPaused = true;
        });
      }
    });
  }

  resumeAudio(int index) async {
    await platform.invokeMethod('resumePlayingAudio',
        <String, dynamic>{'filePath': filePath}).then((dynamic value) {
      if (value) {
        setState(() {
          bloc.eventDetailsPlayAudioModel[index].isPaused = false;
        });
      }
    });
    await platform.invokeMethod('completeRecordAudio',
        <String, dynamic>{'filePath': filePath}).then((dynamic value) {
      if (value != null) {
        setState(() {
          bloc.eventDetailsPlayAudioModel[index].isPlaying = false;
          bloc.eventDetailsPlayAudioModel[index].isPaused = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.89,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            BottomSheetAppbar(
              title: widget.cardTitle,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15)
                  .copyWith(bottom: 5),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: widget.customeLoanUserWidget,
            ),
            const SizedBox(height: 10),
            BlocListener<EventDetailsBloc, EventDetailsState>(
              bloc: bloc,
              listener: (BuildContext context, EventDetailsState state) {},
              child: BlocBuilder<EventDetailsBloc, EventDetailsState>(
                bloc: bloc,
                builder: (BuildContext context, EventDetailsState state) {
                  if (state is EventDetailsLoadingState) {
                    return const Expanded(
                      child: Center(
                        child: CustomLoadingWidget(),
                      ),
                    );
                  } else {
                    return Expanded(
                        child: ListView.builder(
                            itemCount:
                                bloc.eventDetailsAPIValues.result?.length ?? 0,
                            itemBuilder: (BuildContext context, int index) {
                              final dynamic listVal = bloc
                                  .eventDetailsAPIValues.result!.reversed
                                  .toList();
                              return expandList(listVal, index);
                            }));
                  }
                },
              ),
            ),
          ],
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 190,
                  child: CustomButton(
                    Languages.of(context)!.okay.toUpperCase(),
                    onTap: () => Navigator.pop(context),
                    fontSize: FontSize.sixteen,
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

  expandList(List<EvnetDetailsResultsModel> expandedList, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(
          height: 10,
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 12, left: 18, right: 18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: ColorResource.colorF4E8E4,
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 3, 14, 15),
            child: Theme(
              data: ThemeData().copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                tilePadding: const EdgeInsetsDirectional.all(0),
                expandedCrossAxisAlignment: CrossAxisAlignment.start,
                expandedAlignment: Alignment.centerLeft,
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    if (expandedList[index].createdAt != null)
                      Row(
                        children: [
                          CustomText(
                            DateFormateUtils.followUpDateFormate(
                                expandedList[index].createdAt.toString()),
                            fontSize: FontSize.seventeen,
                            fontWeight: FontWeight.w700,
                            color: ColorResource.color000000,
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          EventDetailsAppStatus.eventDetailAppStatus(
                              expandedList[index].eventAttr!.appStatus ?? '')
                        ],
                      ),
                    CustomText(
                      expandedList[index].eventType.toString().toUpperCase(),
                      fontWeight: FontWeight.w700,
                      color: ColorResource.color000000,
                    ),
                  ],
                ),
                iconColor: ColorResource.color000000,
                collapsedIconColor: ColorResource.color000000,
                children: <Widget>[
                  CustomText(
                    '${expandedList[index].eventModule}',
                    fontWeight: FontWeight.w700,
                    color: ColorResource.color000000,
                  ),
                  if (expandedList[index].createdBy != null)
                    CustomText(
                      '${Languages.of(context)!.agent} : ${expandedList[index].createdBy}',
                      fontWeight: FontWeight.w700,
                      color: ColorResource.color000000,
                    ),
                  // if (expandedList[index].eventType?.toLowerCase() ==
                  //         Constants.receipt.toLowerCase() &&
                  //     expandedList[index].eventAttr?.amountCollected != null)
                  //   CustomText(
                  //     '${Languages.of(context)!.amount} : ${expandedList[index].eventAttr?.amountCollected.toString()}',
                  //     fontWeight: FontWeight.w700,
                  //     color: ColorResource.color000000,
                  //   ),
                  if (
                  // expandedList[index].eventType?.toLowerCase() ==
                  //       Constants.ptp.toLowerCase() &&
                  expandedList[index].eventAttr?.ptpAmount != null)
                    CustomText(
                      '${Languages.of(context)!.ptpAmount.replaceAll('*', '')} : ${expandedList[index].eventAttr?.ptpAmount.toString()}',
                      fontWeight: FontWeight.w700,
                      color: ColorResource.color000000,
                    ),
                  if (expandedList[index].eventAttr?.date != null)
                    CustomText(
                      expandedList[index].eventType == 'RECEIPT'
                          ? '${Languages.of(context)!.date.replaceAll('*', '')} : ${DateFormateUtils2.followUpDateFormate2(expandedList[index].eventAttr!.date.toString())}'
                          : '${Languages.of(context)!.followUpDate.replaceAll('*', '')} : ${DateFormateUtils2.followUpDateFormate2(expandedList[index].eventAttr!.date.toString())}',
                      fontWeight: FontWeight.w700,
                      color: ColorResource.color000000,
                    ),
                  if (expandedList[index].eventAttr?.time != null)
                    CustomText(
                      '${Languages.of(context)!.time.replaceAll('*', '')} : ${expandedList[index].eventAttr?.time.toString()}',
                      fontWeight: FontWeight.w700,
                      color: ColorResource.color000000,
                    ),
                  if (expandedList[index].eventAttr?.mode != null)
                    CustomText(
                      '${Languages.of(context)!.paymentMode} : ${expandedList[index].eventAttr?.mode.toString()}',
                      fontWeight: FontWeight.w700,
                      color: ColorResource.color000000,
                    ),
                  // if (expandedList[index].eventType?.toLowerCase() ==
                  //         Constants.ptp.toLowerCase() ||
                  //     expandedList[index].eventType?.toLowerCase() ==
                  //         Constants.tcPtp.toLowerCase())
                  //   CustomText(
                  //     '${Languages.of(context)!.paymentMode} : ${expandedList[index].eventAttr?.ptpType.toString()}',
                  //     fontSize: FontSize.fourteen,
                  //     fontWeight: FontWeight.w700,
                  //     color: ColorResource.color000000,
                  //   ),
                  if (expandedList[index].eventAttr?.remarks != null)
                    CustomText(
                      '${Languages.of(context)!.remarks.replaceAll('*', '')} : ${expandedList[index].eventAttr?.remarks.toString()}',
                      fontWeight: FontWeight.w700,
                      color: ColorResource.color000000,
                    ),
                  if (expandedList[index].eventAttr?.followUpPriority != null)
                    CustomText(
                      '${Languages.of(context)!.followUpPriority} : ${expandedList[index].eventAttr?.followUpPriority.toString()}',
                      fontWeight: FontWeight.w700,
                      color: ColorResource.color000000,
                    ),
                  if (expandedList[index].eventAttr?.customerName != null)
                    CustomText(
                      '${Languages.of(context)!.customerName.replaceAll('*', '')} : ${expandedList[index].eventAttr?.customerName.toString()}',
                      fontWeight: FontWeight.w700,
                      color: ColorResource.color000000,
                    ),
                  if (expandedList[index].eventAttr?.amountCollected != null)
                    CustomText(
                      '${Languages.of(context)!.amountCollected.replaceAll('*', '')}: ${expandedList[index].eventAttr?.amountCollected.toString()}',
                      fontWeight: FontWeight.w700,
                      color: ColorResource.color000000,
                    ),
                  if (expandedList[index].eventAttr?.reminderDate != null)
                    CustomText(
                      '${Languages.of(context)!.followUpDate.replaceAll('*', '')} : ${DateFormateUtils2.followUpDateFormate2(expandedList[index].eventAttr?.reminderDate.toString() ?? '')}',
                      fontWeight: FontWeight.w700,
                      color: ColorResource.color000000,
                    ),
                  if (expandedList[index].eventAttr?.chequeRefNo != null)
                    CustomText(
                      '${Languages.of(context)!.refCheque.replaceAll('*', '').toLowerCase().replaceAll('r', 'R')} : ${expandedList[index].eventAttr?.chequeRefNo.toString()}',
                      fontWeight: FontWeight.w700,
                      color: ColorResource.color000000,
                    ),
                  if (expandedList[index].eventAttr?.amntOts != null)
                    CustomText(
                      'OTS ${Languages.of(context)!.amount} : ${expandedList[index].eventAttr?.amntOts.toString()}',
                      fontWeight: FontWeight.w700,
                      color: ColorResource.color000000,
                    ),
                  if (expandedList[index].eventAttr?.nextActionDate != null)
                    CustomText(
                      '${Languages.of(context)!.followUpDate.replaceAll('*', '')} : ${DateFormateUtils2.followUpDateFormate2(expandedList[index].eventAttr?.nextActionDate.toString() ?? '')}',
                      fontWeight: FontWeight.w700,
                      color: ColorResource.color000000,
                    ),
                  if (expandedList[index].eventAttr?.actionDate != null)
                    CustomText(
                      '${Languages.of(context)!.followUpDate.replaceAll('*', '')} : ${DateFormateUtils2.followUpDateFormate2(expandedList[index].eventAttr?.actionDate.toString() ?? '')}',
                      fontWeight: FontWeight.w700,
                      color: ColorResource.color000000,
                    ),
                  if (expandedList[index].eventAttr?.remarkOts != null)
                    CustomText(
                      '${Languages.of(context)!.remarks.replaceAll('*', '')} : ${expandedList[index].eventAttr?.remarkOts.toString()}',
                      fontWeight: FontWeight.w700,
                      color: ColorResource.color000000,
                    ),
                  // if (expandedList[index].createdAt != null)
                  //   CustomText(
                  //     'createdAt : ${expandedList[index].createdAt.toString()}',
                  //     fontWeight: FontWeight.w700,
                  //     color: ColorResource.color000000,
                  //   ),
                  // if (expandedList[index].createdBy != null)
                  //   CustomText(
                  //     'createdBy : ${expandedList[index].createdBy.toString()}',
                  //     fontWeight: FontWeight.w700,
                  //     color: ColorResource.color000000,
                  //   ),
                  // expandedList[index].eventType == 'OTS'
                  //     ? (expandedList[index].eventAttr?.amntOts != null)
                  //         ? CustomText(
                  //             'OTS Amount: ${expandedList[index].eventAttr?.amntOts}',
                  //             fontSize: FontSize.fourteen,
                  //             fontWeight: FontWeight.w700,
                  //             color: ColorResource.color000000,
                  //           )
                  //         : const SizedBox()
                  //     : const SizedBox(),
                  // if (expandedList[index].eventType == 'RECEIPT')
                  //   Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       if (expandedList[index].eventAttr?.customerName != null)
                  //         CustomText(
                  //           expandedList[index].eventAttr?.customerName ?? '-',
                  //           fontSize: FontSize.fourteen,
                  //           fontWeight: FontWeight.w700,
                  //           color: ColorResource.color000000,
                  //         ),
                  //       if (expandedList[index].eventAttr?.amountCollected !=
                  //           null)
                  //         CustomText(
                  //           'Receipt Amount : ${Constants.inr}${expandedList[index].eventAttr?.amountCollected ?? '-'}',
                  //           fontSize: FontSize.fourteen,
                  //           fontWeight: FontWeight.w700,
                  //           color: ColorResource.color000000,
                  //         ),
                  //       (expandedList[index].eventAttr?.chequeRefNo != null)
                  //           ? CustomText(
                  //               'Cheque RefNo : ${expandedList[index].eventAttr?.chequeRefNo ?? '_'}',
                  //               fontSize: FontSize.fourteen,
                  //               fontWeight: FontWeight.w700,
                  //               color: ColorResource.color000000,
                  //             )
                  //           : const SizedBox(),
                  //     ],
                  //   ),
                  // if (expandedList[index].eventType == 'PTP')
                  //   Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [

                  //       if (expandedList[index].eventAttr?.amountCollected !=
                  //           null)
                  //         CustomText(
                  //           'Receipt Amount : ${Constants.inr}${expandedList[index].eventAttr?.amountCollected ?? '-'}',
                  //           fontSize: FontSize.fourteen,
                  //           fontWeight: FontWeight.w700,
                  //           color: ColorResource.color000000,
                  //         ),

                  //     ],
                  //   ),
                  // if (expandedList[index].eventAttr?.mode != null)
                  //   CustomText(
                  //     expandedList[index]
                  //         .eventAttr!
                  //         .mode
                  //         .toString()
                  //         .toUpperCase(),
                  //     fontSize: FontSize.fourteen,
                  //     fontWeight: FontWeight.w700,
                  //     color: ColorResource.color000000,
                  //   ),
                  // const SizedBox(height: 8),
                  if (expandedList[index].eventType == Constants.repo)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (expandedList[index].eventAttr?.modelMake != null)
                          CustomText(
                            '${Languages.of(context)!.modelMake.replaceAll('*', '')} : ${expandedList[index].eventAttr!.modelMake}',
                            fontWeight: FontWeight.w700,
                            color: ColorResource.color000000,
                          ),
                        if (expandedList[index].eventAttr?.registrationNo !=
                            null)
                          CustomText(
                            '${Languages.of(context)!.registrationNo.replaceAll('*', '')} : ${expandedList[index].eventAttr!.registrationNo}',
                            fontWeight: FontWeight.w700,
                            color: ColorResource.color000000,
                          ),
                        if (expandedList[index].eventAttr?.chassisNo != null)
                          CustomText(
                            '${Languages.of(context)!.chassisNo.replaceAll('*', '')} : ${expandedList[index].eventAttr!.chassisNo}',
                            fontWeight: FontWeight.w700,
                            color: ColorResource.color000000,
                          ),
                      ],
                    ),
                  // CustomText(
                  //   Languages.of(context)!
                  //       .remarks
                  //       .replaceAll('*', '')
                  //       .toUpperCase(),
                  //   fontSize: FontSize.fourteen,
                  //   fontWeight: FontWeight.w700,
                  //   color: ColorResource.color000000,
                  // ),
                  // CustomText(
                  //   (expandedList[index].eventAttr?.remarks != null)
                  //       ? expandedList[index].eventAttr!.remarks.toString()
                  //       : (expandedList[index].eventAttr?.remarkOts != null)
                  //           ? expandedList[index]
                  //               .eventAttr!
                  //               .remarkOts
                  //               .toString()
                  //           : '_',
                  //   fontSize: FontSize.fourteen,
                  //   fontWeight: FontWeight.w700,
                  //   color: ColorResource.color000000,
                  // ),
                  if (expandedList[index].eventAttr?.reginalText != null &&
                      expandedList[index].eventAttr?.translatedText != null &&
                      expandedList[index].eventAttr?.audioS3Path != null)
                    remarkS2TaudioWidget(
                      reginalText: expandedList[index].eventAttr?.reginalText,
                      translatedText:
                          expandedList[index].eventAttr?.translatedText,
                      audioPath: expandedList[index].eventAttr?.audioS3Path,
                      index: index,
                    ),
                  appStatus(expandedList[index].eventAttr!.appStatus ?? '')
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  appStatus(status) {
    Widget? returnWidget;
    switch (status) {
      case 'approved':
        returnWidget = appStatusText(ColorResource.red, 'Approved');
        break;
      case 'new':
        returnWidget = appStatusText(ColorResource.orange, 'Awaiting Approval');
        break;
      case 'rejected':
        returnWidget = appStatusText(ColorResource.green, 'Rejected');
        break;
      default:
        returnWidget = const SizedBox();
        break;
    }
    return returnWidget;
  }

  Widget appStatusText(Color color, String value) {
    return Padding(
      padding: const EdgeInsets.only(top: 13),
      child: CustomText(
        value,
        color: color,
        fontWeight: FontWeight.w500,
        fontSize: FontSize.sixteen,
      ),
    );
  }

  remarkS2TaudioWidget({
    String? reginalText,
    String? translatedText,
    String? audioPath,
    required int index,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 9),
        Row(
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                  color: ColorResource.color23375A,
                  borderRadius: BorderRadius.all(Radius.circular(60.0))),
              height: 40,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 11,
                  ),
                  child: CustomText(
                    Languages.of(context)!.remarksRecording,
                    color: ColorResource.colorFFFFFF,
                    lineHeight: 1,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            GestureDetector(
              onTap: () {
                bloc.eventDetailsPlayAudioModel[index].isPlaying
                    ? stopAudio(index)
                    : playAudio(audioPath, index);
              },
              child: CircleAvatar(
                backgroundColor: ColorResource.color23375A,
                radius: 20,
                child: Center(
                  child: bloc.eventDetailsPlayAudioModel[index].loadingAudio
                      ? CustomLoadingWidget(
                          radius: 11,
                          strokeWidth: 3.0,
                          gradientColors: <Color>[
                            ColorResource.colorFFFFFF,
                            ColorResource.colorFFFFFF.withOpacity(0.7),
                          ],
                        )
                      : Icon(
                          bloc.eventDetailsPlayAudioModel[index].isPlaying
                              ? Icons.stop
                              : Icons.play_arrow,
                          color: ColorResource.colorFFFFFF,
                        ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            if (bloc.eventDetailsPlayAudioModel[index].isPlaying)
              GestureDetector(
                onTap: () {
                  bloc.eventDetailsPlayAudioModel[index].isPaused
                      ? resumeAudio(index)
                      : pauseAudio(index);
                },
                child: CircleAvatar(
                  backgroundColor: ColorResource.color23375A,
                  radius: 20,
                  child: Center(
                    child: Icon(
                      bloc.eventDetailsPlayAudioModel[index].isPaused
                          ? Icons.play_arrow
                          : Icons.pause,
                      color: ColorResource.colorFFFFFF,
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 12),
        const CustomText(
          Constants.reginalText,
          fontWeight: FontWeight.w700,
          color: ColorResource.color000000,
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 13),
          decoration: const BoxDecoration(
              color: ColorResource.colorF7F8FA,
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          child: CustomText(
            reginalText!,
            color: ColorResource.color000000,
            lineHeight: 1,
          ),
        ),
        const SizedBox(height: 12),
        const CustomText(
          Constants.translatedText,
          fontWeight: FontWeight.w700,
          color: ColorResource.color000000,
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 13),
          decoration: const BoxDecoration(
              color: ColorResource.colorF7F8FA,
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          child: CustomText(
            translatedText!,
            color: ColorResource.color000000,
            lineHeight: 1,
          ),
        ),
      ],
    );
  }
}
