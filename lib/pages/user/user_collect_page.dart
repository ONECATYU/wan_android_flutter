import 'package:flutter/material.dart';
import 'package:wan_android_flutter/components/search_bar.dart';
import 'package:wan_android_flutter/components/simple_app_bar.dart';

class UserCollectPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _UserCollectPageState();
  }
}

class _UserCollectPageState extends State<UserCollectPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("我的收藏", style: Theme.of(context).textTheme.title),
      ),
    );
  }
}
