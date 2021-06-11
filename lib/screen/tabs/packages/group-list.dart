import 'package:flutter/cupertino.dart';
import 'package:go_groza/screen/components/categories.dart';
import 'package:go_groza/screen/components/shop.dart';
import 'package:go_groza/lib/fetch.dart';
import 'group.dart';

class groupList extends StatelessWidget {
  final packages;

  const groupList({Key key, this.packages}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      primary: false,
      crossAxisCount: 4,
      childAspectRatio: 3 / 4,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children: List.generate(packages.length, (index) {
        return group(
          item: packages[index],
        );
      }),
    );
  }

  Future getShops() async {
    print('http fetching...');

    var response = await fetch.get("api/groups");
    return response;
  }
}
