import 'package:flutter/material.dart';
import 'package:skladappka/Firebase/Case.dart';
import 'package:skladappka/Firebase/Cooler.dart';
import 'package:skladappka/Firebase/Cpu.dart';
import 'package:provider/provider.dart';
import 'package:skladappka/Firebase/Drive.dart';
import 'package:skladappka/Firebase/FireBase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skladappka/Firebase/Gpu.dart';
import 'package:skladappka/Firebase/Motherboard.dart';
import 'package:skladappka/Firebase/Psu.dart';
import 'package:skladappka/Firebase/Ram.dart';
import 'dart:core';
import 'dodaj.dart';
import 'dialogBuilder.dart';

class dialogWidget {

  /* Widget builder(String component,BuildContext context){
    final cpus = Provider.of<List<Cpu>>(context)??[];
    return SimpleDialog(
      title: Text('Choose your'),
      children: [
        for(int i=0;i<cpus.length ; i++)
          SimpleDialogOption(
            padding: EdgeInsets.symmetric(horizontal: 25,vertical: 25),
            child: Text('gruszka'),
            onPressed: (){
              Navigator.pop(context);
              dodaj(chosenCPU: 'tramwaj.pptx');
              
            },
          )
      ],

    );
  } */
  Future<void> showPopup(BuildContext context, String component, FireBase base) async {
    await showDialog(
        context: context,
        builder: (BuildContext c) => popupWindow(c, component, base));
  }

  Widget popupWindow(BuildContext context, String component, FireBase base) {
    if (component == 'CPU')
      return StreamProvider<List<Cpu>>.value(
        value: base.cpus,
        initialData: [],
        child: dialogBuilder(component: component),
      );

    if (component == 'PSU')
      return StreamProvider<List<Psu>>.value(
        value: base.psus,
        initialData: [],
        child: dialogBuilder(component: component),
      );

    if (component == 'GPU')
      return StreamProvider<List<Gpu>>.value(
        value: base.gpus,
        initialData: [],
        child: dialogBuilder(component: component),
      );

    if (component == 'CSTM COOLER')
      return StreamProvider<List<Cooler>>.value(
        value: base.coolers,
        initialData: [],
        child: dialogBuilder(component: component),
      );

    if (component == 'MTBRD') {
      print(",,,,,,,,,,,,,,,,,");
      print(base.ramRamType);
      print(".....................");
      return StreamProvider<List<Motherboard>>.value(
        value: base.motherboards,
        initialData: [],
        child: dialogBuilder(component: component),
      );
    }
    if (component == 'DRIVE')
      return StreamProvider<List<Drive>>.value(
        value: base.drives,
        initialData: [],
        child: dialogBuilder(component: component),
      );

    if (component == 'CASE')
      return StreamProvider<List<Case>>.value(
        value: base.cases,
        initialData: [],
        child: dialogBuilder(component: component),
      );

    if (component == 'RAM')
      return StreamProvider<List<Ram>>.value(
        value: base.rams,
        initialData: [],
        child: dialogBuilder(component: component),
      );
  }
}
