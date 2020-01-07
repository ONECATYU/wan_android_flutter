import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UserHeaderWidget extends StatelessWidget {
  UserHeaderWidget({
    Key key,
    this.headImgUrl,
    this.nickName,
    this.id,
    this.ranking,
    this.grade,
  }) : super(key: key);

  final String headImgUrl;
  final String nickName;
  final String id;
  final String ranking;
  final String grade;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      child: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(
              width: 70,
              height: 70,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(35),
                child: headImgUrl == null
                    ? Container(color: themeData.backgroundColor)
                    : CachedNetworkImage(
                        imageUrl: "$headImgUrl",
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            Padding(padding: EdgeInsets.only(bottom: 12)),
            Text(
              nickName,
              style: themeData.textTheme.title.copyWith(fontSize: 22),
            ),
            DefaultTextStyle(
              style: themeData.textTheme.subtitle,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("ID: $id"),
                  Padding(padding: EdgeInsets.only(right: 10)),
                  Text("等级: $grade"),
                  Padding(padding: EdgeInsets.only(right: 10)),
                  Text("排名: $ranking"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
