import 'package:flutter/material.dart';
import 'package:wan_android_flutter/pages/user/components/user_header_widget.dart';
import 'package:wan_android_flutter/components/list_item.dart';
import 'package:wan_android_flutter/router/router.dart';
import 'package:wan_android_flutter/util/iconfont.dart';

class UserPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _UserPageState();
  }
}

class _UserPageState extends State<UserPage> {
  Widget _buildListItem({
    IconData iconData,
    String title,
    VoidCallback onTap,
    Color iconColor,
  }) {
    ThemeData themeData = Theme.of(context);
    Color color = themeData.textTheme.subtitle.color;
    return ListItem(
      trailingType: TrailingType.nextIndicator,
      leading:
          Icon(iconData, color: iconColor ?? themeData.primaryColor, size: 21),
      title: Text(title),
      onTap: onTap,
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    Color color = themeData.textTheme.subtitle.color;
    return Scaffold(
      body: Column(
        children: <Widget>[
          UserHeaderWidget(
            headImgUrl: null,
            nickName: "点击登录",
            id: "--",
            grade: "--",
            ranking: "--",
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(12),
              children: <Widget>[
                _buildListItem(
                  title: "我的积分",
                  iconData: IconFont.integral,
                  onTap: () {
                    AppRouter.navigateTo(context, AppPage.userIntegral);
                  },
                ),
                _buildListItem(
                  title: "我的分享",
                  iconData: IconFont.share,
                  onTap: () {
                    AppRouter.navigateTo(context, AppPage.userShare);
                  },
                ),
                _buildListItem(
                  title: "我的收藏",
                  iconData: IconFont.heart,
                  iconColor: Colors.red,
                  onTap: () {
                    AppRouter.navigateTo(context, AppPage.userCollect);
                  },
                ),
                Padding(padding: EdgeInsets.only(bottom: 20)),
                _buildListItem(
                  title: "设置",
                  iconData: IconFont.setting,
                  onTap: () {
                    AppRouter.navigateTo(context, AppPage.settings);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
