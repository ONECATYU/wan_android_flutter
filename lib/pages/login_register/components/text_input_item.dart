import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextInputItem extends StatelessWidget {
  TextInputItem({
    Key key,
    this.leading,
    this.trailing,
    this.placeholder,
    this.backgroundColor,
    this.border,
    this.onChanged,
    this.controller,
    this.focusNode,
    this.obscureText = false,
  }) : super(key: key);

  final Widget leading;
  final Widget trailing;

  final String placeholder;

  final Color backgroundColor;
  final BoxBorder border;

  final Function(String) onChanged;
  final TextEditingController controller;
  final FocusNode focusNode;

  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    if (leading != null) {
      children.add(leading);
      children.add(Padding(padding: EdgeInsets.only(right: 6)));
    }
    children.add(Expanded(
      child: CupertinoTextField(
        decoration: BoxDecoration(),
        placeholder: placeholder,
        style: Theme.of(context).textTheme.subhead,
        placeholderStyle: Theme.of(context).textTheme.subhead.copyWith(
              color: Theme.of(context).textTheme.subtitle.color,
            ),
        onChanged: onChanged,
        controller: controller,
        focusNode: focusNode,
        obscureText: obscureText,
      ),
    ));
    if (trailing != null) {
      children.add(Padding(padding: EdgeInsets.only(right: 6)));
      children.add(trailing);
    }
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? Theme.of(context).backgroundColor,
        border: border,
      ),
      constraints: BoxConstraints(
        minHeight: 50,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children,
      ),
    );
  }
}
