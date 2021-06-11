import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'file:///C:/Users/user-pc/AndroidStudioProjects/go_groza/lib/screen/tabs/packages/item.dart';
import 'package:go_groza/screen/components/product.dart';
import 'package:go_groza/utils/colors.dart';
import 'package:go_groza/utils/config.dart';
import 'package:go_groza/lib/fetch.dart';

import 'ImageNetwork.dart';

class CartItem extends StatefulWidget {
  final cart;
  final onChange;

  const CartItem({Key key, this.cart, this.onChange}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _cartI(cart, onChange);
  }
}

class _cartI extends State<CartItem> {
  final cart;
  final onChange;

  _cartI(this.cart, this.onChange);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 0,
      color: Colors.white,
      child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                  width: MediaQuery.of(context).size.width * 0.15,
                  padding: EdgeInsets.only(right: 16.0, left: 8.0),
                  child: ImageNetwork(
                      url: config.urlpath + cart["product"]["file_url"])),
              Container(
                width: MediaQuery.of(context).size.width * 0.4,
                padding: EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Text(
                        "${cart["product"]["name"]} - ${cart["product"]["brand"]}",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      padding: EdgeInsets.only(bottom: 2),
                    ),
                    Container(
                      child: Text(
                        "QTY : ${cart["qty"]}",
                        style: TextStyle(fontSize: 12),
                      ),
                      padding: EdgeInsets.only(bottom: 5),
                    ),
                    Container(
                      child: Text(
                        "Price : R${cart["price"]}",
                        style: TextStyle(fontSize: 12),
                      ),
                      padding: EdgeInsets.only(bottom: 5),
                    ),
                  ],
                ),
              ),
              Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    "R${_compute(cart["price"], cart["qty"])}",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  )),
              Container(
                  width: MediaQuery.of(context).size.width * 0.1,
                  padding: EdgeInsets.only(),
                  child: IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        EasyLoading.show(status: 'Removing Item');
                        removeItem(cart["ItemID"]);
                      })),
            ],
          )),
    );
  }

  _compute(price, qty) {
    return price * qty;
  }

  Future removeItem(data) async {
    print('http fetching...');
    var response = await fetch.get("remove-item/" + data);
    EasyLoading.showSuccess(response["message"]);
    onChange();
    return response;
  }
}
