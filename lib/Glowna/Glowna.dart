import 'package:flutter/material.dart';
import 'package:skladappka/main.dart';
import 'package:skladappka/Globalne.dart' as globalna;

class Glowna extends StatefulWidget {
  Glowna({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _Glowna createState() => _Glowna();
}
class _Glowna extends State<Glowna>{ 
  @override
  Widget build(BuildContext context) {
    return  Center(
        child: Text("Glowna"),
      );
  }
}