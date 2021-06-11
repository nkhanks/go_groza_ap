import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:go_groza/screen/components/product.dart';
import 'package:go_groza/utils/colors.dart';
import 'package:go_groza/utils/config.dart';

import '../../components/ImageNetwork.dart';

class itemOther extends StatelessWidget {
  final product;
  final isAddable;
  final master;
  const itemOther({
    Key key,
    this.product,
    this.master,
    this.isAddable,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
        opacity: isAddable ? 1.0 : 0.4,
        child: Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                  color: isAddable ? Colors.black : Colors.grey, width: 1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: InkWell(
                onTap: () => {
                      if (isAddable)
                        {
                          master.addItem(product["ProductID"], product["code"],
                              product["GroupID"], product["points"])
                        }
                    },
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        padding: EdgeInsets.all(12),
                        height: 150,
                        child: Center(
                            child: ImageNetwork(
                                url: config.urlpath + product["file_url"])),
                      ),
                      Divider(),
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          filtre(product["name"]),
                          style: TextStyle(
                              fontSize: 16,
                              color: isAddable ? Colors.black : Colors.grey,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 5),
                        child: Text(
                          product["brand"],
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 5),
                        child: Text(
                          "${product["points"]}p",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color:
                                isAddable ? MyColors.primary_color : Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                ))));
  }

  filtre(String str) {
    if (str.length > 14) {
      return str.replaceRange(14, str.length, "") + "...";
    }
    return str;
  }
}
