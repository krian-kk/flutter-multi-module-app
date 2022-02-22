import 'dart:async';
import 'dart:io';

// import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/widgets/avator_glow_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';

class VoiceRecodingWidget extends StatefulWidget {
  Function? recording;
  final String? caseId;
  VoiceRecodingWidget({Key? key, this.recording, this.caseId})
      : super(key: key);

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
  late String filePath;

  @override
  void initState() {
    getPermission();
    super.initState();
    // startPlaying();
  }

  getPermission() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    filePath = '$appDocPath/${widget.caseId}_${DateTime.now().toString()}.mp3';
    print('File Path => ${filePath}');

    await Record().hasPermission();
    await Permission.microphone.request();
    await Permission.storage.request();
    await Permission.manageExternalStorage.request();
  }

  startRecording() async {
    bool result = await Record().hasPermission();
    await Permission.microphone.request();
    await Permission.storage.request();
    await Permission.manageExternalStorage.request();
    if (result) {
      // Directory dir = Directory(path.dirname(filePath));
      // if (!dir.existsSync()) {
      //   dir.createSync();
      // }

      if (!await Record().isRecording()) {
        await Record().start(
          path: filePath,
          encoder: AudioEncoder.AAC,
          bitRate: 128000,
          samplingRate: 44100,
        );
      }
    }
  }

  stopRecording() async {
    await Record().stop();
  }

  // Future<void> startPlaying() async {
  //   print('djdjlkdlkdlkdlkdlkld');
  //   AssetsAudioPlayer().open(
  //     Audio.file(filePath),
  //     autoStart: true,
  //     showNotification: true,
  //   );
  // }

  // Future<void> stopPlaying() async {
  //   AssetsAudioPlayer().stop();
  // }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      // onPointerDown: (details) {
      //   // FocusScope.of(context).unfocus();
      //   setState(() {
      //     glowingRadius = 22;
      //     recordContainerWidth = 120;
      //     recordContainerColor = ColorResource.colorF7F8FA;
      //     recordCountText = '60 Sec';
      //   });
      //   // FocusScope.of(context).unfocus();
      //   // FocusScope.of(context).canRequestFocus = false;
      // },
      // onPointerUp: (details) {
      //   setState(() {
      //     glowingRadius = 17;
      //     recordContainerWidth = 1;
      //     recordContainerColor = Colors.transparent;
      //     recordCountText = '';
      //   });
      //   // FocusScope.of(context).canRequestFocus = true;
      // },
      child: GestureDetector(
        onTap: () {
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
                    // stopRecording();
                  });
                }
              });
            }
          } else {
            int secondsRemaining = 60;
            if (mounted) {
              setState(() {
                isRecordOn = true;
                glowingRadius = 22;
                recordContainerWidth = 120;
                recordContainerColor = ColorResource.colorF7F8FA;
                recordCountText = '60 Sec';
              });
            }
            // startRecording();
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
                    // stopRecording();
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
          widget.recording!(isRecordOn);
        },
        child: SizedBox(
          child: SizedBox(
            // duration: const Duration(milliseconds: 200),
            width: recordContainerWidth,
            child: Align(
              alignment: Alignment.centerRight,
              child: Stack(
                alignment: Alignment.center,
                // mainAxisSize: MainAxisSize.min,
                // mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    // curve: Curves.linear,
                    // duration: const Duration(milliseconds: 500),
                    alignment: Alignment.centerLeft,
                    height: 40,
                    decoration: BoxDecoration(
                        color: recordContainerColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(60.0))),
                    child: Center(
                        child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
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
                      child: CircleAvatar(
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
