import 'package:flutter/material.dart';
import 'package:wan_android_flutter/components/search_bar.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wan_android_flutter/network/base.dart';
import 'package:wan_android_flutter/network/home.dart';
import 'package:wan_android_flutter/models/article.dart';
import 'package:wan_android_flutter/components/article_card.dart';
import 'package:wan_android_flutter/models/banner.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:wan_android_flutter/router/router.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  RefreshController _refreshController = RefreshController();
  List<ArticleModel> _articleList;
  List<BannerModel> _bannerList;
  int _page = 1;

  onRefresh() async {
    _page = 1;
    List<ArticleModel> articleList = [];
    List<BannerModel> bannerList;

    List<Result> results = await Future.wait([
      getBannerData(),
      getTopArticleList(),
      getArticleList(),
    ]);
    _refreshController.refreshCompleted();
    _refreshController.loadComplete();

    if (results[0].success) {
      bannerList = [];
      bannerList.addAll(results[0].model);
    }
    if (results[1].success) {
      articleList.addAll(results[1].model);
    }
    if (results[2].success) {
      articleList.addAll(results[2].model);
    } else {}

    setState(() {
      _bannerList = bannerList;
      _articleList = articleList;
    });
  }

  loadMoreData() async {
    _page++;
    Result result = await getArticleList(page: _page);
    if (!result.success) {
      _page--;
      return;
    }
    List<ArticleModel> models = result.model as List<ArticleModel>;
    if (models.length == 0) {
      _refreshController.loadNoData();
      return;
    }
    _refreshController.loadComplete();
    List<ArticleModel> articleList = [];
    articleList.addAll(_articleList);
    articleList.addAll(models);
    setState(() {
      _articleList = articleList;
    });
  }

  collectHandler(ArticleModel model) {
    if (model.collect || model.id == null) return;
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
    onRefresh();
  }

  @override
  void dispose() {
    super.dispose();
    _refreshController.dispose();
  }

  Widget _buildBanner() {
    return Container(
      height: 200,
      child: Swiper.list(
        autoplay: true,
        list: _bannerList,
        builder: (context, m, index) {
          BannerModel model = m as BannerModel;
          return CachedNetworkImage(
            imageUrl: model.imagePath,
            fit: BoxFit.cover,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    List<Widget> children = [];
    if (_bannerList != null && _bannerList.length > 0) {
      children.add(_buildBanner());
      children.add(Padding(padding: EdgeInsets.only(bottom: 12)));
    }

    if (_articleList != null && _articleList.length > 0) {
      _articleList.forEach((model) {
        children.add(ArticleCard.fromArticleListModel(
          model,
          collectClick: () => collectHandler(model),
          onTap: () => navigateToDetail(model),
        ));
        children.add(Padding(padding: EdgeInsets.only(bottom: 12)));
      });
      children.removeLast();
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: SearchBar(
          backgroundColor: Theme.of(context).backgroundColor,
        ),
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        enablePullUp: true,
        header: WaterDropHeader(),
        onRefresh: onRefresh,
        onLoading: loadMoreData,
        child: ListView(
          padding: EdgeInsets.all(12),
          children: children,
        ),
      ),
    );
  }
}
