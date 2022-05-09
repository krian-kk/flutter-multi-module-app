import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/widgets/bottomsheet_appbar.dart';
import 'package:origa/widgets/custom_loading_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewWidget extends StatefulWidget {
  const WebViewWidget({Key? key, required this.urlAddress}) : super(key: key);
  final String urlAddress;

  @override
  State<WebViewWidget> createState() => _WebViewWidgetState();
}

class _WebViewWidgetState extends State<WebViewWidget> {
  late WebViewController controller;
  final Completer<WebViewController> completer = Completer<WebViewController>();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          BottomSheetAppbar(
            title: Languages.of(context)!.callCustomer,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15)
                .copyWith(bottom: 5),
          ),
          Expanded(
            child: Stack(
              children: <Widget>[
                WebView(
                  javascriptMode: JavascriptMode.unrestricted,
                  initialUrl: '',
                  onWebViewCreated:
                      (WebViewController webViewController) async {
                    controller = webViewController;
                    final String fileContent =
                        await rootBundle.loadString('assets/help.html');
                    await controller.loadUrl(Uri.dataFromString(fileContent,
                            mimeType: 'text/html',
                            encoding: Encoding.getByName('utf-8'))
                        .toString());
                  },
                  onPageStarted: (String val) {
                    //_loadHTML(controller: controller);
                  },
                  onPageFinished: (String finish) {
                    setState(() => isLoading = false);
                  },
                ),
                isLoading ? const CustomLoadingWidget() : const SizedBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
