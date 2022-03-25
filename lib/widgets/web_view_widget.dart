import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  late WebViewController controller;
  final completer = Completer<WebViewController>();
  // final flutterWebviewPlugin = FlutterWebviewPlugin();
  bool isLoading = true;

  String samplePage = '''
<!DOCTYPE html><html>
<head><title>Navigation Delegate Example</title></head>
<body>
<p>
The navigation delegate is set to block navigation to the youtube website.
</p>
<ul>
<ul><a href="https://www.youtube.com/">https://www.youtube.com/</a></ul>
<ul><a href="https://www.google.com/">https://www.google.com/</a></ul>
</ul>
</body>
</html>
''';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return FutureBuilder(
    //   future: Future.value(1),
    //   builder: (context, snapshot) {
    //     if (snapshot.hasError) throw snapshot.error!;
    //     if (snapshot.connectionState != ConnectionState.done) {
    //       return Container();
    //     }
    //     return Scaffold(
    //       body: Stack(
    //         children: [
    //           WebView(
    //             javascriptMode: JavascriptMode.unrestricted,
    //             onWebViewCreated: (controller) {
    //               if (!completer.isCompleted) completer.complete(controller);
    //             },
    //           ),
    //           Center(
    //             child: FutureBuilder(
    //               future: completer.future.then((controller) {
    //                 return controller.runJavascript(
    //                     'document.getElementById("Header").innerHTML = "JavaScript Comments";');
    //                 // return controller.runJavascriptReturningResult(
    //                 //     'document.getElementById("myH").innerHTML = "JavaScript Comments";');
    //               }),
    //               builder: (context, snapshot) {
    //                 if (snapshot.hasError) {
    //                   print(snapshot.stackTrace);
    //                   throw snapshot.error!;
    //                 }
    //                 if (snapshot.connectionState != ConnectionState.done)
    //                   return Container();
    //                 return Text(snapshot.data.toString());
    //               },
    //             ),
    //           ),
    //         ],
    //       ),
    //     );
    //   },
    // );
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
              initialUrl: '',
              onWebViewCreated: (webViewController) {
                controller = webViewController;
                loadHtmlAsset();
                debugPrint("Page Start");
                // Completer<WebViewController>().complete(webViewController);
                // webViewController.runJavascript(javaScriptString)
              },
              onPageStarted: (val) {
                print("Page Started == > $val");
              },
              onPageFinished: (finish) {
                setState(() {
                  isLoading = false;
                });
                debugPrint("Finished");
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add_a_photo),
        onPressed: () {
          debugPrint("dkldj");
          controller.runJavascript('''<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=2">
    <script>
        window.fwSettings={
        'widget_id':81000001329,
        'locale': 'en'
        };
        !function(){if("function"!=typeof window.FreshworksWidget){var n=function(){n.q.push(arguments)};n.q=[],window.FreshworksWidget=n}}()
        </script>
        <script type='text/javascript' src='https://ind-widget.freshworks.com/widgets/81000001329.js' async defer></script>
</head>
<body>
    <p>Hello from Flutter</p>
    <p id="result"></p>
</body>
</html>''');
          // flutterWebviewPlugin.evalJavascript('alert("I am an alert box!");');
          // controller
          //     .runJavascript('<script>alert("I am an alert box!");</script>');

          //       controller.runJavascript('''<html>
          //       <body>

          // <h2>JavaScript Statements</h2>

          // <p>In HTML, JavaScript statements are executed by the browser.</p>

          // <p id="demo"></p>

          // <script>
          // document.getElementById("demo").innerHTML = "Hello Dolly.";
          // </script>

          // </body>
          // </html>''');
        },
      ),
    );
  }

  loadHtmlAsset() async {
    String htmlContents = await rootBundle.loadString('assets/temp_html.html');
    controller.loadUrl(Uri.dataFromString(htmlContents,
            mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
        .toString());
  }
}
