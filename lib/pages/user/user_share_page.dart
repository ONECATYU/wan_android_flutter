import 'package:flutter/material.dart';

class UserSharePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _UserSharePageState();
  }
}

class _UserSharePageState extends State<UserSharePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("我的分享", style: Theme.of(context).textTheme.title),
      ),
    );
  }
}
