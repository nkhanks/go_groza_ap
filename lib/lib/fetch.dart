import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:go_groza/utils/config.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class fetch {
  static post(String url, Map data) async {
    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'deviceid': await _getId()
    };
    print(requestHeaders);
    print("Path : " + config.urlpath + url);
    var uri = Uri.parse(config.urlpath + url);
    var response = await http.post(uri, headers: requestHeaders, body: data);
    print('http response : ' + response.body);
    return convert.jsonDecode(response.body);
  }

  static get(String url) async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'deviceid': await _getId()
    };
    print(requestHeaders);
    print("Path : " + config.urlpath + url);
    var uri = Uri.parse(config.urlpath + url);
    var response = await http.get(uri, headers: requestHeaders);
    print('http response : ' + response.body);
    return convert.jsonDecode(response.body);
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
