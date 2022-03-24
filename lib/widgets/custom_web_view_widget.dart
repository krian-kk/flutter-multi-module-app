import 'dart:async';

import 'package:flutter/material.dart';
import 'package:origa/widgets/custom_loading_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewWidget extends StatefulWidget {
  final String urlAddress;
  const WebViewWidget({Key? key, required this.urlAddress}) : super(key: key);

  @override
  State<WebViewWidget> createState() => _WebViewWidgetState();
}

class _WebViewWidgetState extends State<WebViewWidget> {
  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WebView(
          initialUrl: widget.urlAddress,
          onWebViewCreated: (WebViewController webViewController) {
            Completer<WebViewController>().complete(webViewController);
          },
          onPageFinished: (finish) {
            setState(() {
              isLoading = false;
            });
          },
        ),
        isLoading ? const CustomLoadingWidget() : const SizedBox(),
      ],
    );
  }
}
