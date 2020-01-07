import 'package:flutter/material.dart';

class IconFont {
  static IconData home = icon(0xe608);
  static IconData tree = icon(0xe604);
  static IconData publicPlat = icon(0xe664);
  static IconData project = icon(0xe66c);
  static IconData user = icon(0xe60d);

  static IconData heart = icon(0xe613);
  static IconData heartSolid = icon(0xe60c);
  static IconData setting = icon(0xe619);
  static IconData share = icon(0xe61b);
  static IconData integral = icon(0xe61a);

  static IconData aboutMe = icon(0xe629);
  static IconData lock = icon(0xe7c6);
  static IconData switch_ = icon(0xe60a);

  static IconData icon(int codePoint) =>
      IconData(codePoint, fontFamily: "iconfont");
}