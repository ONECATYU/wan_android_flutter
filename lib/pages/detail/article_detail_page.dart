import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:wan_android_flutter/util/iconfont.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleDetailPage extends StatefulWidget {
  ArticleDetailPage({
    Key key,
    this.url,
    this.title,
    this.id,
  }) : super(key: key);

  final String url;
  final String title;
  final String id;

  @override
  State<StatefulWidget> createState() {
    return _ArticleDetailPageState();
  }
}

class _ArticleDetailPageState extends State<ArticleDetailPage> {
  VoidCallback _hideLoading;

  collectActionTapHandler() {

  }

  @override
  Widget build(BuildContext context) {
    Widget titleWidget;
    if (widget.title != null) {
      titleWidget =
          Text(widget.title, style: Theme.of(context).textTheme.title);
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: titleWidget,
        actions: <Widget>[
          InkWell(
            child: Container(
              width: 58,
              child: Icon(IconFont.heart, color: Colors.red, size: 22),
            ),
            onTap: collectActionTapHandler,
          ),
        ],
      ),
      body: WebView(
        initialUrl: widget.url,
        javascriptMode: JavascriptMode.unrestricted,
        onPageStarted: (url) {
          _hideLoading = BotToast.showLoading();
        },
        onPageFinished: (url) => _hideLoading(),
      ),
    );
  }
}
