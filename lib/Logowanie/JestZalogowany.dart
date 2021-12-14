import 'dart:async';
import 'package:skladappka/Firebase/DoLogowania/doRejestracji.dart';
import 'package:skladappka/Firebase/DoLogowania/DoLogowania.dart';
import 'package:skladappka/Cache.dart' as globalna;
import 'package:flutter/material.dart';
import 'package:skladappka/Logowanie/Zalogowany.dart';
import 'package:skladappka/main.dart';
import 'package:skladappka/Firebase/FireBase.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skladappka/Firebase/Gpu.dart';
import 'dart:core';
import 'package:skladappka/Logowanie/Status.dart';
import 'package:skladappka/Firebase/Builds.dart';



class isLogged extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<doRejestracji>(context);

    // return either the Home or Authenticate widget
    if (globalna.czyZalogowany=="czyZalogowany=false"){
      return Status();
    } else {
      return StreamProvider<List<Builds>>.value(
        value: FireBase().builds,
        initialData: [],
        child: Zalogowany(),
      );
    }

  }
}