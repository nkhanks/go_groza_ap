import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_groza/lib/fetch.dart';
import 'file:///C:/Users/user-pc/AndroidStudioProjects/go_groza/lib/screen/tabs/packages/items.dart';
import 'package:go_groza/utils/config.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'file:///C:/Users/user-pc/AndroidStudioProjects/go_groza/lib/screen/tabs/packages/item.dart';

class Favourite extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<Favourite> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return productsWidget();
  }

  Widget productsWidget() {
    return FutureBuilder(
      builder: (context, orderSnap) {
        if (!orderSnap.hasData) {
          print('project snapshot data is: ${orderSnap.data}');
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (orderSnap.hasError) {
          print("Error Fetching Order");
          return Center(child: Text("Error Fetching Orders"));
        }

        return (orderSnap.data["error"])
            ? Text("No DAta Found")
            : items(products: orderSnap.data);
      },
      future: getProduct("ut"),
    );
  }

  Future getProduct(code_id) async {
    print('http fetching...');
    var response = await fetch.get("order-products/${code_id}");
    return response;
  }
}
