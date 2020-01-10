import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wan_android_flutter/components/list_item.dart';
import 'package:wan_android_flutter/models/user.dart';
import 'package:wan_android_flutter/network/base.dart';
import 'package:wan_android_flutter/network/user.dart';
import 'package:wan_android_flutter/provider/theme.dart';
import 'package:wan_android_flutter/provider/user_provider.dart';
import 'package:wan_android_flutter/router/router.dart';

class SettingsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SettingsPageState();
  }
}

class _SettingsPageState extends State<SettingsPage> {
  changeDarkModel(bool isDark) {
    Provider.of<ThemeManager>(context).switchToDark(isDark);
  }

  logoutHandler() async {
    VoidCallback  hideLoading = BotToast.showLoading();
    Result result = await userLogout();
    hideLoading();
    if (!result.success) {
      BotToast.showText(text: result.errorMsg);
      return;
    }
    UserModel.removeFromLocal();
    Client.cleanAllCookies();
    Provider.of<UserProvider>(context).changeUser(null);
    AppRouter.pop(context);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("设置", style: Theme.of(context).textTheme.title),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 20),
        children: <Widget>[
          ListItem(
            title: Text("暗黑模式"),
            trailing: Switch(
              value: Provider.of<ThemeManager>(context).isDark,
              activeColor: Theme.of(context).primaryColor,
              onChanged: changeDarkModel,
            ),
          ),
          Padding(padding: EdgeInsets.only(bottom: 20)),
          ListItem(
            trailingType: TrailingType.nextIndicator,
            title: Text("关于我们"),
            onTap: () => AppRouter.navigateTo(context, AppPage.aboutUs),
          ),
          ListItem(
            trailingType: TrailingType.nextIndicator,
            title: Text("隐私政策"),
            onTap: () => AppRouter.navigateTo(context, AppPage.privacyPolicy),
          ),
          Padding(padding: EdgeInsets.only(bottom: 20)),
          InkWell(
            child: Container(
              height: 50,
              color: Theme.of(context).backgroundColor,
              child: Center(
                child: Text("退出登录", style: Theme.of(context).textTheme.subhead),
              ),
            ),
            onTap: logoutHandler,
          ),
        ],
      ),
    );
  }
}
