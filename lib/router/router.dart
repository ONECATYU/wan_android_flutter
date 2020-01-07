import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';

import 'package:wan_android_flutter/pages/home/home_page.dart';
import 'package:wan_android_flutter/pages/cate/cate_page.dart';
import 'package:wan_android_flutter/pages/public_plat/public_plat_page.dart';
import 'package:wan_android_flutter/pages/project/project_page.dart';
import 'package:wan_android_flutter/pages/user/user_page.dart';
import 'package:wan_android_flutter/pages/user/user_collect_page.dart';
import 'package:wan_android_flutter/pages/user/user_integral_page.dart';
import 'package:wan_android_flutter/pages/user/user_share_page.dart';
import 'package:wan_android_flutter/pages/settings/settings_page.dart';

class AppPage {
  static const home = "/home";
  static const cate = "/cate";
  static const publicPlat = "/plat";
  static const project = "/project";
  static const user = "/user";
  static const userCollect = "/user/collect";
  static const userIntegral = "/user/integral";
  static const userShare = "/user/share";
  static const settings = "/settings";
}

class AppRouter {
  static Router _router = Router();

  static void register() {
    _router.define(AppPage.home, handler: _homeHandler);
    _router.define(AppPage.cate, handler: _cateHandler);
    _router.define(AppPage.publicPlat, handler: _platHandler);
    _router.define(AppPage.project, handler: _projectHandler);
    _router.define(AppPage.user, handler: _userHandler);
    _router.define(AppPage.userCollect, handler: _userCollectHandler);
    _router.define(AppPage.userIntegral, handler: _userIntegralHandler);
    _router.define(AppPage.userShare, handler: _userShareHandler);
    _router.define(AppPage.settings, handler: _settingsHandler);
  }

  static navigateTo(
    BuildContext context,
    String path, {
    Map<String, dynamic> parameters,
    bool replace = false,
  }) {
    String finalPath = path;
    if (parameters != null && parameters.isNotEmpty) {
      List<String> paraStringList = [];
      parameters.forEach((key, value) {
        paraStringList.add("$key=$value");
      });
      String paraString = paraStringList.join("&");
      finalPath = "$path?${Uri.encodeFull(paraString)}";
    }
    _router.navigateTo(
      context,
      finalPath,
      replace: replace,
      transition: TransitionType.material,
    );
  }
}

var _homeHandler = Handler(handlerFunc: (ctx, map) {
  return HomePage();
});

var _cateHandler = Handler(handlerFunc: (ctx, map) {
  return CatePage();
});

var _platHandler = Handler(handlerFunc: (ctx, map) {
  return PublicPlatPage();
});

var _projectHandler = Handler(handlerFunc: (ctx, map) {
  return ProjectPage();
});

var _userHandler = Handler(handlerFunc: (ctx, map) {
  return UserPage();
});

var _userCollectHandler = Handler(handlerFunc: (ctx, map) {
  return UserCollectPage();
});

var _userIntegralHandler = Handler(handlerFunc: (ctx, map) {
  return UserIntegralPage();
});

var _userShareHandler = Handler(handlerFunc: (ctx, map) {
  return UserSharePage();
});

var _settingsHandler = Handler(handlerFunc: (ctx, map) {
  return SettingsPage();
});
