import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TabBarScaffold extends StatelessWidget {
  TabBarScaffold({
    Key key,
    @required this.tabController,
    @required this.tabs,
    this.itemCount,
    this.itemBuilder,
    this.title,
    this.scrollController,
    this.refreshController,
    this.onRefresh,
    this.onLoadMore,
  }) : super(key: key);

  final TabController tabController;
  final List<Widget> tabs;

  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;

  final Widget title;

  final ScrollController scrollController;

  final RefreshController refreshController;
  final VoidCallback onRefresh;
  final VoidCallback onLoadMore;

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
    Widget titleWidget = tabBar;
    Widget bottomWidget;
    if (title != null) {
      titleWidget = DefaultTextStyle(
        child: title,
        style: Theme.of(context).textTheme.title,
      );
      bottomWidget = tabBar;
    }

    Widget body = ListView.separated(
      controller: scrollController,
      padding: EdgeInsets.all(12),
      separatorBuilder: (context, index) {
        return Padding(padding: EdgeInsets.only(bottom: 12));
      },
      itemCount: itemCount,
      itemBuilder: itemBuilder,
    );
    if (refreshController != null) {
      body = SmartRefresher(
        controller: refreshController,
        enablePullDown: onRefresh != null,
        enablePullUp: onLoadMore != null,
        onRefresh: onRefresh,
        onLoading: onLoadMore,
        header: WaterDropHeader(),
        child: body,
      );
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: titleWidget,
        bottom: bottomWidget,
      ),
      body: body,
    );
  }
}
