import 'package:flutter/material.dart';
import 'package:wan_android_flutter/models/user.dart';
import 'package:wan_android_flutter/pages/user/components/user_header_widget.dart';
import 'package:wan_android_flutter/components/list_item.dart';
import 'package:wan_android_flutter/provider/user_provider.dart';
import 'package:wan_android_flutter/router/router.dart';
import 'package:wan_android_flutter/util/iconfont.dart';
import 'package:provider/provider.dart';

class UserPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _UserPageState();
  }
}

class _UserPageState extends State<UserPage> {
  nickNameOnTap() {
    AppRouter.navigateTo(context, AppPage.login, fullscreenDialog: true);
  }

  loadLocalUser() async {
    UserModel user = await UserModel.loadFromLocal();
    if (user != null) {
      print("---- 本地用户信息: ${user.toJson()} ----");
      Provider.of<UserProvider>(context).changeUser(user);
    }
  }

  @override
  void initState() {
    super.initState();
    loadLocalUser();
  }

  @override
  void reassemble() {
    super.reassemble();
    loadLocalUser();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    ListItem buildListItem({
      IconData icon,
      String title,
      String subTitle,
      String toPage,
      Color iconColor,
    }) {
      iconColor = iconColor ?? themeData.primaryColor;
      return ListItem(
        trailingType: TrailingType.nextIndicator,
        leading: Icon(icon, color: iconColor, size: 23),
        title: Text(title),
        onTap: () => AppRouter.navigateTo(context, toPage),
        subTitle:
            (subTitle != null && subTitle.isNotEmpty) ? Text(subTitle) : null,
      );
    }

    return Scaffold(
      body: Column(
        children: <Widget>[
          Consumer<UserProvider>(builder: (context, provider, widget) {
            UserModel userModel = provider.loginUser;
            bool isLogin = provider.isLogin;
            return UserHeaderWidget(
              headImgUrl: null,
              nickName: isLogin ? userModel.displayName : "点击登录",
              id: userModel?.id?.toString() ?? "--",
              coin: userModel?.coinCount?.toString() ?? "--",
              ranking: userModel?.rank?.toString() ?? "--",
              nickNameOnTap: isLogin ? null : nickNameOnTap,
            );
          }),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(12),
              children: <Widget>[
                Consumer<UserProvider>(builder: (context, provider, widget) {
                  return buildListItem(
                    icon: IconFont.integral,
                    title: "我的积分",
                    subTitle: provider.loginUser?.coinCount?.toString(),
                    toPage: AppPage.userIntegral,
                  );
                }),
                buildListItem(
                  icon: IconFont.share,
                  title: "我的分享",
                  toPage: AppPage.userShare,
                ),
                buildListItem(
                  icon: IconFont.heart,
                  title: "我的收藏",
                  toPage: AppPage.userCollect,
                  iconColor: Colors.red,
                ),
                Padding(padding: EdgeInsets.only(bottom: 20)),
                buildListItem(
                  icon: IconFont.setting,
                  title: "设置",
                  toPage: AppPage.settings,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
