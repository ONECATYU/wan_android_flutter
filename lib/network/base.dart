import 'package:dio/dio.dart';

enum ResError { none, loginInvalid, dataFormatErr, server }

class Result<T> {
  final Response response;
  ResError error = ResError.none;
  String errorMsg;

  T model;

  Result({this.response});

  bool get success => error == ResError.none;

  Map<String, dynamic> get data {
    if (response == null || !(response.data is Map<String, dynamic>))
      return null;
    return response.data;
  }
}

enum ReqMethod {
  GET,
  POST,
}

class Client {
  static const host = "https://www.wanandroid.com";
  static Dio dio = Dio();

  static Future<Result> request(
    String path, {
    ReqMethod reqMethod = ReqMethod.GET,
    Map<String, dynamic> parameters,
  }) async {
    if (!path.startsWith("http")) {
      path = host + path;
    }
    Response response;
    if (reqMethod == ReqMethod.GET) {
      response = await dio.get(path, queryParameters: parameters);
    } else if (reqMethod == ReqMethod.POST) {
      response = await dio.post(path, queryParameters: parameters);
    }
    Result result = Result(response: response);
    Map<String, dynamic> json = result.data;
    if (json == null) {
      result.error = ResError.dataFormatErr;
      result.errorMsg = "返回数据格式错误";
      return result;
    }
    int errCode = json["errorCode"];
    if (errCode == -1001) {
      result.error = ResError.loginInvalid;
      result.errorMsg = json["errorMsg"] ?? "登录失效,请重新登录";
      return result;
    } else if (errCode != 0) {
      result.error = ResError.server;
      result.errorMsg = json["errorMsg"] ?? "服务器出错啦~";
      return result;
    }
    return result;
  }
}
