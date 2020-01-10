import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:wan_android_flutter/pages/root_page.dart';
import 'package:provider/provider.dart';

import 'package:wan_android_flutter/provider/theme.dart';
import 'package:wan_android_flutter/router/router.dart';
import 'package:wan_android_flutter/provider/user_provider.dart';

void main() {
  registerRouters();
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
        ChangeNotifierProvider<UserProvider>.value(value: UserProvider()),
      ],
      child: Consumer<ThemeManager>(builder: (context, themeManager, _) {
        return BotToastInit(
          child: MaterialApp(
            title: 'Flutter Demo',
            theme: themeManager.themeData,
            navigatorObservers: [BotToastNavigatorObserver()],
            home: RootPage(),
          ),
        );
      }),
    );
  }
}
