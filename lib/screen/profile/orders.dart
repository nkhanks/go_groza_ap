import 'dart:convert';
import 'dart:io';
import 'package:go_groza/screen/login.dart';
import 'package:go_groza/utils/colors.dart';
import 'package:go_groza/utils/config.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_groza/lib/fetch.dart';
import 'package:go_groza/screen/components/orderCard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Orders extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<Orders> {
  int _selectedIndex = 0;

  bool isLogged = false;
  @override
  void initState() {
    getOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ordersWidget();
  }

  Widget ordersWidget() {
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
          return ListView.builder(
              itemCount: orderSnap.data["data"].length,
              itemBuilder: (context, index) {
                var order = orderSnap.data["data"][index];
                return orderCard(
                  order: order,
                );
              });
        }
      },
      future: getOrders(),
    );
  }

  Future getOrders() async {
    print('http fetching...');
    var response = await fetch.get("my-orders");
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // isLogged = prefs.containsKey("token");
    return response;
  }
}
