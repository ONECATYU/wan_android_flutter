import 'base.dart';
import 'package:wan_android_flutter/models/article.dart';
import 'package:wan_android_flutter/models/cate.dart';

class PublicReqPath {
  static const platList = "/wxarticle/chapters/json";
  static String article(String id, int page) => "/wxarticle/list/$id/$page/json";
}

Future<Result> getPlatCateList() async {
  Result result = await Client.request(PublicReqPath.platList);
  if (!result.success) return result;

  List jsonList = result.data["data"];
  List<CateModel> models = jsonList.map((json) {
    return CateModel.fromJson(json);
  }).toList();
  result.model = models;
  return result;
}

Future<Result> getArticleList(String platId, {int page = 1}) async {
  Result result = await Client.request(PublicReqPath.article(platId, page));
  if (!result.success) return result;

  List jsonList = result.data["data"]["datas"];
  List<ArticleModel> models = jsonList.map((json) {
    return ArticleModel.fromJson(json);
  }).toList();
  result.model = models;
  return result;
}

