import 'package:flutter/material.dart';
import 'package:skladappka/Firebase/Case.dart';
import 'package:skladappka/Firebase/Cooler.dart';
import 'package:skladappka/Firebase/Cpu.dart';
import 'package:provider/provider.dart';
import 'package:skladappka/Firebase/Drive.dart';
import 'package:skladappka/Firebase/Gpu.dart';
import 'package:skladappka/Firebase/Motherboard.dart';
import 'package:skladappka/Firebase/Psu.dart';
import 'package:skladappka/Firebase/Ram.dart';
import 'dart:core';
import 'dodaj.dart';
class dialogBuilder extends StatelessWidget{
  String component;
  var cpus,psus,gpus,coolers,mtbs,drives,cases,rams;  
  dialogBuilder({this.component});
  @override
  Widget build(BuildContext context) {
    
    if(component=='CPU'){
    cpus = Provider.of<List<Cpu>>(context)??[];
    return SimpleDialog(
      title: Text('Choose your $component'),
      children: [             
        for(int i=0;i<cpus.length ; i++)
          SimpleDialogOption(
            padding: EdgeInsets.symmetric(horizontal: 25,vertical: 25),
            child: Text(cpus[i].model.toString()),
            onPressed: (){
              dodaj.chosenCpu = cpus[i];
              Navigator.pop(context);
            },
          )]);}
    if(component=='PSU'){
    psus = Provider.of<List<Psu>>(context)??[];
    return SimpleDialog(
        title: Text('Choose your $component'),
        children: [
    for(int i=0;i<psus.length ; i++)
          SimpleDialogOption(
            padding: EdgeInsets.symmetric(horizontal: 25,vertical: 25),
            child: Text(psus[i].model.toString()),
            onPressed: (){
              dodaj.chosenPsu = psus[i];
              Navigator.pop(context);
            },
          )]);}

    if(component=='GPU'){
    gpus = Provider.of<List<Gpu>>(context)??[];
    return SimpleDialog(
      title: Text('Choose your $component'),
      children: [             
        for(int i=0;i<gpus.length ; i++)
          SimpleDialogOption(
            padding: EdgeInsets.symmetric(horizontal: 25,vertical: 25),
            child: Text(gpus[i].model.toString()),
            onPressed: (){
              dodaj.chosenGpu = gpus[i];
              Navigator.pop(context);
            },
          )]);}

    if(component=='CSTM COOLER'){
    coolers = Provider.of<List<Cooler>>(context)??[];
    return SimpleDialog(
      title: Text('Choose your $component'),
      children: [             
        for(int i=0;i<coolers.length ; i++)
          SimpleDialogOption(
            padding: EdgeInsets.symmetric(horizontal: 25,vertical: 25),
            child: Text(coolers[i].model.toString()),
            onPressed: (){
              dodaj.chosenCooler = coolers[i];
              Navigator.pop(context);
            },
          )]);}

    if(component=='MTBRD'){
    mtbs = Provider.of<List<Motherboard>>(context)??[];
    return SimpleDialog(
      title: Text('Choose your $component'),
      children: [             
        for(int i=0;i<mtbs.length ; i++)
          SimpleDialogOption(
            padding: EdgeInsets.symmetric(horizontal: 25,vertical: 25),
            child: Text(mtbs[i].model.toString()),
            onPressed: (){
              dodaj.chosenMtb = mtbs[i];
              Navigator.pop(context);
            },
          )]);}

    if(component=='DRIVE'){
    drives = Provider.of<List<Drive>>(context)??[];
    return SimpleDialog(
      title: Text('Choose your $component'),
      children: [             
        for(int i=0;i<drives.length ; i++)
          SimpleDialogOption(
            padding: EdgeInsets.symmetric(horizontal: 25,vertical: 25),
            child: Text(drives[i].model.toString()),
            onPressed: (){
              dodaj.chosenDrive = drives[i];
              Navigator.pop(context);
            },
              )]);}

    if(component=='CASE'){
    cases = Provider.of<List<Case>>(context)??[];
    return SimpleDialog(
      title: Text('Choose your $component'),
      children: [             
        for(int i=0;i<cases.length ; i++)
          SimpleDialogOption(
            padding: EdgeInsets.symmetric(horizontal: 25,vertical: 25),
            child: Text(cases[i].model.toString()),
            onPressed: (){
              dodaj.chosenCase = cases[i];
              Navigator.pop(context);
            },
          )]);}

    if(component=='RAM'){
    rams = Provider.of<List<Ram>>(context)??[];
    return SimpleDialog(
      title: Text('Choose your $component'),
      children: [             
        for(int i=0;i<rams.length ; i++)
          SimpleDialogOption(
            padding: EdgeInsets.symmetric(horizontal: 25,vertical: 25),
            child: Text(rams[i].model.toString()),
            onPressed: (){
              dodaj.chosenRam = rams[i];
              Navigator.pop(context);
            },
          )]);} 
  }}