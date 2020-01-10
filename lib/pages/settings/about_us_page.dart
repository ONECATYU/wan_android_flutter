import 'package:flutter/material.dart';
import 'mardown_scaffold.dart';

var _aboutUsContent = """
## 网站内容  
本网站每天新增20~30篇优质文章，并加入到现有分类中，力求整理出一份优质而又详尽的知识体系，闲暇时间不妨上来学习下知识； 除此以外，并为大家提供平时开发过程中常用的工具以及常用的网址导航。  

当然这只是我们目前的功能，未来我们将提供更多更加便捷的功能...  
如果您有任何好的建议:  
- 关于网站排版  
- 关于新增常用网址以及工具  
- 未来你希望增加的功能等  

可以在https://github.com/hongyangAndroid/xueandroid项目中以issue的形式提出，我将及时跟进。
""";

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MarkdownScaffold(
      title: "关于我们",
      content: _aboutUsContent,
    );
  }
}