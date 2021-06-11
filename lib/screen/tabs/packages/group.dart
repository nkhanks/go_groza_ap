import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:go_groza/screen/tabs/packages/products.dart';
import 'dart:math';
import 'dart:convert';
import 'package:go_groza/utils/colors.dart';

import 'collection-products.dart';
import 'list-products.dart';

class group extends StatelessWidget {
  final item;

  const group({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
            child: Container(
                width: 80,
                height: 80,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(180.0),
                    border: Border.all(
                      color: MyColors.primary_color,
                    )),
                child: InkWell(
                  onTap: () => {
                    if (item["type"] == "package")
                      {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Products(
                                    group: item,
                                    session_key: getRandString(6))))
                      }
                    else if (item["type"] == "collection")
                      {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductsList(
                                    group: item,
                                    session_key: getRandString(6))))
                      }
                    else
                      {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductsCollection(
                                    group: item,
                                    session_key: getRandString(6))))
                      }
                  },
                  child: Center(
                      child: Text(
                    "${item['name']}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                      color: MyColors.primary_color,
                    ),
                  )),
                ))),
        Container(
          padding: EdgeInsets.only(top: 12),
          child: Center(
              child: Text(
            "R${item['price']}",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: MyColors.primary_color),
          )),
        )
      ],
    );
  }

  String getRandString(int len) {
    var random = Random.secure();
    var values = List<int>.generate(len, (i) => random.nextInt(255));
    return base64UrlEncode(values);
  }
}
