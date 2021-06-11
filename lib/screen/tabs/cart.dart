import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:go_groza/lib/fetch.dart';
import 'package:go_groza/screen/cart/billAddress.dart';
import 'package:go_groza/screen/cart/checkout.dart';
import 'package:go_groza/screen/components/cart.dart';
import 'package:go_groza/screen/components/cartitem.dart';
import 'package:go_groza/utils/colors.dart';
import 'package:go_groza/utils/config.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class Cart extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<Cart> {
  //State class
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, orderSnap) {
        if (!orderSnap.hasData) {
          print('project snapshot data is: ${orderSnap.data}');
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (orderSnap.hasError) {
          print("Error Fetching Order");
          return Center(child: Text("R"));
        }
        var carts = orderSnap.data["data"];
        return Column(children: [
          Container(
              padding: EdgeInsets.only(top: 10),
              height: MediaQuery.of(context).size.height * 0.62,
              child: cartList(carts, () {
                setState(() {});
              })),
          Divider(),
          Container(
              padding: EdgeInsets.only(right: 8),
              height: MediaQuery.of(context).size.height * 0.1,
              child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                      "TOTAL COST : R${orderSnap.data["data"]["total"]}",
                      style: TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold)))),
          Container(
              height: MediaQuery.of(context).size.height * 0.1,
              child: Wrap(children: [
                Container(
                    padding: EdgeInsets.all(4),
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: MyColors.primary_color)),
                        color: MyColors.primary_color,
                        onPressed: () => {empty()},
                        child: Row(children: [
                          Container(
                              padding: EdgeInsets.only(right: 18),
                              child: Icon(
                                FontAwesome5Solid.trash,
                                size: 15,
                                color: Colors.white,
                              )),
                          Text(
                            'CART EMPTY',
                            style: TextStyle(color: Colors.white),
                          )
                        ]))),
                Container(
                    padding: EdgeInsets.all(4),
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: MyColors.primary_color)),
                        color: MyColors.primary_color,
                        onPressed: () => {showShippingTo(context)},
                        child: Row(children: [
                          Container(
                              padding: EdgeInsets.only(right: 24),
                              child: Icon(
                                FontAwesome5Solid.shopping_cart,
                                size: 15,
                                color: Colors.white,
                              )),
                          Text(
                            'CHECKOUT',
                            style: TextStyle(color: Colors.white),
                          )
                        ])))
              ]))
        ]);
      },
      future: getOrders(),
    );
  }

  showShippingTo(context) {
    return showMaterialModalBottomSheet(
      bounce: true,
      duration: Duration(seconds: 1),
      context: context,
      builder: (context) => billAddress(),
    );
  }

  Future empty() async {
    print('http fetching...');
    var response = await fetch.get("empty-cart");

    if (!response["error"]) {
      EasyLoading.showSuccess(response["message"]);
      setState(() {});
    } else {
      EasyLoading.showError(response["message"]);
    }
    return response;
  }
}

Future getOrders() async {
  print('http fetching...');
  var response = await fetch.get("cart");
  return response;
}
