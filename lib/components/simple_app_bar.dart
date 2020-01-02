import 'package:flutter/material.dart';

const double kSimpleAppBarHeight = 50;

class SimpleAppBar extends StatelessWidget implements PreferredSizeWidget {
  SimpleAppBar({
    Key key,
    this.child,
    this.elevation = 0.0,
    this.backgroundColor,
  }) : super(key: key);

  final Widget child;

  final double elevation;
  final Color backgroundColor;

  @override
  Size get preferredSize => Size.fromHeight(kSimpleAppBarHeight);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: elevation,
      color: backgroundColor,
      child: SafeArea(
        child: Container(
          height: kSimpleAppBarHeight,
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: child,
        ),
      ),
    );
  }
}
