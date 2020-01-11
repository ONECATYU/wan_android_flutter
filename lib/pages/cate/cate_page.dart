import 'package:flutter/material.dart';
import 'package:wan_android_flutter/models/article.dart';
import 'package:wan_android_flutter/models/cate.dart';
import 'package:wan_android_flutter/models/navigate.dart';
import 'package:wan_android_flutter/network/base.dart';
import 'package:wan_android_flutter/pages/cate/components/cate_card.dart';
import 'package:wan_android_flutter/network/cate.dart';
import 'package:wan_android_flutter/pages/cate/components/cate_content_page.dart';
import 'package:wan_android_flutter/router/router.dart';

class CatePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CatePageState();
  }
}

class _CatePageState extends State<CatePage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController _tabController;
  List<CateModel> _cateModels;
  List<NavigateModel> _navigateModels;

  tabBarDidSelected() async {
    int index = _tabController.index;
    if (index == 0 && _cateModels == null) {
      List<CateModel> models = [];
      Result result = await getCateList();
      if (!result.success) return;
      models.addAll(result.model);
      setState(() {
        _cateModels = models;
      });
    }
    if (index == 1 && _navigateModels == null) {
      List<NavigateModel> models = [];
      Result result = await getNavigateList();
      if (!result.success) return;
      models.addAll(result.model);
      setState(() {
        _navigateModels = models;
      });
    }
  }

  navigateToTreeArticleList(CateModel model, int index) {
    AppRouter.navigateTo(
      context,
      AppPage.cateArticleList,
      parameters: {
        "title": model.name,
        "initialIndex": index,
        "cateModels": model.children,
      },
    );
  }

 void navigateToArticleDetail(ArticleModel model) {
   AppRouter.navigateTo(
      context,
      AppPage.articleDetail,
      parameters: {
        "title": model.title,
        "url": model.link,
        "id": model.id.toString(),
      },
    );
 }

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(tabBarDidSelected);
    tabBarDidSelected();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    ThemeData themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: SizedBox(
          width: 160,
          child: TabBar(
            controller: _tabController,
            indicatorColor: themeData.primaryColor,
            tabs: <Widget>[
              Tab(child: Text("体系", style: themeData.textTheme.title)),
              Tab(child: Text("导航", style: themeData.textTheme.title)),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          CateContentPage(
            models: _cateModels,
            itemBuilder: (context, index) {
              CateModel model = _cateModels[index];
              return CateCard(
                title: model.name,
                labels: model.children.map((subCate) => subCate.name).toList(),
                labelsOnTap: (index) => navigateToTreeArticleList(model, index),
              );
            },
          ),
          CateContentPage(
            models: _navigateModels,
            itemBuilder: (context, index) {
              NavigateModel model = _navigateModels[index];
              return CateCard(
                title: model.name,
                labels: model.articles.map((article) => article.title).toList(),
                labelsOnTap: (index) => navigateToArticleDetail(model.articles[index]),
              );
            },
          ),
        ],
      ),
    );
  }
}
