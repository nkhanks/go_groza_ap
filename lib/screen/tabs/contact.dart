import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_groza/utils/config.dart';
import 'package:go_groza/utils/colors.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class Contact extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<Contact> {
  final Completer<WebViewController> _controller =
  Completer<WebViewController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: WebView(
              javascriptMode: JavascriptMode.unrestricted,
              navigationDelegate: (NavigationRequest request) {
                if(request.url.contains("mailto:")) {
                  launch(request.url);
                  return NavigationDecision.prevent;
                }
                else if (request.url.contains("tel:")) {
                  launch(request.url);
                  return NavigationDecision.prevent;
                }
              },
              onWebViewCreated: (WebViewController webViewController) async {
                _controller.complete(webViewController);
                webViewController.loadUrl(config.urlpath + 'contact-us');
              },
            )));
  }
}
