import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
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

  // 给已经请求过的文章做个缓存, 防止切换tab时,重复请求数据.
  Map<int, List<ArticleModel>> modelsMap = {};

  List<ArticleModel> currentArticleList = [];

  ScrollController scrollController = ScrollController();
  RefreshController refreshController = RefreshController();

  // 记录下当前tab请求的页数
  Map<int, int> pagesMap = {};

  @protected
  Future<Result> requestTabBarDataList();

  @protected
  Future<Result> requestArticleList(String id, {int page});

  @protected
  Widget get title => null;

  @protected
  int get initialIndex => 0;

  @protected
  List<CateModel> get initialCateModels => null;

  void _getTabBarDataList() async {
    List<CateModel> models = initialCateModels;
    if (models == null) {
      Result result = await requestTabBarDataList();
      if (!result.success) {
        return;
      }
      models = result.model;
    }

    tabController = TabController(
        length: models.length, vsync: this, initialIndex: initialIndex ?? 0);
    tabController.addListener(() {
      scrollController.jumpTo(0);
      _refreshData();
    });

    setState(() {
      platModels = models;
    });
    _refreshData(showLoading: false);
  }

  void _refreshData({bool showLoading = true}) async {
    if (tabController == null || platModels.length == 0) {
      refreshController.refreshCompleted();
      return;
    }
    int index = tabController.index;
    CateModel model = platModels[index];
    List<ArticleModel> models = modelsMap[model.id];
    if (models != null) {
      setState(() {
        currentArticleList = models;
      });
      refreshController.refreshCompleted();
      return;
    }
    var hideLoading = showLoading ? BotToast.showLoading() : () {};
    Result result = await requestArticleList(model.id.toString(), page: 0);
    models = result.model;
    hideLoading();
    if (!result.success) {
      if (showLoading) BotToast.showText(text: result.errorMsg);
    }
    modelsMap[model.id] = models;
    setState(() {
      currentArticleList = models;
    });
    refreshController.refreshCompleted();
  }

  void _loadMoreData() async {
    if (tabController == null || platModels.length == 0) {
      refreshController.loadComplete();
      return;
    }
    int index = tabController.index;
    CateModel model = platModels[index];
    List<ArticleModel> models = modelsMap[model.id];
    if (models == null) {
      refreshController.loadComplete();
      return;
    }

    int page = pagesMap[model.id] ?? 0;
    page++;
    var hideLoading = BotToast.showLoading();
    Result result = await requestArticleList(model.id.toString(), page: page);
    hideLoading();
    if (!result.success) {
      BotToast.showText(text: result.errorMsg);
      page--;
      refreshController.loadComplete();
      return;
    }
    List<ArticleModel> resModels = result.model as List<ArticleModel>;
    if (resModels == null || resModels.isEmpty) {
      BotToast.showText(text: "没有更多数据了~");
      page--;
      refreshController.loadComplete();
      return;
    }
    models.addAll(resModels);
    modelsMap[model.id] = models;
    pagesMap[model.id] = page;

    setState(() {
      currentArticleList = models;
    });
    refreshController.loadComplete();
  }

  void navigateToDetail(ArticleModel model) {
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
    List<Widget> tabs = platModels.map((model) {
      return Tab(
        child: Text(
          model.name,
          style: Theme.of(context).textTheme.title,
        ),
      );
    }).toList();

    Widget itemBuilder(BuildContext context, int index) {
      ArticleModel model = currentArticleList[index];
      return ArticleCard.fromArticleListModel(
        model,
        onTap: () => navigateToDetail(model),
      );
    }

    return TabBarScaffold(
      title: title,
      tabController: tabController,
      scrollController: scrollController,
      refreshController: refreshController,
      onRefresh: _refreshData,
      onLoadMore: _loadMoreData,
      tabs: tabs,
      itemCount: currentArticleList.length,
      itemBuilder: itemBuilder,
    );
  }
}
