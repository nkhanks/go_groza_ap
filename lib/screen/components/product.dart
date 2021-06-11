import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:go_groza/lib/fetch.dart';
import 'package:go_groza/utils/colors.dart';
import 'package:go_groza/utils/config.dart';

import '../home.dart';
import 'ImageNetwork.dart';

class productDetail extends StatefulWidget {
  final product;

  const productDetail({Key key, this.product}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _product(product);
  }
}

class _product extends State<productDetail> {
  final product;

  _product(this.product);
  var qty = 1;
  var image;

  @override
  void initState() {
    image = config.urlpath + product["file_url"];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColors.backGround,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: MyColors.backGround,
        ),
        body: SafeArea(
            child: Padding(
                padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                child: ListView(children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 16),
                    width: 250,
                    height: 280,
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          /*   Center(
                              child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.20,
                                  margin: EdgeInsets.only(right: 25, top: 16),
                                  child: Column(children: getGallery()))),*/
                          Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              padding: EdgeInsets.all(8),
                              child: Center(child: ImageNetwork(url: image))),
                        ]),
                  ),
                  Divider(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          padding: EdgeInsets.only(top: 16),
                          child: Text(
                            product["name"],
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          )),
                      Container(child: Text(product["brand"])),
                      Divider(),
                      Container(
                          padding: EdgeInsets.only(top: 16),
                          child: Text(
                            "Description",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          )),
                      Divider(),
                      Container(
                          padding: EdgeInsets.only(top: 16),
                          child: Text(
                            "${product["description"]}",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.normal),
                          )),
                    ],
                  )
                ]))));
  }

  Future addItem(data) async {
    print('http fetching...');
    var response = await fetch.post("add-item", data);
    EasyLoading.showSuccess(response["message"]);
    if (!response["error"]) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home(2)));
    }
    return response;
  }

  getGallery() {
    List gallery = List<Widget>();

    var con = InkWell(
        onTap: () {
          image = config.urlpath + product["file_url"];
          setState(() {});
        },
        child: Container(
          margin: EdgeInsets.only(bottom: 10),
          height: 70,
          child: Padding(
              padding: EdgeInsets.all(2),
              child: ImageNetwork(url: config.urlpath + product["file_url"])),
        ));

    gallery.add(con);
    /*for (int i = 0; i < product["gallery"].length; i++) {
      if (i <= 2) {
        con = InkWell(
            onTap: () {
              image = config.urlpath + product["gallery"][i]["file_url"];
              setState(() {});
            },
            child: Container(
              margin: EdgeInsets.only(bottom: 10),
              height: 70,
              child: ImageNetwork(
                  url: config.urlpath + product["gallery"][i]["file_url"]),
            ));

        gallery.add(con);
      }
    }*/

    return gallery;
  }
}
