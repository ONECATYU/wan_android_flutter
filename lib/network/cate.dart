import 'package:wan_android_flutter/models/article.dart';

import 'base.dart';
import 'package:wan_android_flutter/models/cate.dart';
import 'package:wan_android_flutter/models/navigate.dart';

class CateReqPath {
  static const cate = "/tree/json";
  static const navigate = "/navi/json";
  static String articleList(String id, int page) => "/article/list/$page/json?cid=$id";
}

Future<Result> getCateList() async {
  Result result = await Client.request(CateReqPath.cate);
  if (!result.success) return result;

  List jsonList = result.data["data"];
  List<CateModel> models = jsonList.map((json) {
    return CateModel.fromJson(json);
  }).toList();
  result.model = models;
  return result;
}

Future<Result> getNavigateList() async {
  Result result = await Client.request(CateReqPath.navigate);
  if (!result.success) return result;

  List jsonList = result.data["data"];
  List<NavigateModel> models = jsonList.map((json) {
    return NavigateModel.fromJson(json);
  }).toList();
  result.model = models;
  return result;
}

Future<Result> getCateArticleList(String cateId, {int page = 0}) async {
  Result result = await Client.request(CateReqPath.articleList(cateId, page));
  if (!result.success) return result;

  List jsonList = result.data["data"]["datas"];
  List<ArticleModel> models = jsonList.map((json) {
    return ArticleModel.fromJson(json);
  }).toList();
  result.model = models;
  return result;
}