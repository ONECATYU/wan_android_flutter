import 'package:flutter/material.dart';
import 'package:wan_android_flutter/models/article.dart';
import 'package:wan_android_flutter/util/string_util.dart';

class ArticleCard extends StatelessWidget {
  ArticleCard({
    Key key,
    this.backgroundColor,
    this.title,
    this.content,
    this.timeDesc,
    this.author,
    this.chapterName,
    this.isNew = false,
    this.isTop = false,
    this.isCollected = false,
    this.collectClick,
  }) : super(key: key);

  final Color backgroundColor;

  final String title;
  final String content;
  final String timeDesc;
  final String author;
  final String chapterName;

  final bool isNew;
  final bool isTop;
  final bool isCollected;

  final VoidCallback collectClick;

  factory ArticleCard.fromArticleListModel(
    ArticleListModel model, {
    VoidCallback collectClick,
  }) {
    return ArticleCard(
      title: model.title.trimHTML(),
      content: model.desc.trimHTML(),
      author: model.author.isNotEmpty ? model.author : model.shareUser,
      chapterName: model.chapterName + "·" + model.superChapterName,
      isNew: model.fresh,
      isTop: model.isTop,
      timeDesc: model.niceDate,
      isCollected: model.collect,
      collectClick: collectClick,
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: backgroundColor ?? Theme.of(context).backgroundColor,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              RichText(
                text: TextSpan(
                  children: [
                    if (isNew)
                      TextSpan(
                        text: "new   ",
                        style: themeData.textTheme.subtitle.copyWith(
                          fontSize: 12,
                          color: themeData.primaryColor,
                        ),
                      ),
                    TextSpan(
                      text: "$author",
                      style: themeData.textTheme.subtitle.copyWith(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                timeDesc,
                style: themeData.textTheme.subtitle.copyWith(
                  fontSize: 12,
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 3),
            child: Text(
              "$title",
              style: themeData.textTheme.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (content != null && content.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(bottom: 3),
              child: Text(
                content,
                style: themeData.textTheme.subtitle,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              RichText(
                text: TextSpan(
                  children: [
                    if (isTop)
                      TextSpan(
                        text: "置顶   ",
                        style: themeData.textTheme.subtitle.copyWith(
                          fontSize: 12,
                          color: Colors.orange,
                        ),
                      ),
                    TextSpan(
                      text: chapterName,
                      style: themeData.textTheme.subtitle.copyWith(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: collectClick,
                child: Icon(
                  IconData(isCollected ? 0xe60c : 0xe613,
                      fontFamily: "iconfont"),
                  size: 20,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
