import 'article.dart';

class NavigateModel {
  List<ArticleModel> articles;
  int cid;
  String name;

  NavigateModel({this.articles, this.cid, this.name});

  NavigateModel.fromJson(Map<String, dynamic> json) {
    if (json['articles'] != null) {
      articles = new List<ArticleModel>();
      json['articles'].forEach((v) {
        articles.add(new ArticleModel.fromJson(v));
      });
    }
    cid = json['cid'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.articles != null) {
      data['articles'] = this.articles.map((v) => v.toJson()).toList();
    }
    data['cid'] = this.cid;
    data['name'] = this.name;
    return data;
  }
}
