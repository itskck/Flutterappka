import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skladappka/Firebase/doLogowanie/doRejestracji.dart';
import 'package:skladappka/Logowanie/Zalogowany.dart';
import 'package:skladappka/Logowanie/Wylogowany.dart';

class Status extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final uzytkownik=Provider.of<doRejestracji>(context);
    print(uzytkownik);
    if(uzytkownik!=null)
    return Zalogowany();
    else
      return Wylogowany();
  }
}