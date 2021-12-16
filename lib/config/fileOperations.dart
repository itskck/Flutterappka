import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class fileReader {
  void save(String data, String title) async {
    Directory appDocDir = Platform.isAndroid
        ? await getExternalStorageDirectory() //FOR ANDROID
        : await getApplicationSupportDirectory();
    ;
    String filePath = appDocDir.path + "/" + title + ".txt";
    File f = File(filePath);
    if (await exists(title) == false) {
      await f.create();
    }
    f.writeAsString(data);
  }

  Future<bool> exists(String title) async {
    Directory appDocDir = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationSupportDirectory();
    if (await File(appDocDir.path + "/" + title + ".txt").exists() == true) {
      print("true");
      return true;
    } else {
      print("false");
      return false;
    }
  }

  Future<String> read(String title) async {
    Directory appDocDir = Platform.isAndroid
        ? await getExternalStorageDirectory() //FOR ANDROID
        : await getApplicationSupportDirectory();
    ;
    String filePath = appDocDir.path + "/" + title + ".txt";
    File f = File(filePath);
    if (await exists(title) == false) {
      await f.create();
    }
    String text = await f.readAsString();
    return text;
  }
}
