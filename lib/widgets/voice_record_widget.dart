import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_sound_platform_interface/flutter_sound_recorder_platform_interface.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:origa/http/api_repository.dart';
import 'package:origa/http/httpurls.dart';
import 'package:origa/listener/item_selected_listener.dart';
import 'package:origa/models/audio_remarks_post_model.dart';
import 'package:origa/models/speech2text_model.dart';
import 'package:origa/singleton.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/widgets/avator_glow_widget.dart';
import 'package:origa/widgets/custom_dialog.dart';
import 'package:origa/widgets/custom_loading_widget.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../languages/app_languages.dart';
import '../utils/constants.dart';

const AudioSource theSource = AudioSource.microphone;

class VoiceRecodingWidget extends StatefulWidget {
  const VoiceRecodingWidget(
      {Key? key,
      this.recordingData,
      this.caseId,
      required this.filePath,
      this.checkRecord,
      required this.onRecordStart,
      required this.enableTextFieldFunction})
      : super(key: key);
  final String filePath;
  final Function? recordingData;
  final String? caseId;
  final OnChangeCheckRecord? checkRecord;
  final Function onRecordStart;
  final OnChangeIsEnable enableTextFieldFunction;

  @override
  State<VoiceRecodingWidget> createState() => _VoiceRecodingWidgetState();
}

class _VoiceRecodingWidgetState extends State<VoiceRecodingWidget>
    with SingleTickerProviderStateMixin {
  double glowingRadius = 17;
  double recordContainerWidth = 1;
  Color recordContainerColor = Colors.transparent;
  String recordCountText = '';
  Timer? timer;
  bool isRecordOn = false;

  bool isStartLoading = false;
  List<File> uploadFileLists = <File>[];

  final Codec _codec = Codec.pcm16WAV;

  // final String _mPath = '/sdcard/Download/taNew.wav';
  // FlutterSoundPlayer? _mPlayer = FlutterSoundPlayer();
  FlutterSoundRecorder? _mRecorder = FlutterSoundRecorder();
  bool recorderIsInited = false;
  Speech2TextModel getTranslatedData = Speech2TextModel();

  static const MethodChannel platform = MethodChannel('recordAudioChannel');

  @override
  void initState() {
    openTheRecorder().then((void value) {
      setState(() {
        recorderIsInited = true;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _mRecorder!.closeRecorder();
    _mRecorder = null;
    timer?.cancel();
    super.dispose();
  }

  Future<void> openTheRecorder() async {
    await Permission.storage.request();
    final PermissionStatus status = await Permission.microphone.request();
    if (Platform.isAndroid) {
      if (status != PermissionStatus.granted) {
        throw RecordingPermissionException('Microphone permission not granted');
      }
    }
    await _mRecorder!.openRecorder();
    recorderIsInited = true;
  }

  // ----------------------  Here is the code for recording  -------

  Future<bool> startRecord() async {
    FocusScope.of(context).unfocus();
    bool result = false;
    widget.onRecordStart();
    if (Platform.isIOS) {
      await Permission.microphone.request();
      await Permission.storage.request();
      //remove play button
      widget.recordingData!('');
      await platform.invokeMethod('startRecordAudio',
          <String, dynamic>{'filePath': widget.filePath}).then((dynamic value) {
        widget.enableTextFieldFunction(!value);
        setState(() => result = value);
        // setState(() => widget.isEnableTextField = value);
      });
    } else if (Platform.isAndroid) {
      if (!recorderIsInited) {
        await openTheRecorder();
      }
      //remove play button
      widget.recordingData!('');
      await _mRecorder!
          .startRecorder(
        toFile: widget.filePath,
        codec: _codec,
        audioSource: theSource,
      )
          .then((void value) {
        widget.enableTextFieldFunction(false);
        setState(() => result = true);
      });
    }
    if (result) {
      widget.checkRecord!(Constants.process, '', Speech2TextModel());
    }
    return result;
  }

  stopRecorder() async {
    if (Platform.isIOS) {
      await platform.invokeMethod('stopRecordAudio',
          <String, dynamic>{'filePath': widget.filePath}).then((dynamic value) {
        if (value) {
          // startAPICall();
          apiCall();
          setState(() => isStartLoading = true);
        } else {
          AppUtils.showToast('Audio Record Has Some Issue.');
        }
      });
    } else if (Platform.isAndroid) {
      await _mRecorder!.stopRecorder().then((String? value) {
        apiCall();
        // getFiles();
        setState(() {
          isStartLoading = true;
        });
      });
    }
    widget.checkRecord!(Constants.stop, '', Speech2TextModel());
  }

  apiCall() async {
    if (mounted) {
      setState(() => uploadFileLists = <File>[File(widget.filePath)]);
    }
    await audioTranslateAPI();
  }

  // getFiles() async {
  //   FilePickerResult? result = await FilePicker.platform
  //       .pickFiles(allowMultiple: false, type: FileType.audio);
  //   if (result != null) {
  //     setState(() {
  //       uploadFileLists = result.paths.map((path) => File(path!)).toList();
  //     });
  //     await audioTranslateAPI();
  //   } else {
  //     AppUtils.showToast(
  //       Languages.of(context)!.canceled,
  //       gravity: ToastGravity.CENTER,
  //     );
  //   }
  // }

  audioTranslateAPI() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final AudioRemarksPostModel requestBodyData = AudioRemarksPostModel(
      // langCode: AppUtils.getLanguageCode(context).toString() + "-IN",
      langCode: prefs.getString(Constants.s2tLangcode),
      agrRef: Singleton.instance.agrRef,
    );
    final Map<String, dynamic> postdata =
        jsonDecode(jsonEncode(requestBodyData.toJson()))
            as Map<String, dynamic>;
    final List<dynamic> value = <dynamic>[];
    for (File element in uploadFileLists) {
      value.add(await MultipartFile.fromFile(element.path.toString()));
      debugPrint('File values--> ${element.path.toString()}');
      final int sizeInBytes = element.lengthSync();
      final double sizeInMb = sizeInBytes / (1024 * 1024);
      debugPrint('File Size--> $sizeInMb');
    }
    postdata.addAll(<String, dynamic>{
      'files': value,
    });

    final Map<String, dynamic> postResult = await APIRepository.apiRequest(
      APIRequestType.upload,
      HttpUrl.audioRemarksURL,
      formDatas: FormData.fromMap(postdata),
    );

    setState(() {
      isStartLoading = false;
    });

    if (postResult[Constants.success]) {
      getTranslatedData = Speech2TextModel.fromJson(postResult['data']);
      // widget.recordingData!(getTranslatedData.result!.translatedText);
      widget.recordingData!(getTranslatedData);
      widget.checkRecord!(
        Constants.submit,
        getTranslatedData.result?.translatedText,
        getTranslatedData,
      );
      widget.enableTextFieldFunction(true);
    } else {
      widget.enableTextFieldFunction(true);
      widget.checkRecord!(Constants.none, '', Speech2TextModel());
    }
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   timer?.cancel();
  // }

  @override
  Widget build(BuildContext context) {
    return Listener(
      child: GestureDetector(
        onTap: () async {
          if (!isStartLoading) {
            final SharedPreferences prefs =
                await SharedPreferences.getInstance();
            if (prefs.getString(Constants.s2tLangcode) != null) {
              if (isRecordOn) {
                if (mounted) {
                  setState(() {
                    timer?.cancel();
                    if (mounted) {
                      setState(() {
                        glowingRadius = 17;
                        recordContainerWidth = 1;
                        recordContainerColor = Colors.transparent;
                        recordCountText = '';
                        isRecordOn = false;
                        stopRecorder();
                      });
                    }
                  });
                }
              } else {
                int secondsRemaining = 30;
                if (mounted) {
                  setState(() {
                    isRecordOn = true;
                    glowingRadius = 22;
                    recordContainerWidth = 120;
                    recordContainerColor = ColorResource.colorF7F8FA;
                    recordCountText = '30 Sec';
                  });
                }
                await startRecord();
                timer = Timer.periodic(const Duration(seconds: 1), (_) {
                  if (secondsRemaining != 0) {
                    if (mounted) {
                      setState(() {
                        secondsRemaining--;
                        recordCountText = '${secondsRemaining.toString()} Sec';
                      });
                    }
                  } else {
                    setState(() {
                      if (timer!.isActive) {
                        timer?.cancel();
                        stopRecorder();
                        if (mounted) {
                          setState(() {
                            isRecordOn = false;
                            recordContainerColor = Colors.transparent;
                            glowingRadius = 17;
                            recordContainerWidth = 1;
                            recordCountText = '';
                          });
                        }
                      }
                    });
                  }
                });
              }
              widget.recordingData!(isRecordOn);
            } else {
              await DialogUtils.showDialog(
                  buildContext: context,
                  title: Languages.of(context)!.errorMsgS2TlangCode,
                  description: '',
                  okBtnText: Languages.of(context)!.cancel.toUpperCase(),
                  okBtnFunction: (String val) {
                    Navigator.pop(context);
                  });
            }
          }
        },
        child: SizedBox(
          child: SizedBox(
            width: recordContainerWidth,
            child: Align(
              alignment: Alignment.centerRight,
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    height: 40,
                    decoration: BoxDecoration(
                        color: recordContainerColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(30.0))),
                    child: Center(
                        child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          child: Text(recordCountText),
                        ),
                        const SizedBox(width: 20),
                      ],
                    )),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: AvatarGlowWidget(
                      animate: isRecordOn,
                      endRadius: 25,
                      duration: const Duration(milliseconds: 1000),
                      glowColor: ColorResource.color23375A.withOpacity(0.3),
                      child: isStartLoading
                          ? const CustomLoadingWidget(
                              radius: 12,
                              strokeWidth: 3,
                            )
                          : CircleAvatar(
                              backgroundColor: ColorResource.color23375A,
                              radius: 15,
                              child: Center(
                                child: SvgPicture.asset(
                                  ImageResource.microPhoneImage,
                                  width: 10,
                                  height: 15,
                                ),
                              ),
                            ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
