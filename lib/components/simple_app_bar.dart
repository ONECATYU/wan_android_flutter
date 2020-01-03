import 'package:flutter/material.dart';

const double kSimpleAppBarHeight = 50;

class SimpleAppBar extends StatelessWidget implements PreferredSizeWidget {
  SimpleAppBar({
    Key key,
    this.child,
    this.bottom,
    this.elevation = 0.0,
    this.backgroundColor,
  })  : preferredSize = Size.fromHeight(
            kSimpleAppBarHeight + (bottom?.preferredSize?.height ?? 0.0)),
        super(key: key);

  final Widget child;
  final PreferredSizeWidget bottom;

  final double elevation;
  final Color backgroundColor;

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    Widget content;
    if (child != null) {
      content = Padding(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: child,
      );
    }
    if (bottom != null) {
      content = content != null
          ? Column(
              children: <Widget>[
                content,
                bottom,
              ],
            )
          : bottom;
    }
    return Material(
      elevation: elevation,
      color: backgroundColor,
      child: SafeArea(
        child: Container(
          constraints: BoxConstraints(minHeight: kSimpleAppBarHeight),
          child: content,
        ),
      ),
    );
  }
}
