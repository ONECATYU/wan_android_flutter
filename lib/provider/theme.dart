import 'package:flutter/material.dart';

class ThemeManager extends ChangeNotifier {
  ThemeData _themeData;
  AppTheme _appTheme;

  ThemeData get themeData => _themeData;

  AppTheme get currentTheme => _appTheme;

  bool get isDark => (_appTheme != null && _appTheme is AppDarkTheme);

  ThemeManager({AppTheme appTheme}) {
    _appTheme = appTheme;
    _themeData = _createThemeData(appTheme);
  }

  changeTheme(AppTheme appTheme) {
    _themeData = _createThemeData(appTheme);
    notifyListeners();
  }

  switchToDark(bool isDark) async {
    AppTheme appTheme = isDark ? AppDarkTheme() : AppLightTheme();
    _appTheme = appTheme;
    _themeData = _createThemeData(appTheme);
    notifyListeners();
  }
}

ThemeData _createThemeData(AppTheme theme) {
  TextTheme textTheme = TextTheme(
    title: TextStyle(color: theme.titleColor),
    subhead: TextStyle(color: theme.titleColor),
    subtitle: TextStyle(color: theme.subTitleColor),
    body1: TextStyle(color: theme.titleColor, fontSize: 15),
  );
  return ThemeData(
    primaryColor: theme.primaryColor,
    backgroundColor: theme.backgroundColor,
    scaffoldBackgroundColor: theme.scaffoldBackgroundColor,
    textTheme: textTheme,
    appBarTheme: AppBarTheme(
      color: theme.backgroundColor,
      elevation: 0.0,
      textTheme: textTheme,
      iconTheme: IconThemeData(
        color: theme.titleColor,
      ),
    ),
  );
}

abstract class AppTheme {
  Color get primaryColor;

  Color get backgroundColor;

  Color get scaffoldBackgroundColor;

  Color get titleColor;

  Color get subTitleColor;
}

class AppLightTheme implements AppTheme {
  final Color primaryColor = Color(0xff52b6f4);
  final Color backgroundColor = Colors.white;
  final Color scaffoldBackgroundColor = Color(0xfff0f0f0);
  final Color titleColor = Colors.black;
  final Color subTitleColor = Colors.grey[600];
}

class AppDarkTheme implements AppTheme {
  final Color primaryColor = Color(0xff52b6f4);
  final Color backgroundColor = Color.fromRGBO(60, 63, 65, 1);
  final Color scaffoldBackgroundColor = Color.fromRGBO(42, 42, 42, 1);
  final Color titleColor = Colors.white;
  final Color subTitleColor = Colors.grey;
}
