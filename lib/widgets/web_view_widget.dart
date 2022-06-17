import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/widgets/custom_loading_widget.dart';

class WebViewWidget extends StatefulWidget {
  const WebViewWidget({Key? key, required this.urlAddress}) : super(key: key);
  final String urlAddress;

  @override
  State<WebViewWidget> createState() => _WebViewWidgetState();
}

class _WebViewWidgetState extends State<WebViewWidget> {
  // late WebViewController controller;
  // final Completer<WebViewController> completer = Completer<WebViewController>();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
  }

  void navigator() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        navigator();
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: Stack(
                children: <Widget>[
                  WebviewScaffold(
                    url: 'https://origahelpdesk.w3spaces.com',
                    clearCache: true,
                    allowFileURLs: true,
                    displayZoomControls: true,
                    javascriptChannels: {
                      JavascriptChannel(
                        name: 'Print',
                        onMessageReceived: (JavascriptMessage message) {
                          debugPrint(
                              'Java script message--> ${message.message}');
                        },
                      ),
                    },
                    appCacheEnabled: true,
                    withLocalUrl: true,
                    supportMultipleWindows: true,
                    resizeToAvoidBottomInset: true,
                    initialChild: const CustomLoadingWidget(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
