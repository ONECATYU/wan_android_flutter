import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  SearchBar({
    Key key,
    this.backgroundColor,
  }) : super(key: key);

  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.search, color: Colors.grey, size: 21),
          Text("搜索", style: TextStyle(fontSize: 17, color: Colors.grey)),
        ],
      ),
    );
  }
}
