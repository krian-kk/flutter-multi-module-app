import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/widgets/bottomsheet_appbar.dart';
import 'package:origa/widgets/custom_loading_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewWidget extends StatefulWidget {
  final String urlAddress;

  const WebViewWidget({Key? key, required this.urlAddress}) : super(key: key);

  @override
  State<WebViewWidget> createState() => _WebViewWidgetState();
}

class _WebViewWidgetState extends State<WebViewWidget> {
  late WebViewController controller;
  final completer = Completer<WebViewController>();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          controller.runJavascript('add(30, 10)');
        },
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BottomSheetAppbar(
            title: Languages.of(context)!.callCustomer,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15)
                .copyWith(bottom: 5),
          ),
          Expanded(
            child: Stack(
              children: [
                WebView(
                  javascriptMode: JavascriptMode.unrestricted,
                  initialUrl: '',
                  onWebViewCreated: (webViewController) async {
                    controller = webViewController;
                    String fileContent =
                        await rootBundle.loadString('assets/help.html');
                    controller.loadUrl(Uri.dataFromString(fileContent,
                            mimeType: 'text/html',
                            encoding: Encoding.getByName('utf-8'))
                        .toString());
                  },
                  onPageStarted: (val) {
                    // print("Page Started $val");
                    //_loadHTML(controller: controller);
                  },
                  onPageFinished: (finish) {
                    setState(() => isLoading = false);
                    debugPrint("Finished");
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
