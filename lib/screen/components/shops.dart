import 'package:flutter/cupertino.dart';
import 'package:go_groza/screen/components/shop.dart';

class shopLists extends StatelessWidget {
  final shops;

  const shopLists({Key key, this.shops}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      primary: false,
      crossAxisCount: 4,
      childAspectRatio: 0.8,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children: List.generate(shops.length, (index) {
        return shop(
          item: shops[index],
        );
      }),
    );
  }
}
