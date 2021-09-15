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
class Logowanie extends StatefulWidget {
  Logowanie({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _Logowanie createState() => _Logowanie();
}
class _Logowanie extends State<Logowanie>{
  @override
  Widget build(BuildContext context) { //build context gives the layout, when you build widget it will always have this line
    return StreamProvider<doRejestracji>.value(
      value: doLogowanie().user,
      initialData: null,
      child: Container(
        
        child: isLogged(),
      ),
    );
  }
}