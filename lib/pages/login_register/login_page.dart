import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wan_android_flutter/models/user.dart';
import 'package:wan_android_flutter/network/base.dart';
import 'package:wan_android_flutter/pages/login_register/components/text_input_item.dart';
import 'package:wan_android_flutter/provider/user_provider.dart';
import 'package:wan_android_flutter/router/router.dart';
import 'package:wan_android_flutter/network/user.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  loginHandler() async {
    FocusScope.of(context).unfocus();

    String username = _usernameController.text;
    String password = _passwordController.text;

    if (username.isEmpty) {
      BotToast.showText(text: "用户名不能为空!");
      return;
    }
    if (password.isEmpty) {
      BotToast.showText(text: "密码不能为空!");
      return;
    }
    var hideLoading = BotToast.showLoading();
    Result result = await userLogin(username, password);
    if (!result.success) {
      hideLoading();
      BotToast.showText(text: result.errorMsg);
      return;
    }
    UserModel user = result.model as UserModel;
    ///登录成功请求下积分信息
    Result coinRes = await getUserCoinInfos();
    if (coinRes.success) {
      Map<String, dynamic> json = coinRes.model as Map<String, dynamic>;
      user.coinCount = json["coinCount"];
      user.rank = json["rank"];
    }
    hideLoading();
    Provider.of<UserProvider>(context).changeUser(result.model);
    AppRouter.pop(context);
    await user.saveToLocal();
  }

  navigateToRegister() {
    AppRouter.navigateTo(context, AppPage.register);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeData.scaffoldBackgroundColor,
        leading: CloseButton(),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text("登录", style: themeData.textTheme.title.copyWith(fontSize: 28)),
            Padding(padding: EdgeInsets.only(bottom: 40)),
            TextInputItem(
              placeholder: "请输入用户名",
              controller: _usernameController,
            ),
            Padding(padding: EdgeInsets.only(bottom: 1)),
            TextInputItem(
              placeholder: "请输入密码",
              controller: _passwordController,
              obscureText: true,
            ),
            Padding(padding: EdgeInsets.only(bottom: 40)),
            InkWell(
              onTap: loginHandler,
              child: Container(
                color: Theme.of(context).backgroundColor,
                height: 50,
                child: Center(child: Text("登录")),
              ),
            ),
            Padding(padding: EdgeInsets.only(bottom: 12)),
            Container(
              padding: EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  InkWell(
                    child:
                        Text("没有账号?去注册", style: themeData.textTheme.subtitle),
                    onTap: navigateToRegister,
                  ),
                  Icon(
                    Icons.arrow_forward,
                    size: 15,
                    color: themeData.textTheme.subtitle.color,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
