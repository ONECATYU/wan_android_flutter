import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:wan_android_flutter/components/article_card.dart';
import 'package:wan_android_flutter/models/article.dart';
import 'package:wan_android_flutter/network/base.dart';
import 'package:wan_android_flutter/network/user.dart';

class UserCollectPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _UserCollectPageState();
  }
}

class _UserCollectPageState extends State<UserCollectPage> {
  List<ArticleModel> _articleList = [];

  getData({int page = 0}) async {
    Result result = await getUserCollectionList(page: page);
    if (!result.success) {
      BotToast.showText(text: result.errorMsg);
      return;
    }
    List<ArticleModel> models = [];
    if (page > 0) {
      models.addAll(_articleList);
    }
    models.addAll(result.model);
    setState(() {
      _articleList = models;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("我的收藏", style: Theme.of(context).textTheme.title),
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(12),
        separatorBuilder: (context, index) {
          return Padding(padding: EdgeInsets.only(bottom: 12));
        },
        itemCount: _articleList.length,
        itemBuilder: (context, index) {
          ArticleModel model = _articleList[index];
          return ArticleCard.fromArticleListModel(model);
        },
      ),
    );
  }
}
