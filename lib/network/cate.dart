import 'base.dart';
import 'package:wan_android_flutter/models/cate.dart';
import 'package:wan_android_flutter/models/navigate.dart';

class CateReqPath {
  static const cate = "/tree/json";
  static const navigate = "/navi/json";
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