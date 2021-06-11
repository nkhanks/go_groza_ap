import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:go_groza/screen/components/search.dart';
import 'package:go_groza/utils/colors.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:go_groza/lib/fetch.dart';

import 'add-item.dart';
import 'item.dart';
import 'itemOther.dart';

class openItems extends StatelessWidget {
  final group_id;
  final items;
  final search;
  final master;
  final points_left;
  const openItems(
      {Key key,
      this.group_id,
      this.items,
      this.search,
      this.master,
      this.points_left})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Container(
          padding: EdgeInsets.only(top: 85, bottom: 25),
          child: ListView(children: [
            Center(
              child: Text("Select Product Or Hold and Scroll Down To Close"),
            ),
            Container(child: productsWidget()),
          ])),
      Positioned(
          top: 50,
          left: MediaQuery.of(context).size.width * 0.05,
          right: MediaQuery.of(context).size.width * 0.05,
          child: Center(
              child: Container(
                  color: Colors.white,
                  height: 65,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Search(
                      onChange: (String value) => {master.setSearch(value)})))),
    ]);
  }

  Widget productsWidget() {
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
        }

        var filterData = orderSnap.data["data"].where((element) {
          for (var item in items) {
            if (item["code"] == element["code"]) {
              return false;
            }
          }
          if (search == "all" || search.isEmpty) {
            return true;
          }
          return element["name"].toLowerCase().contains(search.toLowerCase()) ||
              element["brand"].toLowerCase().contains(search.toLowerCase());
        });

        return (orderSnap.data["error"])
            ? Text("No Data Found")
            : Padding(
                padding: EdgeInsets.all(16),
                child: ResponsiveGridRow(
                    rowSegments: 12, children: itemList(filterData)));
      },
      future: getProduct(group_id, search),
    );
  }

  List<ResponsiveGridCol> itemList(products) {
    var list = List<ResponsiveGridCol>();
    products.forEach((product) => {
          list.add(ResponsiveGridCol(
              lg: 4,
              xs: 6,
              md: 3,
              child: Container(
                  alignment: Alignment(0, 0),
                  margin: EdgeInsets.only(bottom: 16),
                  child: itemOther(
                    master: master,
                    isAddable: points_left >= product["points"] ||
                        master.group["type"] == "collection",
                    product: product,
                  )))),
        });
    return list;
  }

  Future getProduct(code_id, search) async {
    print('http fetching...');
    var response = await fetch.get("api/products-group/${code_id}");
    return response;
  }
}
