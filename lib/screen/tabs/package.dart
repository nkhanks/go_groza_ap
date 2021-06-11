import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_groza/lib/fetch.dart';
import 'package:go_groza/screen/components/search.dart';
import 'package:go_groza/screen/components/shops.dart';
import 'package:go_groza/screen/tabs/packages/group-list.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'package:go_groza/utils/config.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class Package extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<Package> {
  //State class

  String search = "all";
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Padding(padding: EdgeInsets.all(32)),
        Padding(
            padding: EdgeInsets.only(left: 32, right: 32),
            child: Search(onChange: (String value) {
              setState(() {
                search = value.isEmpty ? "all" : value;
              });
            })),
        FutureBuilder(
          builder: (context, orderSnap) {
            if (!orderSnap.hasData) {
              print('project snapshot data is: ${orderSnap.data}');
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (orderSnap.hasError) {
              print("Error Fetching Order");
              return Center(child: Text("Error Fetching Products"));
            }

            return Padding(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: groupList(packages: orderSnap.data["data"]));
          },
          future: getShops(),
        )
      ]),
    );
  }

  Future getShops() async {
    print('http fetching...');

    var response = await fetch.get("api/groups");
    return response;
  }
}
