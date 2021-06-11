import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:go_groza/screen/splash.dart';
import 'package:go_groza/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';
import 'login.dart';

class OTP extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<OTP> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: MyColors.backGround,
            child: ListView(children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.1,
                child: Center(
                  child: Column(children: [
                    Text("Please Enter OTP ",
                        style: TextStyle(
                            fontSize: 18, color: MyColors.primary_color)),
                    Text("(Was Sent To Your Email Address)",
                        style: TextStyle(
                            fontSize: 12, color: MyColors.primary_color)),
                  ]),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 36, right: 36, top: 8),
                child: TextField(
                  autocorrect: false,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 24.0),
                    hintStyle: TextStyle(
                      color: MyColors.primary_color,
                    ),
                    hintText: 'OTP',
                    prefixIcon: Icon(
                      Icons.security,
                      color: MyColors.primary_color,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(60.0)),
                      borderSide: BorderSide(color: MyColors.primary_color),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(60.0)),
                      borderSide: BorderSide(color: MyColors.primary_color),
                    ),
                  ),
                ),
              ),
              Container(
                  padding: EdgeInsets.only(top: 24),
                  child: Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.05,
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          padding: EdgeInsets.all(8),
                          child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(color: Colors.red)),
                              color: Colors.red,
                              onPressed: () => {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Login()))
                                  },
                              child: Text(
                                'Wrong Email',
                                style: TextStyle(color: Colors.white),
                              ))),
                      Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          padding: EdgeInsets.all(8),
                          child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(
                                      color: MyColors.primary_color)),
                              color: MyColors.primary_color,
                              onPressed: () async =>
                                  {await createSession(context)},
                              child: Text(
                                'Access GO GOZA',
                                style: TextStyle(color: Colors.white),
                              ))),
                    ],
                  )),
            ])));
  }

  Future createSession(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("token", "trtrgerger");
    Navigator.push(context, MaterialPageRoute(builder: (context) => Splash()));
  }
}
