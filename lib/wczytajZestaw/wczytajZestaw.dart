import 'package:flutter/material.dart';
import 'package:skladappka/main.dart';
import 'package:skladappka/Globalne.dart' as globalna;

class wczytajZestaw extends StatefulWidget {
  wczytajZestaw({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _wczytajZestaw createState() => _wczytajZestaw();
}
class _wczytajZestaw extends State<wczytajZestaw>{    

  @override
  Widget build(BuildContext context) { //build context gives the layout, when you build widget it will always have this line
    return Center(
        child: Text("wczytanko"),
      );
  }
}