import 'package:flutter/material.dart';
import 'package:wan_android_flutter/models/user.dart';

class UserProvider extends ChangeNotifier {
  UserModel _user;

  UserModel get loginUser => _user;

  bool get isLogin => (_user != null && _user.id != null);

  changeUser(UserModel userModel) {
    _user = userModel;
    notifyListeners();
  }
}
