import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wan_android_flutter/models/article.dart';
import 'package:wan_android_flutter/util/string_util.dart';
import 'package:wan_android_flutter/util/iconfont.dart';

class ArticleCard extends StatelessWidget {
  ArticleCard({
    Key key,
    this.backgroundColor,
    this.title,
    this.content,
    this.timeDesc,
    this.author,
    this.chapterName,
    this.imgUrl,
    this.isNew = false,
    this.isTop = false,
    this.isCollected = false,
    this.collectClick,
    this.onTap,
  }) : super(key: key);

  final Color backgroundColor;

  final String title;
  final String content;
  final String timeDesc;
  final String author;
  final String chapterName;

  final String imgUrl;

  final bool isNew;
  final bool isTop;
  final bool isCollected;

  final VoidCallback collectClick;
  final VoidCallback onTap;

  factory ArticleCard.fromArticleListModel(
    ArticleModel model, {
    VoidCallback collectClick,
    VoidCallback onTap,
  }) {
    return ArticleCard(
      title: model.title.trimHTML(),
      content: model.desc.trimHTML(),
      author: model.author ?? model.shareUser,
      chapterName: model.chapterName ?? "" + "·" + model.superChapterName ?? "",
      isNew: model.fresh ?? false,
      isTop: model.isTop ?? false,
      timeDesc: model.niceDate,
      isCollected: model.collect,
      collectClick: collectClick,
      imgUrl: model.envelopePic,
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget widget = Container(
      padding: EdgeInsets.all(12),
      color: backgroundColor ?? Theme.of(context).backgroundColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildHeader(context),
          ArticleContentWidget(
            padding: EdgeInsets.symmetric(vertical: 8),
            title: title,
            desc: content,
            imgUrl: imgUrl,
          ),
          _buildFooter(context),
        ],
      ),
    );
    if (onTap != null) {
      widget = InkWell(
        onTap: onTap,
        child: widget,
      );
    }
    return widget;
  }

  Widget _buildHeader(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Row(
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
                style: themeData.textTheme.subtitle.copyWith(fontSize: 12),
              ),
            ],
          ),
        ),
        Text(
          timeDesc,
          style: themeData.textTheme.subtitle.copyWith(fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildFooter(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Row(
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
        if (isCollected != null) 
        InkWell(
          onTap: collectClick,
          child: Icon(
            isCollected ? IconFont.heartSolid : IconFont.heart,
            size: 20,
            color: Colors.red,
          ),
        ),
      ],
    );
  }
}

class ArticleContentWidget extends StatelessWidget {
  ArticleContentWidget({
    Key key,
    this.imgUrl,
    this.title,
    this.desc,
    this.padding,
  }) : super(key: key);

  final String imgUrl;
  final String title;
  final String desc;

  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    List<Widget> children = [];
    if (title != null && title.isNotEmpty) {
      children.add(Text(
        "$title",
        style: themeData.textTheme.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ));
      children.add(Padding(padding: EdgeInsets.only(bottom: 2)));
    }
    if (desc != null && desc.isNotEmpty) {
      children.add(Text(
        desc,
        style: themeData.textTheme.subtitle,
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ));
    }
    Widget content = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
    if (imgUrl != null && imgUrl.isNotEmpty) {
      content = Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CachedNetworkImage(
            imageUrl: imgUrl,
            width: 120,
            height: 90,
            fit: BoxFit.cover,
          ),
          Padding(padding: EdgeInsets.only(right: 10)),
          Expanded(
            child: content,
          ),
        ],
      );
    }
    return Container(
      padding: padding,
      child: content,
    );
  }
}
