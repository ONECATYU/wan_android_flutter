import 'package:flutter/material.dart';
import '../components/bottom_tab_bar.dart';

import 'package:wan_android_flutter/pages/home/home_page.dart';
import 'package:wan_android_flutter/pages/cate/cate_page.dart';
import 'package:wan_android_flutter/pages/public_plat/public_plat_page.dart';
import 'package:wan_android_flutter/pages/project/project_page.dart';
import 'package:wan_android_flutter/pages/user/user_page.dart';
import 'package:wan_android_flutter/util/iconfont.dart';

class _RootBarItemData {
  IconData icon;
  String title;

  _RootBarItemData({this.icon, this.title});
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
    _RootBarItemData(icon: IconFont.home, title: "首页"),
    _RootBarItemData(icon: IconFont.tree, title: "体系"),
    _RootBarItemData(icon: IconFont.publicPlat, title: "公众号"),
    _RootBarItemData(icon: IconFont.project, title: "项目"),
    _RootBarItemData(icon: IconFont.user, title: "我的"),
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
          return BottomTabBarItem(
            icon: Icon(itemData.icon, color: color),
            title: Text(itemData.title, style: TextStyle(color: color)),
          );
        },
        didSelected: tabBarDidSelected,
      ),
    );
  }
}
