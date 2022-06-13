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
    /*final flutterWebviewPlugin = FlutterWebviewPlugin();

    flutterWebviewPlugin.onUrlChanged.listen((String url) {
      AppUtils.showToast('url-> $url');
    });
    flutterWebviewPlugin.onDestroy.listen((event) {
      AppUtils.showToast('onDestroy-> $event');
    });
    flutterWebviewPlugin.onUrlChanged.listen((event) {
      AppUtils.showToast('onUrlChanged-> $event');
    });

    flutterWebviewPlugin.onProgressChanged.listen((event) {
      debugPrint('onProgressChanged--> $event');
    });

    flutterWebviewPlugin.onStateChanged.listen((event) {
      debugPrint('onStateChanged--> $event');
    });

    flutterWebviewPlugin.onBack.listen((event) {
      debugPrint('onBack--> $event');
    });*/
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
                children: const <Widget>[
                  WebviewScaffold(
                    url: 'https://origahelpdesk.w3spaces.com',
                    clearCache: true,
                    allowFileURLs: true,
                    displayZoomControls: true,
                    appCacheEnabled: true,
                    withLocalUrl: true,
                    supportMultipleWindows: true,
                    resizeToAvoidBottomInset: true,
                    initialChild: CustomLoadingWidget(),
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
