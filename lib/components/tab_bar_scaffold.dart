import 'package:flutter/material.dart';
import 'package:wan_android_flutter/components/simple_app_bar.dart';

class TabBarScaffold extends StatelessWidget {
  TabBarScaffold({
    Key key,
    @required this.tabController,
    @required this.tabs,
    this.itemCount,
    this.itemBuilder,
    this.title,
  }) : super(key: key);

  final TabController tabController;
  final List<Widget> tabs;

  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;

  final Widget title;

  @override
  Widget build(BuildContext context) {
    TabBar tabBar;
    if (tabs != null && tabs.length > 0) {
      tabBar = TabBar(
        labelStyle: Theme.of(context).textTheme.title,
        isScrollable: true,
        controller: tabController,
        tabs: tabs,
      );
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: title ?? tabBar,
        bottom: title != null ? tabBar : null,
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(12),
        separatorBuilder: (context, index) {
          return Padding(padding: EdgeInsets.only(bottom: 12));
        },
        itemCount: itemCount,
        itemBuilder: itemBuilder,
      ),
    );
  }
}
