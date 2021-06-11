import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:go_groza/screen/tabs/cart.dart';
import 'package:go_groza/screen/tabs/orders.dart';
import 'package:go_groza/screen/tabs/package.dart';
import 'package:go_groza/screen/tabs/profile.dart';
import 'package:go_groza/screen/tabs/contact.dart';
import 'package:go_groza/screen/tabs/shops.dart';
import 'package:go_groza/utils/colors.dart';
import 'package:permission_handler/permission_handler.dart';

class Home extends StatefulWidget {
  int page;
  Home(this.page);
  @override
  State<StatefulWidget> createState() {
    return _MyAppState(this.page);
  }
}

class _MyAppState extends State<Home> {
  //State class
  int _page = 0;
  _MyAppState(this._page);
  GlobalKey _bottomNavigationKey = GlobalKey();

  @override
  void initState() {
    permissionRequest();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.transparent,
          color: MyColors.primary_color,
          key: _bottomNavigationKey,
          index: _page,
          items: <Widget>[
            Icon(
              Icons.account_circle,
              size: 20,
              color: Colors.white,
            ),
            Icon(
              FontAwesome5Solid.shopping_bag,
              size: 20,
              color: Colors.white,
            ),
            Icon(
              Icons.phone,
              size: 20,
              color: Colors.white,
            ),
          ],
          onTap: (index) {
            setState(() {
              _page = index;
            });
          },
        ),
        body: _getPage(_page));
  }

  _getPage(index) {
    switch (index) {
      case 0:
        return Profile();
      case 1:
        return Package();
      case 2:
        return Contact();
      default:
        return Profile();
    }
  }

  permissionRequest() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.unknown,
    ].request();
  }
}
