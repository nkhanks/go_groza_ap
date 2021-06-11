import 'package:flutter/material.dart';
import 'package:go_groza/utils/colors.dart';

class Search extends StatelessWidget {
  final onChange;

  const Search({Key key, this.onChange}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 45,
        child: TextField(
          autocorrect: false,
          onChanged: (value) {
            onChange(value);
          },
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 24.0),
            hintStyle: TextStyle(
              color: MyColors.primary_color,
            ),
            hintText: 'Search...',
            suffixIcon: Icon(
              Icons.search,
              color: MyColors.primary_color,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(60.0)),
              borderSide: BorderSide(color: MyColors.primary_color),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(60.0)),
              borderSide: BorderSide(color: MyColors.primary_color),
            ),
          ),
        ));
  }
}
