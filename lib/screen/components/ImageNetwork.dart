import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageNetwork extends StatelessWidget {
  final url;
  const ImageNetwork({Key key, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return checkUrl(url);
  }
}

Widget checkUrl(String url) {
    var headers = {
  'Accept': 'image/*',
};

  try {
    return Image.network(
        url,
        headers: headers,
        fit: BoxFit.fill);
  } catch (e) {
    return Icon(Icons.image);
  }
}