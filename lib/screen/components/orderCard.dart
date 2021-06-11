import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:go_groza/screen/profile/orders/order.dart';
import 'package:go_groza/utils/colors.dart';

class orderCard extends StatelessWidget {
  final order;

  const orderCard({Key key, this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.all(10),
        elevation: 0,
        color: Colors.white,
        child: InkWell(
          onTap: () => {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Order(
                          order: order,
                        )))
          },
          child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(right: 16.0, left: 8.0),
                    child: Icon(
                      FontAwesome5Solid.cubes,
                      size: 40,
                      color: MyColors.primary_color,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Text(
                            "${order["SessionCode"]}",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          padding: EdgeInsets.only(bottom: 2),
                        ),
                        Container(
                          child: Text(
                            "No. Item : ${order["items"]}",
                            style: TextStyle(fontSize: 12),
                          ),
                          padding: EdgeInsets.only(bottom: 5),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.only(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(bottom: 5),
                            child: Text(
                              (order["isPaid"] == 1) ? "Paid" : "UnPaid",
                              style: TextStyle(
                                  fontSize: 8,
                                  color: (order["isPaid"] == 1)
                                      ? Colors.green
                                      : Colors.red),
                            ),
                          ),
                          Container(
                            child: Text(
                              "${order["created_date"]}",
                              style: TextStyle(fontSize: 8),
                            ),
                          ),
                        ],
                      )),
                ],
              )),
        ));
  }
}
