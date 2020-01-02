import 'base.dart';
import 'package:wan_android_flutter/models/article.dart';
import 'package:wan_android_flutter/models/banner.dart';

class HomeReqPath {
  static String article(int page) => "/article/list/$page/json";
  static const String topArticle = "/article/top/json";
  static const String banner = "/banner/json";
}

/// 文章列表
Future<Result> getArticleList({int page = 0}) async {
  Result result = await Client.request(HomeReqPath.article(page));
  if (!result.success) return result;

  List jsonList = result.data["data"]["datas"];
  List<ArticleListModel> models = jsonList.map((json) {
    return ArticleListModel.fromJson(json);
  }).toList();
  result.model = models;
  return result;
}

/// 置顶文章
Future<Result> getTopArticleList() async {
  Result result = await Client.request(HomeReqPath.topArticle);
  if (!result.success) return result;

  List jsonList = result.data["data"];
  List<ArticleListModel> models = jsonList.map((json) {
    return ArticleListModel.fromJson(json)..isTop = true;
  }).toList();
  result.model = models;
  return result;
}

/// Banner
Future<Result> getBannerData() async {
  Result result = await Client.request(HomeReqPath.banner);
  if (!result.success) return result;

  List jsonList = result.data["data"];
  List<BannerModel> models = jsonList.map((json) {
    return BannerModel.fromJson(json);
  }).toList();
  result.model = models;
  return result;
}
