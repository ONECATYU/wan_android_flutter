import 'package:flutter/material.dart';
import 'package:wan_android_flutter/components/article_card.dart';
import 'package:wan_android_flutter/components/tab_bar_scaffold.dart';
import 'package:wan_android_flutter/models/article.dart';
import 'package:wan_android_flutter/models/cate.dart';
import 'package:wan_android_flutter/network/base.dart';
import 'package:wan_android_flutter/router/router.dart';

abstract class TabBarScaffoldState<T extends StatefulWidget> extends State<T>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController tabController;
  List<CateModel> platModels = [];
  Map<int, List<ArticleModel>> modelsMap = {};
  List<ArticleModel> currentArticleList = [];

  @protected
  Future<Result> requestTabBarDataList();

  @protected
  Future<Result> requestArticleList(String id);

  @protected
  Widget get title => null;

  _getTabBarDataList() async {
    Result result = await requestTabBarDataList();
    if (!result.success) {
      return;
    }
    List<CateModel> models = result.model;

    tabController = TabController(length: models.length, vsync: this);
    tabController.addListener(_tabBarDidSelected);

    setState(() {
      platModels = models;
    });

    _tabBarDidSelected();
  }

  _tabBarDidSelected() async {
    if (tabController == null || platModels.length == 0) return;
    int index = tabController.index;
    CateModel model = platModels[index];
    List<ArticleModel> models = modelsMap[model.id];
    if (models != null) {
      setState(() {
        currentArticleList = models;
      });
      return;
    }
    Result result = await requestArticleList(model.id.toString());
    models = result.model;
    if (!result.success) {}
    setState(() {
      currentArticleList = models;
    });
  }

  navigateToDetail(ArticleModel model) {
    AppRouter.navigateTo(
      context,
      AppPage.articleDetail,
      parameters: {
        "url": model.link,
        "title": model.title,
        "id": model.id.toString(),
      },
    );
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _getTabBarDataList();
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return TabBarScaffold(
      title: title,
      tabController: tabController,
      tabs: platModels.map((model) {
        return Tab(
          child: Text(
            model.name,
            style: Theme.of(context).textTheme.title,
          ),
        );
      }).toList(),
      itemCount: currentArticleList.length,
      itemBuilder: (context, index) {
        ArticleModel model = currentArticleList[index];
        return ArticleCard.fromArticleListModel(
          model,
          onTap: () => navigateToDetail(model),
        );
      },
    );
  }
}
