import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:go_groza/screen/tabs/packages/item-check.dart';
import 'package:go_groza/utils/colors.dart';
import 'package:responsive_grid/responsive_grid.dart';

import 'add-item.dart';
import 'item.dart';

class items extends StatelessWidget {
  final products;
  final isPause;
  final master;
  const items({Key key, this.products, this.isPause, this.master})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveGridRow(rowSegments: 12, children: itemList());
  }

  List<ResponsiveGridCol> itemList() {
    var list = List<ResponsiveGridCol>();
    products.forEach((product) => {
          list.add(ResponsiveGridCol(
              lg: 4,
              xs: 6,
              md: 3,
              child: Container(
                  alignment: Alignment(0, 0),
                  margin: EdgeInsets.only(bottom: 16),
                  child: this.master.group["type"] != "collection"
                      ? item(product: product, master: master)
                      : itemCheck(product: product, master: master)))),
        });
    if ((!isPause || this.master.group["type"] == "list") &&
        this.master.group["type"] != "collection") {
      list.add(ResponsiveGridCol(
          lg: 4, xs: 6, md: 3, child: addItem(master: master)));
    } else if (this.master.group["type"] == "collection") {}
    return list;
  }
}
