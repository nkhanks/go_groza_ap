import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:go_groza/utils/colors.dart';
import 'package:go_groza/utils/config.dart';

import 'ImageNetwork.dart';

class orderItem extends StatelessWidget {
  final product;

  const orderItem({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 0,
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(12),
                width: 125,
                height: 125,
                child: Center(
                    child: ImageNetwork(
                        url: config.urlpath + product["file_url"])),
              ),
              Container(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  filtre(product["name"]),
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 5),
                child: Text(
                  product["brand"],
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
              ),
            ],
          ),
        ));
  }

  filtre(String str) {
    if (str.length > 14) {
      return str.replaceRange(14, str.length, "") + "...";
    }
    return str;
  }
}
