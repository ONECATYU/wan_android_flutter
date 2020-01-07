import 'package:flutter/material.dart';

class CateCard extends StatelessWidget {
  CateCard({
    Key key,
    this.title,
    this.labels,
    this.labelsOnTap,
  }) : super(key: key);

  final String title;
  final List<String> labels;

  final Function(int) labelsOnTap;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    List<Widget> labelsWidgets = [];
    if (labels != null && labels.length > 0) {
      labelsWidgets = labels.map((str) {
        int index = labels.indexOf(str);
        return InkWell(
          child: Container(
            color: themeData.scaffoldBackgroundColor,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            child: Text(str),
          ),
          onTap: () => labelsOnTap(index),
        );
      }).toList();
    }
    return Container(
      color: themeData.backgroundColor,
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, style: themeData.textTheme.title),
          Padding(padding: EdgeInsets.only(bottom: 12)),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: labelsWidgets,
          ),
        ],
      ),
    );
  }
}
