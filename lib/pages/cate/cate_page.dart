import 'package:flutter/material.dart';
import 'package:wan_android_flutter/components/simple_app_bar.dart';
import 'package:wan_android_flutter/models/cate.dart';
import 'package:wan_android_flutter/models/navigate.dart';
import 'package:wan_android_flutter/network/base.dart';
import 'package:wan_android_flutter/pages/cate/components/cate_card.dart';
import 'package:wan_android_flutter/network/cate.dart';
import 'package:wan_android_flutter/pages/cate/components/cate_content_page.dart';

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
      appBar: SimpleAppBar(
        backgroundColor: themeData.backgroundColor,
        child: Center(
          child: SizedBox(
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
              );
            },
          ),
        ],
      ),
    );
  }
}
