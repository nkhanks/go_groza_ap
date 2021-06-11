import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:go_groza/utils/colors.dart';

import '../tabs/packages/item.dart';
import 'orderItem.dart';

class orderItems extends StatelessWidget {
  final products;

  const orderItems({Key key, this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Table(
        border: TableBorder.all(),
        columnWidths: const <int, TableColumnWidth>{
          0: IntrinsicColumnWidth(),
          1: FlexColumnWidth(),
          2: FixedColumnWidth(64),
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: itemList());
  }

  List<TableRow> itemList() {
    var list = List<TableRow>();

    list.add(TableRow(children: <Widget>[
      TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Container(
              color: MyColors.primary_color,
              padding: EdgeInsets.all(8),
              child: Text("Product Name"))),
      TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Container(
              color: MyColors.primary_color,
              padding: EdgeInsets.all(8),
              child: Text("Description"))),
    ]));

    products.forEach((product) => {
          list.add(TableRow(children: <Widget>[
            TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: Container(
                    padding: EdgeInsets.all(16), child: Text(product["name"]))),
            TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: Container(
                    padding: EdgeInsets.all(16),
                    child: Text(product["description"])))
          ]))
        });
    return list;
  }
}
