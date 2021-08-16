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
  int _selectedIndex=2;
  void _onItemTapped(int index){
    globalna.ktoro=index;
    inicjalizuj();
  }
  @override
  Widget build(BuildContext context) { //build context gives the layout, when you build widget it will always have this line
    Icon moonIcon;
    if (globalna.currentTheme == 0)
      moonIcon = Icon(
        Icons.brightness_2_outlined,
        color: Colors.white,
      );
    else
      moonIcon = Icon(
        Icons.brightness_2,
        color: Colors.white,
      );
      
    //build context gives the layout, when you build widget it will always have this line
    return  Center(
        child: Text("Glowna"),
      );
  }
}