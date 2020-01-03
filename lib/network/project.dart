import 'base.dart';
import 'package:wan_android_flutter/models/cate.dart';
import 'package:wan_android_flutter/models/article.dart';

class ProjectReqPath {
  static const cateList = "/project/tree/json";
  static String articleList(String cid, int page) => "/project/list/$page/json?cid=$cid";
}

Future<Result> getProjectCateList() async {
  Result result = await Client.request(ProjectReqPath.cateList);
  if (!result.success) return result;

  List jsonList = result.data["data"];
  List<CateModel> models = jsonList.map((json) {
    return CateModel.fromJson(json);
  }).toList();
  result.model = models;
  return result;
}

Future<Result> getArticleList(String cid, {int page = 1}) async {
  Result result = await Client.request(ProjectReqPath.articleList(cid, page));
  if (!result.success) return result;

  List jsonList = result.data["data"]["datas"];
  List<ArticleModel> models = jsonList.map((json) {
    return ArticleModel.fromJson(json);
  }).toList();
  result.model = models;
  return result;
}