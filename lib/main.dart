import 'package:flutter/material.dart';
import 'package:wan_android_flutter/pages/root_page.dart';
import 'package:provider/provider.dart';

import 'package:wan_android_flutter/provider/theme.dart';
import 'package:wan_android_flutter/router/router.dart';

void main() {
  AppRouter.register();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeManager>.value(
          value: ThemeManager(appTheme: AppLightTheme()),
        ),
      ],
      child: Consumer<ThemeManager>(builder: (context, themeManager, _) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: themeManager.themeData,
          home: RootPage(),
        );
      }),
    );
  }
}
