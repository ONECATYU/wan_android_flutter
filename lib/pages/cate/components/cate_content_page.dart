import 'package:flutter/material.dart';

class CateContentPage<T> extends StatefulWidget {
  CateContentPage({
    Key key,
    this.models,
    this.itemBuilder,
  }) : super(key: key);

  final List<T> models;
  final IndexedWidgetBuilder itemBuilder;

  @override
  State<StatefulWidget> createState() {
    return _CateContentPageState();
  }
}

class _CateContentPageState extends State<CateContentPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return ListView.separated(
      padding: EdgeInsets.all(12),
      separatorBuilder: (context, index) {
        return Padding(padding: EdgeInsets.only(bottom: 12));
      },
      itemCount: widget.models != null ? widget.models.length : 0,
      itemBuilder: widget.itemBuilder,
    );
  }
}
