import 'dart:async';
import 'package:skladappka/Firebase/doLogowanie/doRejestracji.dart';
import 'package:skladappka/Firebase/doLogowanie/doLogowanie.dart';
import 'package:skladappka/Globalne.dart' as globalna;
import 'package:flutter/material.dart';
import 'package:skladappka/main.dart';
import 'package:skladappka/Firebase/FireBase.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skladappka/Firebase/Gpu.dart';
import 'dart:core';
import 'package:skladappka/Logowanie/Status.dart';
import 'package:skladappka/Logowanie/isLogged.dart';
import 'package:skladappka/dodawanieZestawu/dodaj.dart';
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