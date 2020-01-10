import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wan_android_flutter/models/user.dart';
import 'package:wan_android_flutter/network/base.dart';
import 'package:wan_android_flutter/network/user.dart';
import 'package:wan_android_flutter/pages/login_register/components/text_input_item.dart';
import 'package:wan_android_flutter/provider/user_provider.dart';
import 'package:wan_android_flutter/router/router.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegisterPageState();
  }
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _repeatPasswordController = TextEditingController();

  registerHandler() async {
    FocusScope.of(context).unfocus();
    String username = _userNameController.text;
    String password = _passwordController.text;
    String repeatPassword = _repeatPasswordController.text;

    if (username.isEmpty) {
      BotToast.showText(text: "用户名不能为空!");
      return;
    }
    if (password.isEmpty) {
      BotToast.showText(text: "密码不能为空!");
      return;
    }
    if (repeatPassword.isEmpty) {
      BotToast.showText(text: "请再次输入密码!");
      return;
    }
    if (repeatPassword != password) {
      BotToast.showText(text: "两次输入的密码不一致!");
      return;
    }
    var hideLoading = BotToast.showLoading();
    Result result = await userRegister(username, password, repeatPassword);
    if (!result.success) {
      hideLoading();
      BotToast.showText(text: result.errorMsg);
      return;
    }
    UserModel user = result.model as UserModel;
    ///注册成功请求下积分信息
    Result coinRes = await getUserCoinInfos();
    if (coinRes.success) {
      Map<String, dynamic> json = coinRes.model as Map<String, dynamic>;
      user.coinCount = json["coinCount"];
      user.rank = json["rank"];
    }
    hideLoading();
    Provider.of<UserProvider>(context).changeUser(result.model);
    AppRouter.pop(context);
    AppRouter.pop(context);
    await user.saveToLocal();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeData.scaffoldBackgroundColor,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text("注册", style: themeData.textTheme.title.copyWith(fontSize: 28)),
            Padding(padding: EdgeInsets.only(bottom: 40)),
            TextInputItem(
              placeholder: "请输入用户名",
              controller: _userNameController,
            ),
            Padding(padding: EdgeInsets.only(bottom: 1)),
            TextInputItem(
              placeholder: "请输入密码",
              controller: _passwordController,
              obscureText: true,
            ),
            Padding(padding: EdgeInsets.only(bottom: 1)),
            TextInputItem(
              placeholder: "请再次输入密码",
              controller: _repeatPasswordController,
              obscureText: true,
            ),
            Padding(padding: EdgeInsets.only(bottom: 40)),
            InkWell(
              onTap: registerHandler,
              child: Container(
                color: Theme.of(context).backgroundColor,
                height: 50,
                child: Center(child: Text("注册")),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
