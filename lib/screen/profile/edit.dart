import 'dart:convert' as convert;
import 'package:go_groza/lib/fetch.dart';
import 'package:go_groza/utils/colors.dart';
import 'package:go_groza/utils/config.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../login.dart';

class Edit extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<Edit> {
  int _selectedIndex = 0;

  bool isLogged = false;

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
          return Center(child: Text("Error Fetching Orders"));
        } else if (isLogged) {
          var user = orderSnap.data["data"];
          return Container(
              child: ListView(
            children: [
              Padding(padding: EdgeInsets.all(8)),
              Icon(Icons.account_circle, size: 40),
              Padding(padding: EdgeInsets.all(8)),
              Card(
                  elevation: 0,
                  child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Wrap(
                        direction: Axis.vertical,
                        alignment: WrapAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Container(
                                  padding: EdgeInsets.only(right: 16),
                                  child: Text(
                                    "Name And Identity",
                                    style: TextStyle(fontSize: 18),
                                  )),
                              Icon(Icons.edit,
                                  size: 20, color: MyColors.primary_color),
                            ],
                          ),
                          Padding(padding: EdgeInsets.all(8)),
                          Container(
                            child: Wrap(
                              spacing: 8.0,
                              runSpacing: 2.0,
                              direction: Axis.vertical,
                              children: [
                                Text("First Name : ${user['first_name']}"),
                                Text("Last Name : ${user['last_name']}"),
                                Text("Date Of Birth : ${user['birth']}")
                              ],
                            ),
                          )
                        ],
                      ))),
              Padding(padding: EdgeInsets.all(8)),
              Card(
                  elevation: 0,
                  child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Wrap(
                        direction: Axis.vertical,
                        alignment: WrapAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Container(
                                  padding: EdgeInsets.only(right: 16),
                                  child: Text(
                                    "Contact Details",
                                    style: TextStyle(fontSize: 18),
                                  )),
                              Icon(Icons.edit,
                                  size: 20, color: MyColors.primary_color),
                            ],
                          ),
                          Padding(padding: EdgeInsets.all(8)),
                          Container(
                            child: Wrap(
                              spacing: 8.0,
                              runSpacing: 2.0,
                              direction: Axis.vertical,
                              children: [
                                Text("Phone : ${user['phone_no']}"),
                                Text("WhatsApp : ${user['whatsapp_no']}"),
                                Text("Email : ${user['email']}")
                              ],
                            ),
                          )
                        ],
                      ))),
              Padding(padding: EdgeInsets.all(8)),
              Card(
                  elevation: 0,
                  child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Wrap(
                        direction: Axis.vertical,
                        alignment: WrapAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Container(
                                  padding: EdgeInsets.only(right: 16),
                                  child: Text(
                                    "Address",
                                    style: TextStyle(fontSize: 18),
                                  )),
                              Icon(Icons.edit,
                                  size: 20, color: MyColors.primary_color),
                            ],
                          ),
                          Padding(padding: EdgeInsets.all(8)),
                          Container(
                            child: Wrap(
                              spacing: 8.0,
                              runSpacing: 2.0,
                              direction: Axis.vertical,
                              children: [
                                Text(
                                  "Physical Address",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text("${user['physical']}"),
                                Text(
                                  "Postal Address",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text("${user['postal']}"),
                              ],
                            ),
                          )
                        ],
                      ))),
            ],
          ));
        } else {
          return Center(
              child: Column(children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
            ),
            Text("Please Login To View Your Profile",
                style: TextStyle(fontSize: 14, color: MyColors.primary_color)),
            Container(
                width: MediaQuery.of(context).size.width * 0.5,
                padding: EdgeInsets.all(4),
                child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: MyColors.primary_color)),
                    color: MyColors.primary_color,
                    onPressed: () => {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Login()))
                        },
                    child: Text(
                      'LOGIN',
                      style: TextStyle(color: Colors.white),
                    )))
          ]));
        }
      },
      future: getOrders(),
    );
  }

  Future getOrders() async {
    print('http fetching...');
    var response = await fetch.get("user-data");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLogged = prefs.containsKey("token");
    return response;
  }
}
