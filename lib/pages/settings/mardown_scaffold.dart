import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class MarkdownScaffold extends StatelessWidget {
  MarkdownScaffold({
    Key key,
    this.title,
    this.content,
  }) : super(key: key);
  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(title, style: Theme.of(context).textTheme.title),
      ),
      body: Container(
        color: Theme.of(context).backgroundColor,
        child: Markdown(data: content),
      ),
    );
  }
}
