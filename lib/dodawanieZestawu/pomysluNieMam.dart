import 'package:flutter/material.dart';
import 'package:skladappka/Firebase/Cpu.dart';
import 'package:provider/provider.dart';
import 'package:skladappka/Firebase/FireBase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:core';
import 'package:skladappka/dodawanieZestawu/dialogWidget.dart';
class pomyslXD extends StatefulWidget {

    
  @override
  _pomyslXDState createState() => _pomyslXDState();
}

class _pomyslXDState extends State<pomyslXD> {

  @override
  Widget build(BuildContext context) {
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

            },
          )
      ],

    );
  }
}
