import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wan_android_flutter/models/cate.dart';
import 'package:wan_android_flutter/pages/tab_bar_scaffold_state.dart';
import 'package:wan_android_flutter/network/base.dart';
import 'package:wan_android_flutter/network/cate.dart';

class CateArticleListPage extends StatefulWidget {
  CateArticleListPage({
    Key key,
    this.title,
    this.cateModels,
    this.initialIndex,
  }) : super(key: key);
  final String title;
  final List<CateModel> cateModels;
  final int initialIndex;

  @override
  State<StatefulWidget> createState() {
    return _CateArticleListPageState();
  }
}

class _CateArticleListPageState
    extends TabBarScaffoldState<CateArticleListPage> {
  @override
  int get initialIndex => widget.initialIndex;

  @override
  List<CateModel> get initialCateModels => widget.cateModels;

  @override
  Widget get title => Text(widget.title);

  @override
  Future<Result> requestTabBarDataList() {
    return null;
  }

  @override
  Future<Result> requestArticleList(String id, {int page}) {
    return getCateArticleList(id, page: page);
  }
}
