import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:go_groza/screen/components/product.dart';
import 'package:go_groza/utils/colors.dart';
import 'package:go_groza/utils/config.dart';

import '../../components/ImageNetwork.dart';

class addItem extends StatelessWidget {
  final master;

  const addItem({Key key, this.master}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(8),
        child: DottedBorder(
            color: Colors.grey,
            strokeWidth: 1.5,
            borderType: BorderType.RRect,
            radius: Radius.circular(12),
            padding: EdgeInsets.all(8),
            child: Container(
                height: 225,
                child: InkWell(
                    onTap: () => {master.showAddable()},
                    child: Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add,
                          color: Colors.grey,
                          size: 48,
                        ),
                        Padding(padding: EdgeInsets.all(4)),
                        Text(
                          "Add Product",
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    ))))));
  }
}
