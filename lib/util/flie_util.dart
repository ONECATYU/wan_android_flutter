import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileUtil {
  static Future<String> localPath() async {
    var appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    return appDocPath;
  }

  static write({dynamic json, String fileName}) async {
    String path = await localPath();
    path = "$path/$fileName";
    File file = File(path);
    if (json == null) {
      file.delete();
      return;
    }
    String jsonStr = jsonEncode(json);
    if (jsonStr == null) return;
    file.writeAsString(jsonStr);
  }

  static Future<dynamic> readJSON({String fileName}) async {
    String path = await localPath();
    path = "$path/$fileName";
    File file = File(path);
    if (!file.existsSync()) return null;
    String jsonStr = file.readAsStringSync();
    var object = jsonDecode(jsonStr);
    return object;
  }
}
