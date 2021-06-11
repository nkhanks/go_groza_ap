import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:go_groza/lib/fetch.dart';
import 'package:go_groza/screen/cart/checkout.dart';
import 'package:go_groza/utils/colors.dart';
import 'dart:convert' as convert;
import 'package:go_groza/utils/config.dart';
import 'package:http/http.dart' as http;

class billAddress extends StatefulWidget {
  final group_id;
  final session;
  const billAddress({Key key, this.group_id, this.session}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _MyAppState(group_id, session);
  }
}

class _MyAppState extends State<billAddress> {
  bool isSwitched = false;
  final group_id;
  final session;
  var data = {
    "package_id": "",
    "firstName": "",
    "lastName": "",
    "email": "",
    "cell": "",
    "address": "",
  };

  _MyAppState(this.group_id, this.session);

  @override
  void initState() {
    data["group_id"] = "${group_id}";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: FutureBuilder(
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

        data["firstName"] = data["firstName"].isEmpty
            ? orderSnap.data["data"]["firstName"]
            : data["firstName"];
        data["lastName"] = data["lastName"].isEmpty
            ? orderSnap.data["data"]["lastName"]
            : data["lastName"];
        data["email"] = data["email"].isEmpty
            ? orderSnap.data["data"]["email"]
            : data["email"];
        data["cell"] = data["cell"].isEmpty
            ? orderSnap.data["data"]["cell"]
            : data["cell"];
        data["address"] = data["address"].isEmpty
            ? orderSnap.data["data"]["address"]
            : data["address"];

        print("Checking");
        print(orderSnap.data["data"]);
        return Container(
            padding: EdgeInsets.all(16),
            child: ListView(
              children: [
                Container(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        padding: EdgeInsets.only(right: 16),
                        child: Text(
                          "Bill To ",
                          style: TextStyle(fontSize: 24),
                        )),
                  ],
                )),
                SizedBox(height: 10),
                TextField(
                  controller: TextEditingController()..text = data["firstName"],
                  onChanged: (value) {
                    data["firstName"] = value;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'First Name',
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: TextEditingController()..text = data["lastName"],
                  onChanged: (value) {
                    data["lastName"] = value;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Last Name',
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: TextEditingController()..text = data["email"],
                  onChanged: (value) {
                    data["email"] = value;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email Address',
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: TextEditingController()..text = data["cell"],
                  onChanged: (value) {
                    data["cell"] = value;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Cell Number',
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: TextEditingController()..text = data["address"],
                  onChanged: (value) {
                    data["address"] = value;
                  },
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Delivery Address',
                  ),
                ),
                SizedBox(height: 20),
                Row(children: [
                  Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: RaisedButton(
                          color: Colors.redAccent,
                          onPressed: () => {Navigator.of(context).pop()},
                          child: Container(
                              padding: EdgeInsets.all(16),
                              child: Text(
                                'Close',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              )))),
                  SizedBox(width: 20),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: RaisedButton(
                          color: MyColors.primary_color,
                          onPressed: () => {addBill(data)},
                          child: Container(
                              padding: EdgeInsets.all(16),
                              child: Text(
                                'Checkout',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ))))
                ])
              ],
            ));
      },
      future: getAddress(),
    ));
  }

  Future addBill(data) async {
    print('http fetching...');

    await fetch.post("empty-cart", {});
    await fetch.post(
        "add-group-item", {"code": "${session}", "group_id": "${group_id}"});
    var response = await fetch.post("bill-to", data);

    if (!response["error"]) {
      EasyLoading.showSuccess(response["message"]);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => checkout()));
    } else {
      EasyLoading.showError(response["message"]);
    }
    return response;
  }

  Future getAddress() async {
    print('http fetching...');
    var response = await fetch.get("get-address");

    return response;
  }
}
