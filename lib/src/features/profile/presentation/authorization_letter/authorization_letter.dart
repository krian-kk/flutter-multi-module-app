// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:origa/screen/profile_screen.dart/bloc/profile_bloc.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
//
// class AuthorizationLetterBottomSheetScreen extends StatefulWidget {
//   const AuthorizationLetterBottomSheetScreen({
//     Key? key,
//     required this.bloc,
//   }) : super(key: key);
//
//   final ProfileBloc bloc;
//
//   @override
//   State<AuthorizationLetterBottomSheetScreen> createState() =>
//       _AuthorizationLetterBottomSheetScreenState();
// }
//
// class _AuthorizationLetterBottomSheetScreenState
//     extends State<AuthorizationLetterBottomSheetScreen> {
//   late WebViewController controller;
//   final Completer<WebViewController> completer = Completer<WebViewController>();
//   bool isLoading = true;
//
//   @override
//   initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: MediaQuery.of(context).size.height * 0.87,
//       child: BlocBuilder<ProfileBloc, ProfileState>(
//         bloc: widget.bloc,
//         builder: (context, state) {
//           return BlocListener<ProfileBloc, ProfileState>(
//             bloc: widget.bloc,
//             listener: (context, state) {},
//             child: Scaffold(
//               // backgroundColor: ColorResource.colorffffff,
//               body: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: <Widget>[
//                   Padding(
//                     padding: const EdgeInsets.all(20.0),
//                     child: BottomSheetAppbar(
//                       title: Languages.of(context)!
//                           .authorizationLetter
//                           .toUpperCase(),
//                       color: ColorResource.color23375A,
//                       padding: const EdgeInsets.all(0),
//                     ),
//                   ),
//                   Flexible(
//                     child: Container(
//                       color: ColorResource.colorF7F8FA,
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 15, vertical: 20),
//                       child: Card(
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(40.0),
//                           ),
//                           child: Stack(
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.all(20.0),
//                                 child: WebViewWidget(controller: controller)
//                                 // child: WebView(
//                                 //   javascriptMode: JavascriptMode.unrestricted,
//                                 //   initialUrl: '',
//                                 //   onWebViewCreated: (WebViewController
//                                 //       webViewController) async {
//                                 //     controller = webViewController;
//                                 //     await controller.loadUrl(Uri.dataFromString(
//                                 //             widget.bloc.authorizationLetter!,
//                                 //             mimeType: 'text/html',
//                                 //             encoding:
//                                 //                 Encoding.getByName('utf-8'))
//                                 //         .toString());
//                                 //   },
//                                 //   onPageStarted: (String val) {
//                                 //     //_loadHTML(controller: controller);
//                                 //   },
//                                 //   javascriptChannels: {
//                                 //     JavascriptChannel(
//                                 //         name: 'JavascriptChannel',
//                                 //         onMessageReceived:
//                                 //             (JavascriptMessage message) {})
//                                 //   },
//                                 //   onPageFinished: (String finish) {
//                                 //     setState(() => isLoading = false);
//                                 //   },
//                                 // ),
//                               ),
//                               isLoading
//                                   ? const CustomLoadingWidget()
//                                   : const SizedBox(),
//                             ],
//                           )),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
