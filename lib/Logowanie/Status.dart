import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skladappka/Firebase/doLogowanie/doRejestracji.dart';
import 'package:skladappka/Logowanie/Zalogowany.dart';
import 'package:skladappka/Logowanie/Wylogowany.dart';
import 'package:skladappka/Logowanie/haveAcc.dart';
import 'package:skladappka/Globalne.dart' as globalna;
import 'package:skladappka/Logowanie/haveAcc.dart';

class Status extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final uzytkownik=Provider.of<doRejestracji>(context);
    print(uzytkownik);
    if(globalna.czyZalogowany=="czyZalogowany=true")
      return Zalogowany();
    else if(globalna.haveAcc==false)
      return Wylogowany();
    else
      return haveAcc();
  }
}