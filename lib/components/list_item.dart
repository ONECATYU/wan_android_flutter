import 'package:flutter/material.dart';

enum TrailingType {
  none,
  nextIndicator,
}

class ListItem extends StatelessWidget {
  ListItem({
    Key key,
    this.leading,
    this.title,
    this.subTitle,
    this.trailingType = TrailingType.none,
    this.trailing,
    this.onTap,
    this.backgroundColor,
  }) : super(key: key);

  final Widget leading;
  final Widget title;
  final Widget subTitle;

  final TrailingType trailingType;
  final Widget trailing;

  final VoidCallback onTap;

  final Color backgroundColor;

  Widget _buildItem({Widget left, Widget right}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        if (left != null)
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: left,
          ),
        if (right != null) right,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget _title = title, _subTitle = subTitle, _trailing = trailing;
    if (title != null) {
      _title = DefaultTextStyle(
        style: Theme.of(context).textTheme.subhead,
        child: title,
      );
    }
    if (subTitle != null) {
      _subTitle = DefaultTextStyle(
        style: Theme.of(context).textTheme.subtitle,
        child: subTitle,
      );
    }
    if (trailingType == TrailingType.nextIndicator) {
      _trailing = Icon(
        Icons.navigate_next,
        color: Theme.of(context).textTheme.subtitle.color,
        size: 30,
      );
    }
    Widget widget = Container(
      color: backgroundColor ?? Theme.of(context).backgroundColor,
      constraints: BoxConstraints(
        minHeight: 50,
      ),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _buildItem(left: leading, right: _title),
          _buildItem(left: _subTitle, right: _trailing),
        ],
      ),
    );
    if (onTap != null) {
      widget = InkWell(
        onTap: onTap,
        child: widget,
      );
    }
    return widget;
  }
}
