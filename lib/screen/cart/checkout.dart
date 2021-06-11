import 'dart:async';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:go_groza/lib/fetch.dart';
import 'package:go_groza/utils/colors.dart';
import 'dart:convert' as convert;
import 'package:go_groza/utils/config.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';

import '../home.dart';

class checkout extends StatefulWidget {
  const checkout({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<checkout> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  _MyAppState();
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
        appBar: AppBar(
          elevation: 0,
          title: Text("Check Out"),
        ),
        body: SafeArea(
            child: WebView(
          navigationDelegate: (NavigationRequest request) {
            if (request.url.contains('/pay-success')) {
              Navigator.pop(context);
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Home(0)));
            }
            if (request.url.contains('/pay-failed')) {
              Navigator.pop(context);
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Home(0)));
            }
            return NavigationDecision.navigate;
          },
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) async {
            _controller.complete(webViewController);
            Map<String, String> requestHeaders = {
              'Content-type': 'application/json',
              'Accept': 'application/json',
              'deviceid': await _getId()
            };
            webViewController.loadUrl(config.urlpath + 'purchase',
                headers: requestHeaders);
          },
        )));
  }

  static Future<String> _getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.androidId; // unique ID on Android
    }
  }
}
