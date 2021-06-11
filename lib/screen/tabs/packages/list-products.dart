import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:go_groza/lib/fetch.dart';
import 'package:go_groza/screen/cart/billAddress.dart';
import 'package:go_groza/screen/components/search.dart';
import 'package:go_groza/screen/tabs/packages/items.dart';
import 'package:go_groza/utils/colors.dart';
import 'package:go_groza/utils/config.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'file:///C:/Users/user-pc/AndroidStudioProjects/go_groza/lib/screen/tabs/packages/item.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'open-items.dart';

class ProductsList extends StatefulWidget {
  final group;
  final session_key;

  const ProductsList({
    Key key,
    this.group,
    this.session_key,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _MyAppState(group, session_key);
  }
}

class _MyAppState extends State<ProductsList> {
  var group;
  var points = -1;
  var session_key;
  var productList;
  var cart = [];
  String search = "all";
  _MyAppState(this.group, this.session_key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomAppBar(
            child: Container(
                padding: EdgeInsets.all(24),
                child: ElevatedButton(
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ))),
                    onPressed: points >= this.group["max_points"]
                        ? () {
                            showShippingTo(context);
                          }
                        : null,
                    child: Container(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          "CHECKOUT- R${group["price"] + points}",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ))))),
        body: Container(
            padding: EdgeInsets.all(4),
            color: MyColors.backGround,
            child: Stack(children: <Widget>[
              ListView(children: [
                Container(
                    padding: EdgeInsets.only(top: 98, bottom: 25),
                    child: productsWidget()),
              ]),
              Positioned(
                  top: MediaQuery.of(context).size.height * 0.052,
                  left: MediaQuery.of(context).size.width * 0.05,
                  right: MediaQuery.of(context).size.width * 0.05,
                  child: Container(
                    height: 65,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(80.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5), //color of shadow
                          spreadRadius: 1, //spread radius
                          blurRadius: 7, // blur radius
                          offset: Offset(0, 2), // changes position of shadow
                          //first paramerter of offset is left-right
                          //second parameter is top to down
                        ),
                        //you can set more BoxShadow() here
                      ],
                    ),
                    width: MediaQuery.of(context).size.width * 0.9,
                  )),
              Positioned(
                  top: MediaQuery.of(context).size.height * 0.06,
                  left: MediaQuery.of(context).size.width * 0.1,
                  child: Container(
                      height: 50,
                      padding: EdgeInsets.only(left: 10),
                      alignment: Alignment(0, 0),
                      child: Text(
                        "Delivery Fee R ${group["price"]}",
                        style: TextStyle(fontSize: 19),
                      ))),
              Positioned(
                  top: MediaQuery.of(context).size.height * 0.06,
                  right: MediaQuery.of(context).size.width * 0.075,
                  child: InkWell(
                      onTap: () => {Navigator.pop(context)},
                      child: Container(
                        height: 50,
                        width: 50,
                        alignment: Alignment(0, 0),
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 24,
                        ),
                        decoration: BoxDecoration(
                          color: MyColors.primary_color,
                          shape: BoxShape.circle,
                        ),
                      ))),
            ])));
  }

  showShippingTo(context) {
    return showMaterialModalBottomSheet(
      bounce: true,
      duration: Duration(seconds: 1),
      context: context,
      builder: (context) =>
          billAddress(group_id: group["GroupID"], session: session_key),
    );
  }

  showProducts(context) {
    return showMaterialModalBottomSheet(
      bounce: true,
      duration: Duration(seconds: 1),
      context: context,
      builder: (context) => openItems(group_id: group["GroupID"], items: items),
    );
  }

  setSearch(value) {
    search = value;
    refresh();
  }

  getTotal() {
    var total = 0;
    for (var item in cart) {
      total += item["points"];
    }
    return total;
  }

  addToCart(product, isTrue) async {
    if (isTrue) {
      await this.addItem(product["ProductID"], product["code"],
          product["GroupID"], product["points"]);
      refresh();
      return;
    } else {
      await this.removeItem(product);
      refresh();
      return;
    }
  }

  isCart(value) {
    for (var item in cart) {
      if (item["code"] == value["code"]) {
        return true;
      }
    }
    return false;
  }

  showAddable() {
    search = "all";
    return showMaterialModalBottomSheet(
      bounce: true,
      duration: Duration(milliseconds: 700),
      context: context,
      builder: (context) => openItems(
          group_id: group["GroupID"],
          items: productList,
          search: search,
          points_left: group["max_points"] - points,
          master: this),
    );
  }

  addProduct() {}

  refresh() {
    setState(() {});
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
        } else {
          points = 0;
          orderSnap.data["data"]["cart"]["items"]
              .forEach((k) => points += k["points"]);
          print(points);
          cart = orderSnap.data["data"]["cart"]["items"];
          productList = orderSnap.data["data"]["products"];
        }

        return (orderSnap.data["error"])
            ? Text("No Data Found")
            : items(
                products: orderSnap.data["data"]["products"],
                isPause: points >= group["max_points"],
                master: this);
      },
      future: getProduct(group["GroupID"], session_key),
    );
  }

  Future getProduct(code_id, session_key) async {
    print('http fetching...');
    var response =
        await fetch.get("api/products-group-code/${code_id}/" + session_key);

    if (points == -1) {
      points = 0;
      response["data"]["cart"]["items"].forEach((k) => points += k["points"]);
      print(points);
      refresh();
    }
    return response;
  }

  addItem(product_id, code, group_id, add_points) async {
    print(code);
    await fetch.post("api/add-group-product/" + session_key, {
      "product_id": "${product_id}",
      "code": "${code}",
      "group_id": "${group_id}"
    });

    points += add_points;
    refresh();
  }

  removeItem(item) async {
    if (item["isPreset"] != "preset-not-removable") {
      print(item["code"]);
      await fetch.post("api/remove-group-product/" + session_key, {
        "product_id": "${item["ProductID"]}",
        "code": "${item["code"]}",
        "group_id": "${item["GroupID"]}"
      });
    }

    points -= item["points"];
    refresh();
  }
}
