import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:origa/screen/profile_screen.dart/bloc/profile_bloc.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../languages/app_languages.dart';
import '../../utils/color_resource.dart';
import '../../widgets/bottomsheet_appbar.dart';
import '../../widgets/custom_loading_widget.dart';

class IdCardBottomSheetScreen extends StatefulWidget {
  const IdCardBottomSheetScreen({
    Key? key,
    required this.bloc,
  }) : super(key: key);

  final ProfileBloc bloc;

  @override
  State<IdCardBottomSheetScreen> createState() =>
      _IdCardBottomSheetScreenState();
}

class _IdCardBottomSheetScreenState extends State<IdCardBottomSheetScreen> {
  bool _showFrontSide = true;

  // bool _flipXAxis = true;
  late WebViewController controller;
  final Completer<WebViewController> completer = Completer<WebViewController>();
  bool isLoading = true;

  @override
  initState() {
    super.initState();
    _showFrontSide = true;
    // _flipXAxis = true;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.87,
      child: BlocBuilder<ProfileBloc, ProfileState>(
        bloc: widget.bloc,
        builder: (context, state) {
          return BlocListener<ProfileBloc, ProfileState>(
            bloc: widget.bloc,
            listener: (context, state) {
              if (state is SwitchCardState) {
                setState(() {
                  _showFrontSide = !_showFrontSide;
                });
              }
            },
            child: Scaffold(
              backgroundColor: ColorResource.colorffffff,
              body: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: BottomSheetAppbar(
                      title: Languages.of(context)!.idCard.toUpperCase(),
                      color: ColorResource.color23375A,
                      padding: const EdgeInsets.all(0),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: ColorResource.colorF7F8FA,
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
                      child: Card(
                        elevation: 2.5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: buildFlipAnimation(),
                        // Image.asset(ImageResource.origa)
                      ),
                    ),
                  )
                ],
              ),
              bottomNavigationBar: Row(
                children: [
                  // Expanded(
                  //   child: GestureDetector(
                  //     onTap: () {
                  //       debugPrint('object front');
                  //     },
                  //     child: Container(
                  //         width: MediaQuery.of(context).size.width / 2,
                  //         height: 50,
                  //         margin: const EdgeInsets.only(left: 8, right: 5, bottom: 6),
                  //         decoration: const BoxDecoration(
                  //             color: ColorResource.color23375A,
                  //             borderRadius: BorderRadius.all(Radius.circular(75.0))),
                  //         child: Center(
                  //           child: CustomText(
                  //             Languages.of(context)!.front.toUpperCase(),
                  //             color: ColorResource.colorffffff,
                  //             fontWeight: FontWeight.w700,
                  //             isSingleLine: true,
                  //             lineHeight: 1,
                  //           ),
                  //         )),
                  //   ),
                  // ),
                  // Expanded(
                  //   child: GestureDetector(
                  //     onTap: () {
                  //       debugPrint('object back');
                  //     },
                  //     child: Container(
                  //         height: 50,
                  //         width: MediaQuery.of(context).size.width / 2,
                  //         margin: const EdgeInsets.only(left: 5, right: 8, bottom: 6),
                  //         decoration: BoxDecoration(
                  //             color: ColorResource.colorffffff,
                  //             border: Border.all(color: ColorResource.color23375A),
                  //             borderRadius:
                  //                 const BorderRadius.all(Radius.circular(75.0))),
                  //         child: Center(
                  //           child: CustomText(
                  //             Languages.of(context)!.back.toUpperCase(),
                  //             color: ColorResource.color23375A,
                  //             fontWeight: FontWeight.w700,
                  //             isSingleLine: true,
                  //             lineHeight: 1,
                  //           ),
                  //         )),
                  //   ),
                  // ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: CustomButton(
                        Languages.of(context)!.front.toUpperCase(),
                        cardShape: 75.0,
                        textColor: _showFrontSide
                            ? ColorResource.colorffffff
                            : ColorResource.color23375A,
                        borderColor: ColorResource.color23375A,
                        buttonBackgroundColor: _showFrontSide
                            ? ColorResource.color23375A
                            : ColorResource.colorffffff,
                        onTap: () {
                          if (!_showFrontSide) {
                            widget.bloc.add(SwitchCardEvent());
                          }
                        },
                      )),
                  SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: CustomButton(
                        Languages.of(context)!.back.toUpperCase(),
                        textColor: _showFrontSide
                            ? ColorResource.color23375A
                            : ColorResource.colorffffff,
                        cardShape: 75.0,
                        borderColor: ColorResource.color23375A,
                        buttonBackgroundColor: _showFrontSide
                            ? ColorResource.colorffffff
                            : ColorResource.color23375A,
                        onTap: () {
                          if (_showFrontSide) {
                            widget.bloc.add(SwitchCardEvent());
                          }
                        },
                      )),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildFlipAnimation() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 800),
      transitionBuilder: transitionBuilder,
      layoutBuilder: (widget, list) => Stack(children: [widget!, ...list]),
      child: _showFrontSide ? front() : back(),
      switchInCurve: Curves.easeInCubic,
      switchOutCurve: Curves.easeOutCubic,
    );
  }

  Widget transitionBuilder(Widget widget, Animation<double> animation) {
    final rotateAnim = Tween(begin: pi, end: 0.0).animate(animation);
    return AnimatedBuilder(
      animation: rotateAnim,
      child: widget,
      builder: (context, widget) {
        final isUnder = (ValueKey(_showFrontSide) != widget!.key);
        var tilt = ((animation.value - 0.5).abs() - 0.5) * 0.003;
        tilt *= isUnder ? -1.0 : 1.0;
        final value =
            isUnder ? min(rotateAnim.value, pi / 2) : rotateAnim.value;
        return Transform(
          transform: (Matrix4.rotationY(value)..setEntry(3, 0, tilt)),
          //  _flipXAxis
          //     ? (Matrix4.rotationY(value)..setEntry(3, 0, tilt))
          //     : (Matrix4.rotationX(value)..setEntry(3, 1, tilt)),
          child: widget,
          alignment: Alignment.center,
        );
      },
    );
  }

  Widget front() {
    return buildLayout(
      key: const ValueKey(true),
      // backgroundColor: Colors.blue,
      htmlValue: widget.bloc.idCardFront,
      child: const Padding(
        padding: EdgeInsets.all(32.0),
        child: ColorFiltered(
          colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcATop),
          child: FlutterLogo(),
        ),
      ),
    );
  }

  Widget back() {
    return buildLayout(
      key: const ValueKey(false),
      // backgroundColor: Colors.blue.shade700,
      htmlValue: widget.bloc.idCardBack,
      child: const Padding(
        padding: EdgeInsets.all(20.0),
        child: ColorFiltered(
          colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcATop),
        ),
      ),
    );
  }

  Widget buildLayout(
      {Key? key, Widget? child, String? htmlValue, Color? backgroundColor}) {
    return Container(
      key: key,
      decoration: BoxDecoration(
        // shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(20.0),
        color: backgroundColor,
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            // child: WebView(
            //   javascriptMode: JavascriptMode.unrestricted,
            //   // backgroundColor: Colors.amber,
            //   initialUrl: '',
            //   onWebViewCreated: (WebViewController webViewController) async {
            //     controller = webViewController;
            //     await controller.loadUrl(Uri.dataFromString(htmlValue!,
            //             mimeType: 'text/html',
            //             encoding: Encoding.getByName('utf-8'))
            //         .toString());
            //   },
            //   onPageStarted: (String val) {
            //     //_loadHTML(controller: controller);
            //   },
            //   javascriptChannels: {
            //     JavascriptChannel(
            //         name: 'JavascriptChannel',
            //         onMessageReceived: (JavascriptMessage message) {
            //           // debugPrint(
            //           //     'JavascriptMessage message ----> ${message.message}');
            //         })
            //   },
            //   onPageFinished: (String finish) {
            //     setState(() => isLoading = false);
            //   },
            // ),
          ),
          isLoading ? const CustomLoadingWidget() : const SizedBox(),
        ],
      ),
    );
  }
}
