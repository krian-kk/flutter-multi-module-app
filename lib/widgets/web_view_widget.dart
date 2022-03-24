import 'dart:async';

import 'package:flutter/material.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/widgets/bottomsheet_appbar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewWidget extends StatefulWidget {
  final String urlAddress;
  const WebViewWidget({Key? key, required this.urlAddress}) : super(key: key);

  @override
  State<WebViewWidget> createState() => _WebViewWidgetState();
}

class _WebViewWidgetState extends State<WebViewWidget> {
  final Completer<WebViewController> controller =
      Completer<WebViewController>();
  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BottomSheetAppbar(
            title: Languages.of(context)!.callCustomer,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15)
                .copyWith(bottom: 5),
          ),
          Expanded(
            child: WebView(
              javascriptMode: JavascriptMode.unrestricted,
              initialUrl: widget.urlAddress,
              onWebViewCreated: (WebViewController webViewController) {
                webViewController.runJavascript('''<script>
window.fwSettings={
'widget_id':81000001329
};
!function(){if("function"!=typeof window.FreshworksWidget){var n=function(){n.q.push(arguments)};n.q=[],window.FreshworksWidget=n}}()
                </script>
                <script type='text/javascript' src='https://ind-widget.freshworks.com/widgets/81000001329.js' async defer></script>''');
              },
              onPageFinished: (finish) {
                setState(() {
                  isLoading = false;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
