import 'package:flutter/cupertino.dart';
import 'package:go_groza/screen/components/shop.dart';

import '../tabs/packages/group.dart';

class categoryLists extends StatelessWidget {
  final categories;

  const categoryLists({Key key, this.categories}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      primary: false,
      crossAxisCount: 3,
      childAspectRatio: 0.8,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children: List.generate(categories.length, (index) {
        return group(
          item: categories[index],
        );
      }),
    );
  }
}
