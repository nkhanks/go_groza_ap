import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_groza/screen/profile/edit.dart';
import 'package:go_groza/screen/profile/favourite.dart';
import 'package:go_groza/screen/profile/orders.dart';
import 'package:go_groza/screen/profile/support.dart';
import 'package:go_groza/screen/profile/tac.dart';
import 'package:go_groza/utils/colors.dart';

class Profile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<Profile> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: MyColors.backGround,
        child: Row(
          children: <Widget>[
            NavigationRail(
              minWidth: 55.0,
              groupAlignment: 0.0,
              backgroundColor: Colors.transparent,
              selectedIndex: _selectedIndex,
              onDestinationSelected: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              labelType: NavigationRailLabelType.all,
              selectedLabelTextStyle: TextStyle(
                color: MyColors.primary_color,
                fontSize: 14,
                letterSpacing: 1,
                decorationThickness: 2.0,
              ),
              unselectedLabelTextStyle: TextStyle(
                fontSize: 13,
                letterSpacing: 0.8,
              ),
              destinations: [
                textDestination("My Orders"),
                textDestination("About Us"),
              ],
            ),
            Flexible(
                child: Container(
              child: _getPage(_selectedIndex),
              padding: EdgeInsets.all(5.0),
            ))
          ],
        ));
  }

  NavigationRailDestination textDestination(
    String text,
  ) {
    return NavigationRailDestination(
      icon: SizedBox.shrink(),
      label: Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: RotatedBox(
          quarterTurns: -1,
          child: Text(text),
        ),
      ),
    );
  }

  _getPage(index) {
    switch (index) {
      case 0:
        return Orders();
      case 1:
        return Support();

      default:
        return Orders();
    }
  }
}
