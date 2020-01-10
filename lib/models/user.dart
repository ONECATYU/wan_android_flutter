import 'package:wan_android_flutter/util/flie_util.dart';

class UserModel {
  bool admin;
  List<int> chapterTops;
  List<int> collectIds;
  String email;
  String icon;
  int id;
  String nickname;
  String password;
  String publicName;
  String token;
  int type;
  String username;

  int coinCount;
  int rank;

  String get displayName => nickname ?? publicName ?? username;

  static Future<UserModel> loadFromLocal() async {
    var json = await FileUtil.readJSON(fileName: "user");
    if (json == null) return null;
    return UserModel.fromJson(json);
  }

  static removeFromLocal() {
    FileUtil.write(json: null, fileName: "user");
  }

  saveToLocal() {
    var json = toJson();
    FileUtil.write(json: json, fileName: "user");
  }

  UserModel({
    this.admin,
    this.chapterTops,
    this.collectIds,
    this.email,
    this.icon,
    this.id,
    this.nickname,
    this.password,
    this.publicName,
    this.token,
    this.type,
    this.username,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    admin = json['admin'];
    chapterTops = json['collectIds'].cast<int>();
    collectIds = json['collectIds'].cast<int>();
    email = json['email'];
    icon = json['icon'];
    id = json['id'];
    nickname = json['nickname'];
    password = json['password'];
    publicName = json['publicName'];
    token = json['token'];
    type = json['type'];
    username = json['username'];
    coinCount = json['coinCount'];
    rank = json['rank'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['admin'] = this.admin;
    data['chapterTops'] = this.chapterTops;
    data['collectIds'] = this.collectIds;
    data['email'] = this.email;
    data['icon'] = this.icon;
    data['id'] = this.id;
    data['nickname'] = this.nickname;
    data['password'] = this.password;
    data['publicName'] = this.publicName;
    data['token'] = this.token;
    data['type'] = this.type;
    data['username'] = this.username;
    data['coinCount'] = this.coinCount;
    data['rank'] = this.rank;
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
