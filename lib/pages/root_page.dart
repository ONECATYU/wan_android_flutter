import 'package:flutter/material.dart';
import '../components/bottom_tab_bar.dart';

import 'package:wan_android_flutter/pages/home/home_page.dart';
import 'package:wan_android_flutter/pages/cate/cate_page.dart';
import 'package:wan_android_flutter/pages/public_plat/public_plat_page.dart';
import 'package:wan_android_flutter/pages/project/project_page.dart';
import 'package:wan_android_flutter/pages/user/user_page.dart';

class _RootBarItemData {
  int codePoint;
  String title;

  _RootBarItemData({this.codePoint, this.title});
}

class RootPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RootPageState();
  }
}

class _RootPageState extends State<RootPage> {
  int selectedIndex = 0;
  List<_RootBarItemData> barItemList = [
    _RootBarItemData(codePoint: 0xe608, title: "首页"),
    _RootBarItemData(codePoint: 0xe604, title: "体系"),
    _RootBarItemData(codePoint: 0xe664, title: "公众号"),
    _RootBarItemData(codePoint: 0xe66c, title: "项目"),
    _RootBarItemData(codePoint: 0xe60d, title: "我的"),
  ];
  List<Widget> pages = [
    HomePage(),
    CatePage(),
    PublicPlatPage(),
    ProjectPage(),
    UserPage(),
  ];

  tabBarDidSelected(int index) {
    if (index != selectedIndex) {
      setState(() {
        selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        children: pages,
        index: selectedIndex,
      ),
      bottomNavigationBar: BottomTabBar(
        itemCount: barItemList.length,
        itemBuilder: (index) {
          _RootBarItemData itemData = barItemList[index];
          Color color = selectedIndex == index
              ? Theme.of(context).primaryColor
              : Colors.grey;
          IconData iconData =
              IconData(itemData.codePoint, fontFamily: "iconfont");
          return BottomTabBarItem(
            icon: Icon(iconData, color: color),
            title: Text(itemData.title, style: TextStyle(color: color)),
          );
        },
        didSelected: tabBarDidSelected,
      ),
    );
  }
}
