import 'package:flutter/material.dart';

const double kBottomTabBarHeight = 50;

class BottomTabBar extends StatelessWidget {
  BottomTabBar({
    Key key,
    this.itemCount,
    this.itemBuilder,
    this.didSelected,
    this.backgroundColor,
    this.elevation = 0.0,
  }) : super(key: key);

  final int itemCount;
  final Widget Function(int) itemBuilder;

  final Function(int) didSelected;

  final Color backgroundColor;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    List<Widget> items = [];
    for (int i = 0; i < itemCount; i++) {
      items.add(Expanded(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          child: itemBuilder(i),
          onTap: () => didSelected(i),
        ),
      ));
    }
    return Material(
      elevation: elevation,
      color: backgroundColor ?? Theme.of(context).backgroundColor,
      child: SafeArea(
        child: Container(
          height: kBottomTabBarHeight,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: items,
          ),
        ),
      ),
    );
  }
}

// item
class BottomTabBarItem extends StatelessWidget {
  BottomTabBarItem({
    Key key,
    this.icon,
    this.title,
  }) : super(key: key);

  final Widget icon;
  final Widget title;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(width: 25, height: 25, child: icon),
            Padding(padding: EdgeInsets.only(bottom: 1)),
            DefaultTextStyle(child: title, style: TextStyle(fontSize: 13)),
          ],
        ),
      ),
    );
  }
}
