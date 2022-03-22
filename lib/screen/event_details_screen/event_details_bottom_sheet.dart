import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/models/event_details_api_model/result.dart';
import 'package:origa/screen/case_details_screen/bloc/case_details_bloc.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/constants.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/widgets/bottomsheet_appbar.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_loading_widget.dart';
import 'package:origa/widgets/custom_text.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:audioplayers/audioplayers.dart';

import '../../http/api_repository.dart';
import '../../http/httpurls.dart';
import '../../models/audio_convertion_model.dart';
import '../../singleton.dart';
import '../../utils/app_utils.dart';

class CustomEventDetailsBottomSheet extends StatefulWidget {
  final CaseDetailsBloc bloc;
  const CustomEventDetailsBottomSheet(this.cardTitle, this.bloc,
      {Key? key, required this.customeLoanUserWidget})
      : super(key: key);
  final String cardTitle;
  final Widget customeLoanUserWidget;
  static const platform = MethodChannel('recordAudioChannel');

  @override
  State<CustomEventDetailsBottomSheet> createState() =>
      _CustomEventDetailsBottomSheetState();
}

class _CustomEventDetailsBottomSheetState
    extends State<CustomEventDetailsBottomSheet> {
  bool isPlaying = false;
  bool isPaused = false;
  // late AudioPlayer audioPlayer;
  bool loadingAudio = false;
  AudioConvertModel audioConvertyData = AudioConvertModel();
  static const platform = MethodChannel('recordAudioChannel');
  String filePath = '';

  @override
  void initState() {
    super.initState();
    getFileDirectory();
    // audioPlayer = AudioPlayer();
    // audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
    //   if (state == PlayerState.PLAYING) {
    //     setState(() {
    //       isPlaying = true;
    //     });
    //   }
    //   if (state == PlayerState.STOPPED) {
    //     setState(() {
    //       isPlaying = false;
    //       isPaused = false;
    //     });
    //   }
    //   if (state == PlayerState.COMPLETED) {
    //     setState(() {
    //       isPlaying = false;
    //       isPaused = false;
    //     });
    //   }
    //   if (state == PlayerState.PAUSED) {
    //     setState(() {
    //       isPaused = true;
    //     });
    //   }
    // });
  }

  // List<File> uploadFileLists = [];
  // getFiles() async {
  //   FilePickerResult? result12 = await FilePicker.platform
  //       .pickFiles(allowMultiple: false, type: FileType.audio);
  //   if (result12 != null) {
  //     setState(() {
  //       uploadFileLists = result12.paths.map((path) => File(path!)).toList();
  //     });
  //     int result =
  //         await audioPlayer.play(uploadFileLists.first.path, isLocal: true);
  //     if (result == 1) {
  //       setState(() {});
  //     }
  //   } else {
  //     AppUtils.showToast(
  //       Languages.of(context)!.canceled,
  //     );
  //   }
  // }

  // playAudio(String? audioPath) async {
  //   setState(() {
  //     loadingAudio = true;
  //   });
  //   Map<String, dynamic> postResult = await APIRepository.apiRequest(
  //     APIRequestType.post,
  //     HttpUrl.getAudioFile,
  //     requestBodydata: {"pathOfFile": audioPath},
  //   );

  //   if (postResult[Constants.success]) {
  //     audioConvertyData = AudioConvertModel.fromJson(postResult['data']);
  //     var base64 = const Base64Encoder()
  //         .convert(List<int>.from(audioConvertyData.result!.body!.data!));
  //     Uint8List audioBytes = const Base64Codec().decode(base64);
  //     int result = await audioPlayer.playBytes(audioBytes);
  //     if (result == 1) {
  //       setState(() {});
  //     }
  //   } else {
  //     AppUtils.showErrorToast("Didn't get audio file");
  //   }
  //   setState(() => loadingAudio = false);
  // }

  getFileDirectory() async {
    String dir =
        ((await getApplicationDocumentsDirectory()).path) + '/playAudio.wav';
    setState(() {
      filePath = dir;
      // filePath = '/sdcard/Download/ta01.wav';
    });
  }

  playAudio(String? audioPath) async {
    setState(() {
      loadingAudio = true;
    });
    Map<String, dynamic> postResult = await APIRepository.apiRequest(
      APIRequestType.post,
      HttpUrl.getAudioFile,
      requestBodydata: {"pathOfFile": audioPath},
    );
    if (postResult[Constants.success]) {
      audioConvertyData = AudioConvertModel.fromJson(postResult['data']);
      var base64 = const Base64Encoder()
          .convert(List<int>.from(audioConvertyData.result!.body!.data!));
      Uint8List audioBytes = const Base64Codec().decode(base64);
      await File(filePath).writeAsBytes(audioBytes);
      await platform.invokeMethod(
          'playRecordAudio', {'filePath': filePath}).then((value) {
        if (value) {
          setState(() => isPlaying = true);
          setState(() => loadingAudio = false);
        }
      });
      await platform.invokeMethod(
          'completeRecordAudio', {'filePath': filePath}).then((value) {
        if (value != null) {
          setState(() {
            isPlaying = false;
            isPaused = false;
          });
        }
      });
    } else {
      AppUtils.showErrorToast("Did't get audio file");
    }
    setState(() => loadingAudio = false);
  }

  stopAudio() async {
    await platform
        .invokeMethod('stopPlayingAudio', {'filePath': filePath}).then((value) {
      if (value) {
        setState(() {
          isPlaying = false;
          isPaused = false;
        });
      }
    });
  }

  pauseAudio() async {
    await platform.invokeMethod(
        'pausePlayingAudio', {'filePath': filePath}).then((value) {
      if (value) {
        setState(() {
          isPaused = true;
        });
      }
    });
  }

  resumeAudio() async {
    await platform.invokeMethod(
        'resumePlayingAudio', {'filePath': filePath}).then((value) {
      if (value) {
        setState(() {
          isPaused = false;
        });
      }
    });
    await platform.invokeMethod(
        'completeRecordAudio', {'filePath': filePath}).then((value) {
      if (value != null) {
        setState(() {
          isPlaying = false;
          isPaused = false;
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
          children: [
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
            Expanded(
                child: ListView.builder(
                    itemCount:
                        widget.bloc.eventDetailsAPIValue.result?.length ?? 0,
                    itemBuilder: (context, int index) {
                      dynamic listVal = widget
                          .bloc.eventDetailsAPIValue.result!.reversed
                          .toList();
                      return expandList(listVal, index);
                    })),
          ],
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 190,
                  child: CustomButton(
                    Languages.of(context)!.okay.toUpperCase(),
                    onTap: () => Navigator.pop(context),
                    fontSize: FontSize.sixteen,
                    fontWeight: FontWeight.w600,
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

  expandList(List<EventDetailsResultModel> expandedList, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
                  children: [
                    if (expandedList[index].date != null)
                      CustomText(
                        DateFormat('dd MMMM yyyy')
                            .format(DateTime.parse(
                                expandedList[index].date.toString()))
                            .toString()
                            .toUpperCase(),
                        fontSize: FontSize.seventeen,
                        fontWeight: FontWeight.w700,
                        color: ColorResource.color000000,
                      ),
                    CustomText(
                      expandedList[index].eventType.toString().toUpperCase(),
                      fontSize: FontSize.fourteen,
                      fontWeight: FontWeight.w700,
                      color: ColorResource.color000000,
                    ),
                  ],
                ),
                iconColor: ColorResource.color000000,
                collapsedIconColor: ColorResource.color000000,
                children: [
                  expandedList[index].eventType == 'OTS'
                      ? CustomText(
                          "OTS Amount: " + expandedList[index].otsAmt,
                          fontSize: FontSize.fourteen,
                          fontWeight: FontWeight.w700,
                          color: ColorResource.color000000,
                        )
                      : const SizedBox(),
                  if (expandedList[index].mode != null)
                    CustomText(
                      Languages.of(context)!.mode.toString().toUpperCase(),
                      fontSize: FontSize.fourteen,
                      fontWeight: FontWeight.w700,
                      color: ColorResource.color000000,
                    ),
                  if (expandedList[index].mode != null)
                    CustomText(
                      expandedList[index].mode.toString().toUpperCase(),
                      fontSize: FontSize.fourteen,
                      fontWeight: FontWeight.w700,
                      color: ColorResource.color000000,
                    ),
                  const SizedBox(height: 8),
                  if (expandedList[index].eventType == 'REPO')
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          expandedList[index].customerName,
                          fontSize: FontSize.fourteen,
                          fontWeight: FontWeight.w700,
                          color: ColorResource.color000000,
                        ),
                        CustomText(
                          "Model Make: " + expandedList[index].modelMake,
                          fontSize: FontSize.fourteen,
                          fontWeight: FontWeight.w700,
                          color: ColorResource.color000000,
                        ),
                        CustomText(
                          "Registration No: " +
                              expandedList[index].registrationNo,
                          fontSize: FontSize.fourteen,
                          fontWeight: FontWeight.w700,
                          color: ColorResource.color000000,
                        ),
                        CustomText(
                          "Chassis No: " + expandedList[index].chassisNo,
                          fontSize: FontSize.fourteen,
                          fontWeight: FontWeight.w700,
                          color: ColorResource.color000000,
                        ),
                      ],
                    ),
                  CustomText(
                    Languages.of(context)!
                        .remarks
                        .replaceAll('*', '')
                        .toUpperCase(),
                    fontSize: FontSize.fourteen,
                    fontWeight: FontWeight.w700,
                    color: ColorResource.color000000,
                  ),
                  CustomText(
                    expandedList[index].remarks.toString(),
                    fontSize: FontSize.fourteen,
                    fontWeight: FontWeight.w700,
                    color: ColorResource.color000000,
                  ),
                  if (expandedList[index].reginal_text != null &&
                      expandedList[index].translated_text != null &&
                      expandedList[index].audioS3Path != null)
                    remarkS2TaudioWidget(
                        reginalText: expandedList[index].reginal_text,
                        translatedText: expandedList[index].translated_text,
                        audioPath: expandedList[index].audioS3Path),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  remarkS2TaudioWidget(
      {String? reginalText, String? translatedText, String? audioPath}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 9),
        Row(
          children: [
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
                    fontSize: FontSize.fourteen,
                    fontWeight: FontWeight.w400,
                    color: ColorResource.colorFFFFFF,
                    lineHeight: 1,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            GestureDetector(
              onTap: () {
                isPlaying ? stopAudio() : playAudio(audioPath);
                // isPlaying ? stopAudio() : getFiles();
              },
              child: CircleAvatar(
                backgroundColor: ColorResource.color23375A,
                radius: 20,
                child: Center(
                  child: loadingAudio
                      ? CustomLoadingWidget(
                          radius: 11,
                          strokeWidth: 3.0,
                          gradientColors: [
                            ColorResource.colorFFFFFF,
                            ColorResource.colorFFFFFF.withOpacity(0.7),
                          ],
                        )
                      : Icon(
                          isPlaying ? Icons.stop : Icons.play_arrow,
                          color: ColorResource.colorFFFFFF,
                        ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            if (isPlaying)
              GestureDetector(
                onTap: () {
                  isPaused ? resumeAudio() : pauseAudio();
                },
                child: CircleAvatar(
                  backgroundColor: ColorResource.color23375A,
                  radius: 20,
                  child: Center(
                    child: Icon(
                      isPaused ? Icons.play_arrow : Icons.pause,
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
          fontSize: FontSize.fourteen,
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
            fontSize: FontSize.fourteen,
            fontWeight: FontWeight.w400,
            lineHeight: 1,
          ),
        ),
        const SizedBox(height: 12),
        const CustomText(
          Constants.translatedText,
          fontSize: FontSize.fourteen,
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
            fontSize: FontSize.fourteen,
            fontWeight: FontWeight.w400,
            lineHeight: 1,
          ),
        ),
      ],
    );
  }
}
