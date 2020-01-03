import 'package:flutter/material.dart';
import 'package:wan_android_flutter/network/base.dart';
import 'package:wan_android_flutter/network/project.dart';
import 'package:wan_android_flutter/pages/tab_bar_scaffold_state.dart';

class ProjectPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProjectPageState();
  }
}

class _ProjectPageState extends TabBarScaffoldState<ProjectPage> {

  @override
  Future<Result> requestTabBarDataList() {
    return getProjectCateList();
  }

  @override
  Future<Result> requestArticleList(String id) {
    return getArticleList(id);
  }
}

//import 'package:wan_android_flutter/models/cate.dart';
//import 'package:wan_android_flutter/models/article.dart';
//import 'package:wan_android_flutter/components/tab_bar_scaffold.dart';
//import 'package:wan_android_flutter/components/article_card.dart';

//class _ProjectPageState extends State<ProjectPage> with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
//  TabController _tabController;
//  List<CateModel> _platModels = [];
//  Map<int, List<ArticleModel>> _modelsMap = {};
//  List<ArticleModel> _currentArticleList = [];
//
//  getPlatList() async {
//    Result result = await getProjectCateList();
//    if (!result.success) {
//      return;
//    }
//    List<CateModel> models = result.model;
//
//    _tabController = TabController(length: models.length, vsync: this);
//    _tabController.addListener(tabBarDidSelected);
//
//    setState(() {
//      _platModels = models;
//    });
//
//    tabBarDidSelected();
//  }
//
//  tabBarDidSelected() async {
//    if (_tabController == null || _platModels.length == 0) return;
//    int index = _tabController.index;
//    CateModel model = _platModels[index];
//    List<ArticleModel> models = _modelsMap[model.id];
//    if (models != null) {
//      setState(() {
//        _currentArticleList = models;
//      });
//      return;
//    }
//    Result result = await getArticleList(model.id.toString());
//    models = result.model;
//    if (!result.success) {}
//    setState(() {
//      _currentArticleList = models;
//    });
//  }
//
//  @override
//  void initState() {
//    super.initState();
//    getPlatList();
//  }
//
//  @override
//  bool get wantKeepAlive => true;
//
//  @override
//  Widget build(BuildContext context) {
//    super.build(context);
//    return TabBarScaffold(
//      tabController: _tabController,
//      tabs: _platModels.map((model) {
//        return Tab(
//          child: Text(model.name, style: Theme.of(context).textTheme.title),
//        );
//      }).toList(),
//      itemCount: _currentArticleList.length,
//      itemBuilder: (context, index) {
//        return ArticleCard.fromArticleListModel(_currentArticleList[index]);
//      },
//    );
//  }
//}