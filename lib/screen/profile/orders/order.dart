import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_groza/lib/fetch.dart';
import 'package:go_groza/screen/cart/billAddress.dart';
import 'file:///C:/Users/user-pc/AndroidStudioProjects/go_groza/lib/screen/tabs/packages/items.dart';
import 'package:go_groza/screen/components/orderItems.dart';
import 'package:go_groza/utils/config.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:flutter_icons/flutter_icons.dart';
import 'package:go_groza/utils/colors.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class Order extends StatelessWidget {
  final order;
  const Order({Key key, this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(order);
    var status = (order["isPaid"] == 1) ? "Complete" : "inComplete";
    return Scaffold(
        bottomNavigationBar: BottomAppBar(
            child: (order["isPaid"] == 0)
                ? buttonPay(order, context)
                : buttonTrack()),
        appBar: AppBar(
          elevation: 1,
          title: Text("${order["SessionCode"]} - " + status),
        ),
        body: Container(
            color: MyColors.backGround,
            child: ListView(children: [
              Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                              left: 16.0, top: 16.0, bottom: 18.0),
                          child: Icon(
                            FontAwesome5Solid.cubes,
                            size: 40,
                            color: MyColors.primary_color,
                          ),
                        ),
                        Container(
                          child: Text(
                            "${order["SessionCode"]}",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          padding: EdgeInsets.only(left: 16.0, bottom: 4.0),
                        ),
                        Container(
                          child: Text(
                            "No. Item : ${order["items"]}",
                            style: TextStyle(fontSize: 18),
                          ),
                          padding: EdgeInsets.only(left: 16.0, bottom: 4.0),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 16.0, bottom: 4.0),
                          child: Text(
                            (order["isPaid"] == 1) ? "Paid" : "Unpaid",
                            style: TextStyle(
                                fontSize: 16,
                                color: (order["isPaid"] == 1)
                                    ? Colors.green
                                    : Colors.red),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 16.0, bottom: 16.0),
                          child: Text(
                            "${order["created_date"]}",
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  )),
              Container(
                  padding: EdgeInsets.all(8.0),
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: productsWidget())
            ])));
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
            ? Text("No Data Found")
            : orderItems(products: orderSnap.data["data"]["items"]);
      },
      future: getProduct(order["SessionCode"]),
    );
  }

  Future getProduct(code_id) async {
    var response = await fetch.get("get-transactions/${code_id}");
    return response;
  }
}

buttonTrack() {
  return Container(
      padding: EdgeInsets.all(24),
      child: ElevatedButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
                      side: BorderSide(color: MyColors.primary_color)))),
          onPressed: () {},
          child: Container(
              padding: EdgeInsets.all(16),
              child: Text(
                "TRACK ORDER COMING SOON",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ))));
}

buttonPay(order, context) {
  return Container(
      padding: EdgeInsets.all(24),
      child: ElevatedButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
                      side: BorderSide(color: MyColors.primary_color)))),
          onPressed: () {
            showShippingTo(
              context,
              order["GroupID"],
            );
          },
          child: Container(
              padding: EdgeInsets.all(16),
              child: Text(
                "PURCHASE - R${order["amount"]}",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ))));
}

showShippingTo(context, id) {
  return showMaterialModalBottomSheet(
    bounce: true,
    duration: Duration(seconds: 1),
    context: context,
    builder: (context) => billAddress(group_id: id),
  );
}
