import 'dart:convert';
import 'package:go_groza/screen/components/cartitem.dart';
import 'package:go_groza/utils/config.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_groza/lib/fetch.dart';
import 'package:go_groza/screen/components/orderCard.dart';

class cartList extends StatelessWidget {
  int _selectedIndex = 0;
  final cart;
  final onChange;

  cartList(this.cart, this.onChange);
  @override
  Widget build(BuildContext context) {
    return ordersWidget();
  }

  Widget ordersWidget() {
    return ListView.builder(
        itemCount: cart['items'].length,
        itemBuilder: (context, index) {
          return CartItem(
              cart: cart['items'][index],
              onChange: () {
                onChange();
              });
        });
  }
}
