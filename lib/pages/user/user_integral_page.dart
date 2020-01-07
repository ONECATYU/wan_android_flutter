import 'package:flutter/material.dart';

class UserIntegralPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _UserIntegralPageState();
  }
}

class _UserIntegralPageState extends State<UserIntegralPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("我的积分", style: Theme.of(context).textTheme.title),
      ),
    );
  }
}
