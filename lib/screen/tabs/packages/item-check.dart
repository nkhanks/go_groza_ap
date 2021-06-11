import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:go_groza/screen/components/product.dart';
import 'package:go_groza/utils/colors.dart';
import 'package:go_groza/utils/config.dart';

import '../../components/ImageNetwork.dart';

class itemCheck extends StatelessWidget {
  final product;
  final master;
  const itemCheck({Key key, this.product, this.master}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.black, width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          onTap: () => {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => productDetail(
                          product: product,
                        )))
          },
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding: EdgeInsets.all(12),
                  height: 150,
                  child: Center(
                      child: ImageNetwork(
                          url: config.urlpath + product["file_url"])),
                ),
                Divider(),
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
                Container(
                  padding: EdgeInsets.only(top: 5),
                  child: Text(
                    this.master.group["type"] == "package"
                        ? "${product["points"]}p"
                        : "R ${product["points"]}",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      Positioned(
          top: 10,
          right: 5,
          child: Container(
            child: Checkbox(
              value: master.isCart(product),
              onChanged: (bool value) {
                master.addToCart(product, value);
              },
            ),
          ))
    ]);
  }

  filtre(String str) {
    if (str.length > 14) {
      return str.replaceRange(14, str.length, "") + "...";
    }
    return str;
  }
}
