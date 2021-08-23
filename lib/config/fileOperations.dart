import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class fileReader{
  void save(String data) async{
    Directory appDocDir = await getExternalStorageDirectory();
    String filePath = appDocDir.path + '/file.txt';
    File f = File(filePath);
    f.writeAsString(data);
  }

   Future<String> read() async{
    Directory appDocDir = await getExternalStorageDirectory();
    String filePath = appDocDir.path + '/file.txt';
    File f = File(filePath);
    String text=await f.readAsString();
    return text;
  }
}