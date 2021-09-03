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
import 'package:skladappka/dodawanieZestawu/dialogWidget.dart';
import 'dodaj.dart';
class dialogBuilder extends StatelessWidget{
  String component;
  
  final d = new dodaj();
  dialogBuilder({this.component});
  @override
  Widget build(BuildContext context) {
    final cpus = Provider.of<List<Cpu>>(context)??[];
    final psus = Provider.of<List<Psu>>(context)??[];
    final gpus = Provider.of<List<Gpu>>(context)??[];
    final coolers = Provider.of<List<Cooler>>(context)??[];
    final mtbs = Provider.of<List<Motherboard>>(context)??[];
    final drives = Provider.of<List<Drive>>(context)??[];
    final cases = Provider.of<List<Case>>(context)??[];
    final rams = Provider.of<List<Ram>>(context)??[];
    
    return SimpleDialog(
      title: Text('Choose your $component'),
      children: [ 
        if(component=='CPU')       
        for(int i=0;i<cpus.length ; i++)
          SimpleDialogOption(
            padding: EdgeInsets.symmetric(horizontal: 25,vertical: 25),
            child: Text(cpus[i].model.toString()),
            onPressed: (){
              dodaj.chosenCpu = cpus[i];
              Navigator.pop(context);
            },
          ), 
        if(component=='PSU')       
        for(int i=0;i<psus.length ; i++)
          SimpleDialogOption(
            padding: EdgeInsets.symmetric(horizontal: 25,vertical: 25),
            child: Text(psus[i].model.toString()),
            onPressed: (){
              dodaj.chosenPsu = psus[i];
              Navigator.pop(context);
            },
          ),
          if(component=='GPU')       
        for(int i=0;i<gpus.length ; i++)
          SimpleDialogOption(
            padding: EdgeInsets.symmetric(horizontal: 25,vertical: 25),
            child: Text(gpus[i].model.toString()),
            onPressed: (){
              dodaj.chosenGpu = gpus[i];
              Navigator.pop(context);
            },
          ),
          if(component=='CSTM COOLER')       
        for(int i=0;i<coolers.length ; i++)
          SimpleDialogOption(
            padding: EdgeInsets.symmetric(horizontal: 25,vertical: 25),
            child: Text(coolers[i].model.toString()),
            onPressed: (){
              dodaj.chosenCooler = coolers[i];
              Navigator.pop(context);
            },
          ),
          if(component=='MTBRD')       
        for(int i=0;i<mtbs.length ; i++)
          SimpleDialogOption(
            padding: EdgeInsets.symmetric(horizontal: 25,vertical: 25),
            child: Text(mtbs[i].model.toString()),
            onPressed: (){
              dodaj.chosenMtb = mtbs[i];
              Navigator.pop(context);
            },
          ),
          if(component=='DRIVE')       
        for(int i=0;i<drives.length ; i++)
          SimpleDialogOption(
            padding: EdgeInsets.symmetric(horizontal: 25,vertical: 25),
            child: Text(drives[i].model.toString()),
            onPressed: (){
              dodaj.chosenDrive = drives[i];
              Navigator.pop(context);
            },
          ),
          if(component=='CASE')       
        for(int i=0;i<cases.length ; i++)
          SimpleDialogOption(
            padding: EdgeInsets.symmetric(horizontal: 25,vertical: 25),
            child: Text(cases[i].model.toString()),
            onPressed: (){
              dodaj.chosenCase = cases[i];
              Navigator.pop(context);
            },
          ),
          if(component=='RAM')       
        for(int i=0;i<rams.length ; i++)
          SimpleDialogOption(
            padding: EdgeInsets.symmetric(horizontal: 25,vertical: 25),
            child: Text(rams[i].model.toString()),
            onPressed: (){
              dodaj.chosenRam = rams[i];
              Navigator.pop(context);
            },
          )
      ],

    );
  }
}