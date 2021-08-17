import 'package:flutter/material.dart';
import 'package:skladappka/main.dart';
import 'package:skladappka/Globalne.dart' as globalna;

class Wylogowany extends StatefulWidget {
  Wylogowany({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _Wylogowany createState() => _Wylogowany();
}
class _Wylogowany extends State<Wylogowany>{

  @override
  Widget build(BuildContext context) { //build context gives the layout, when you build widget it will always have this line
    return Center(
      child: Text("Wylogowany"),
    );
  }
}