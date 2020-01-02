import 'package:flutter/material.dart';

class ThemeManager extends ChangeNotifier {
  ThemeData _themeData;
  ThemeData get currentTheme => _themeData;

  ThemeManager({ThemeData themeData}) {
    _themeData = themeData;
  }

  void changeTheme(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }
}

class AppTheme {
  static ThemeData normal = ThemeData(
    primaryColor: Color(0xff52b6f4),
    backgroundColor: Colors.white,
    scaffoldBackgroundColor: Color(0xfff0f0f0),
    textTheme: TextTheme(
      title: TextStyle(
        fontSize: 18,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      subtitle: TextStyle(
        fontSize: 15,
        color: Colors.grey[800],
        fontWeight: FontWeight.normal,
      ),
    ),
  );
  static ThemeData dark = ThemeData(
    primaryColor: Color(0xff52b6f4),
    backgroundColor: Color.fromRGBO(60, 63, 65, 1),
    scaffoldBackgroundColor: Color.fromRGBO(42, 42, 42, 1),
    textTheme: TextTheme(
      title: TextStyle(
        fontSize: 18,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      subtitle: TextStyle(
        fontSize: 15,
        color: Colors.grey,
        fontWeight: FontWeight.normal,
      ),
    ),
  );
}
