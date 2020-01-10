import 'package:flutter/material.dart';
import 'package:wan_android_flutter/pages/detail/article_detail_page.dart';
import 'package:wan_android_flutter/pages/home/home_page.dart';
import 'package:wan_android_flutter/pages/cate/cate_page.dart';
import 'package:wan_android_flutter/pages/login_register/login_page.dart';
import 'package:wan_android_flutter/pages/login_register/register_page.dart';
import 'package:wan_android_flutter/pages/public_plat/public_plat_page.dart';
import 'package:wan_android_flutter/pages/project/project_page.dart';
import 'package:wan_android_flutter/pages/root_page.dart';
import 'package:wan_android_flutter/pages/settings/about_us_page.dart';
import 'package:wan_android_flutter/pages/settings/privacy_policy_page.dart';
import 'package:wan_android_flutter/pages/user/user_page.dart';
import 'package:wan_android_flutter/pages/user/user_collect_page.dart';
import 'package:wan_android_flutter/pages/user/user_integral_page.dart';
import 'package:wan_android_flutter/pages/user/user_share_page.dart';
import 'package:wan_android_flutter/pages/settings/settings_page.dart';

registerRouters() {
  AppRouter.register(AppPage.root, (context, paramters) {
    return RootPage();
  });

  AppRouter.register(AppPage.home, (context, paramters) {
    return HomePage();
  });
  AppRouter.register(AppPage.cate, (context, paramters) {
    return CatePage();
  });
  AppRouter.register(AppPage.publicPlat, (context, paramters) {
    return PublicPlatPage();
  });
  AppRouter.register(AppPage.project, (context, paramters) {
    return ProjectPage();
  });
  AppRouter.register(AppPage.user, (context, paramters) {
    return UserPage();
  });
  AppRouter.register(AppPage.userCollect, (context, paramters) {
    return UserCollectPage();
  });
  AppRouter.register(AppPage.userIntegral, (context, paramters) {
    return UserIntegralPage();
  });
  AppRouter.register(AppPage.userShare, (context, paramters) {
    return UserSharePage();
  });
  AppRouter.register(AppPage.settings, (context, paramters) {
    return SettingsPage();
  });
  AppRouter.register(AppPage.login, (context, paramters) {
    return LoginPage();
  });
  AppRouter.register(AppPage.register, (context, paramters) {
    return RegisterPage();
  });
  AppRouter.register(AppPage.articleDetail, (context, paramters) {
    String url = paramters["url"];
    String title = paramters["title"];
    String id = paramters["id"];
    return ArticleDetailPage(
      url: url,
      title: title,
      id: id,
    );
  });
  AppRouter.register(AppPage.aboutUs, (context, paramters) {
    return AboutUsPage();
  });
  AppRouter.register(AppPage.privacyPolicy, (context, paramters) {
    return PrivacyPolicyPage();
  });
}

class AppPage {
  static const root = "/";
  static const home = "/home";
  static const cate = "/cate";
  static const publicPlat = "/plat";
  static const project = "/project";
  static const user = "/user";
  static const userCollect = "/user/collect";
  static const userIntegral = "/user/integral";
  static const userShare = "/user/share";
  static const settings = "/settings";
  static const login = "/user/login";
  static const register = "/user/register";
  static const articleDetail = "/article/detail";
  static const aboutUs = "/settings/about-us";
  static const privacyPolicy = "/settings/privacy-policy";
}

typedef AppRouterHandler = Widget Function(BuildContext, Map<String, dynamic>);

class AppRouter {
  static Map<String, AppRouterHandler> _pathToPageBuilder = {};

  static void register(String path, AppRouterHandler handler) {
    _pathToPageBuilder[path] = handler;
  }

  static void navigateTo(
    BuildContext context,
    String path, {
    Map<String, dynamic> parameters,
    bool fullscreenDialog = false,
  }) {
    Widget _buildPage(BuildContext context) {
      AppRouterHandler handler = _pathToPageBuilder[path];
      assert(handler != null, "the ");
      return handler(context, parameters);
    }

    Navigator.of(context).push(MaterialPageRoute(
      builder: _buildPage,
      fullscreenDialog: fullscreenDialog,
    ));
  }

  static pop(BuildContext context, {String toPath}) {
    if (toPath != null && toPath.isNotEmpty) {
      Navigator.popUntil(context, ModalRoute.withName(toPath));
      return;
    }
    Navigator.pop(context);
  }

  static popToRoot(BuildContext context) {
    pop(context, toPath: AppPage.root);
  }
}
