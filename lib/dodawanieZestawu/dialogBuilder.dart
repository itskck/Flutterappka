import 'package:flutter/material.dart';
import 'package:skladappka/Firebase/Cpu.dart';
import 'package:provider/provider.dart';
import 'package:skladappka/Firebase/FireBase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:core';
import 'package:skladappka/dodawanieZestawu/dialogWidget.dart';

class dialogBuilder extends StatelessWidget{
  String component;
  dialogBuilder({this.component});
  @override
  Widget build(BuildContext context) {
    final cpus = Provider.of<List<Cpu>>(context)??[];
    return SimpleDialog(
      title: Text('Choose your $component'),
      children: [
        for(int i=0;i<cpus.length ; i++)
          SimpleDialogOption(
            padding: EdgeInsets.symmetric(horizontal: 25,vertical: 25),
            child: Text('gruszka'),
            onPressed: (){
              Navigator.pop(context);

            },
          )
      ],

    );
  }
}