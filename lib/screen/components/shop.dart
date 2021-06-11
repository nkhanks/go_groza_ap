import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:go_groza/screen/components/product.dart';
import 'package:go_groza/screen/profile/edit.dart';
import 'package:go_groza/screen/shops/shopDetail.dart';
import 'package:go_groza/utils/colors.dart';
import 'package:go_groza/utils/config.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'ImageNetwork.dart';

class shop extends StatelessWidget {
  final item;

  const shop({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            width: 70,
            height: 70,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(180.0),
                border: Border.all(
                  color: MyColors.primary_color,
                )),
            child: InkWell(
              onTap: () => {showCategories(context, item)},
              child: ImageNetwork(url: config.urlpath + item["file_url"]),
            )),
        Container(
            padding: EdgeInsets.only(top: 8, left: 4),
            width: 70,
            child: Text(
              item["name"],
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.normal,
                color: MyColors.primary_color,
              ),
            ))
      ],
    );
  }

  showCategories(context, item) {
    return showMaterialModalBottomSheet(
      bounce: true,
      expand: true,
      duration: Duration(seconds: 1),
      context: context,
      builder: (context) => shopDetail(
        shop: item,
      ),
    );
  }
}
