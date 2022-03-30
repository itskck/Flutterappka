import 'dart:async';
import 'package:skladappka/Firebase/DoLogowania/doRejestracji.dart';
import 'package:skladappka/Firebase/DoLogowania/DoLogowania.dart';
import 'package:skladappka/Cache.dart' as cache;
import 'package:flutter/material.dart';
import 'package:skladappka/main.dart';
import 'package:skladappka/Firebase/FireBase.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skladappka/Firebase/Gpu.dart';
import 'dart:core';
import 'package:skladappka/Logowanie/Status.dart';
import 'package:skladappka/Logowanie/JestZalogowany.dart';
import 'package:skladappka/dodawanieZestawu/Dodaj.dart';
class Logowanie extends StatefulWidget {
  final Function callback;


  Logowanie({this.callback});

  @override
  _Logowanie createState() => _Logowanie();
}
class _Logowanie extends State<Logowanie>{
  Future<bool> isItAlive() async{
    if(await doLogowanie().user.isEmpty)
      return false;
    else
      return true;
  }
  @override
  Widget build(BuildContext context) { //build context gives the layout, when you build widget it will always have this line
    return StreamProvider<doRejestracji>.value(
      value: doLogowanie().user,
      initialData: null,
      child: FutureBuilder(
        future: isItAlive(),
        builder: (context, isAlive){
          if(isAlive.connectionState==ConnectionState.done){
            return Container(
              child: isAlive.hasData==true ? isLogged() :  Center(child: CircularProgressIndicator()),
            );
          }
          else return Container();
        },
      ),

      );
  }
}