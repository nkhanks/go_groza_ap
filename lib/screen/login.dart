import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:go_groza/utils/colors.dart';

import 'otp.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<Login> {
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
                  padding: EdgeInsets.only(left: 36, right: 36),
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: Center(
                    child: Image.asset("assets/img/logo.png"),
                  )),
              Container(
                padding: EdgeInsets.all(16),
                height: MediaQuery.of(context).size.height * 0.1,
                child: Center(
                  child: Text(
                    "Just Access No Need To Register",
                    style:
                        TextStyle(fontSize: 18, color: MyColors.primary_color),
                  ),
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
                    hintText: 'Email',
                    prefixIcon: Icon(
                      Icons.email,
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
                          width: MediaQuery.of(context).size.width * 0.25),
                      Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          padding: EdgeInsets.all(4),
                          child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(
                                      color: MyColors.primary_color)),
                              color: MyColors.primary_color,
                              onPressed: () => {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => OTP()))
                                  },
                              child: Text(
                                'LOGIN',
                                style: TextStyle(color: Colors.white),
                              ))),
                      Container(
                          width: MediaQuery.of(context).size.width * 0.25),
                    ],
                  )),
            ])));
  }
}
