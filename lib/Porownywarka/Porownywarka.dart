import 'package:flutter/material.dart';
import 'package:skladappka/main.dart';
import 'package:skladappka/Globalne.dart' as globalna;

class Porownywarka extends StatefulWidget {
  Porownywarka({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _Porownywarka createState() => _Porownywarka();
}
class _Porownywarka extends State<Porownywarka>{
  
  @override
  Widget build(BuildContext context) { //build context gives the layout, when you build widget it will always have this line
    return Center(
        child: Text("Porownywarka"),
      );
  }
}