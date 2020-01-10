import 'package:wan_android_flutter/models/article.dart';

import 'base.dart';
import 'package:wan_android_flutter/models/user.dart';

class UserReqPath {
  static const login = "/user/login";
  static const register = "/user/register";
  static const logout = "/user/logout/json";
  static const coinInfos = "/lg/coin/userinfo/json";

  static String collectArticle({
    bool isOutside = false,
    String id,
  }) {
    if (!isOutside) return "/lg/collect/$id/json";
    return "/lg/collect/add/json";
  }

  static String collectionList(int page) => "/lg/collect/list/$page/json";
}

Future<Result> userRegister(
    String userName, String password, String repassword) async {
  Result result = await Client.request(
    UserReqPath.register,
    reqMethod: ReqMethod.POST,
    parameters: {
      "username": userName,
      "password": password,
      "repassword": repassword,
    },
  );
  if (!result.success) return result;
  UserModel userModel = UserModel.fromJson(result.data["data"]);
  result.model = userModel;
  return result;
}

Future<Result> userLogin(String userName, String password) async {
  Result result = await Client.request(
    UserReqPath.login,
    reqMethod: ReqMethod.POST,
    parameters: {"username": userName, "password": password},
  );
  if (!result.success) return result;
  UserModel userModel = UserModel.fromJson(result.data["data"]);
  result.model = userModel;
  return result;
}

Future<Result> userLogout() async {
  Result result = await Client.request(UserReqPath.logout);
  return result;
}

Future<Result> getUserCollectionList({int page = 0}) async {
  Result result = await Client.request(UserReqPath.collectionList(page));
  if (!result.success) return result;
  List jsonList = result.data["data"]["datas"];
  List<ArticleModel> models = jsonList.map((json) {
    return ArticleModel.fromJson(json);
  }).toList();
  result.model = models;
  return result;
}

Future<Result> collectArticle(String id) async {
  Result result = await Client.request(
    UserReqPath.collectArticle(id: id),
    reqMethod: ReqMethod.POST,
  );
  return result;
}

Future<Result> collectOutsideArticle(
    String title, String author, String link) async {
  Result result = await Client.request(
    UserReqPath.collectArticle(isOutside: true),
    reqMethod: ReqMethod.POST,
    parameters: {
      "title": title,
      "author": author,
      "link": link,
    },
  );
  return result;
}

Future<Result> getUserCoinInfos() async {
  Result result = await Client.request(UserReqPath.coinInfos);
  if (!result.success) return result;
  result.model = result.data["data"];
  return result;
}
