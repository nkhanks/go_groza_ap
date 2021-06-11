import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:go_groza/lib/fetch.dart';
import 'package:go_groza/screen/components/ImageNetwork.dart';
import 'package:go_groza/screen/components/categories.dart';
import 'package:go_groza/screen/components/shop.dart';
import 'package:go_groza/utils/colors.dart';
import 'package:go_groza/utils/config.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class shopDetail extends StatelessWidget {
  final shop;

  const shopDetail({Key key, this.shop}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
                padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                child: Column(children: [
                  Container(
                      padding: EdgeInsets.all(16),
                      child: Row(children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.1,
                          child: ImageNetwork(
                              url: config.urlpath + shop["file_url"]),
                        ),
                        Container(
                            padding: EdgeInsets.only(left: 16),
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: Text(
                              shop["name"],
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.1,
                          child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Icon(Entypo.chevron_down)),
                        ),
                      ])),
                  Divider(),
                  Container(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        "Select Shopping Category",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      )),
                  Padding(padding: EdgeInsets.all(16)),
                  categoryLists(categories: shop["subCategories"])
                ]))));
  }
}
