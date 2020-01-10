import 'dart:io';

import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

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
  static Dio dio;
  static PersistCookieJar _cookieJar;

  static Future<Dio> dioInstance() async {
    if (dio == null) {
      Directory tempDir = await getTemporaryDirectory();
      String tempPath = tempDir.path;
      _cookieJar = PersistCookieJar(dir: tempPath);
      dio = Dio();
      dio.interceptors.add(CookieManager(_cookieJar));
    }
    return dio;
  }

  static cleanAllCookies() {
    if (_cookieJar != null) _cookieJar.deleteAll();
  }

  static Future<Result> request(
    String path, {
    ReqMethod reqMethod = ReqMethod.GET,
    Map<String, dynamic> parameters,
  }) async {
    if (!path.startsWith("http")) {
      path = host + path;
    }
    Dio dio = await dioInstance();
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
