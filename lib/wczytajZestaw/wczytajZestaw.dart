import 'package:flutter/material.dart';
import 'package:skladappka/main.dart';
import 'package:skladappka/Globalne.dart' as globalna;
import 'package:skladappka/wczytajZestaw/choices.dart';

class wczytajZestaw extends StatelessWidget{    
  
  int currentScreen = 0;
  //widoki: guziki, wypisywanie z kodu, wybieranie z konta, wyswietlanie
  List<Widget> Views = [
    choices()
    
  ];
  @override
  Widget build(BuildContext context) { //build context gives the layout, when you build widget it will always have this line
    return Container(
      child: Views[currentScreen],
    ); 
  }
}