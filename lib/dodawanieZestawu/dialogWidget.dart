import 'package:flutter/material.dart';
import 'package:skladappka/Firebase/Cpu.dart';
import 'package:provider/provider.dart';
import 'package:skladappka/Firebase/FireBase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:core';
import 'dodaj.dart';
class dialogWidget{  
  
   Future<int> getListLength(){
     print('hello');
    Stream<List<Cpu>> list = FireBase().cpus;
    return list.length;
  }
  Widget builder(String component,BuildContext context){
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
  }
  void showPopup(BuildContext context,String component) {
    showDialog(    
    context: context,
    builder: (BuildContext c) => popupWindow(c, component)
  );}

  
  Widget popupWindow(BuildContext context, String component) {

    return StreamProvider<List<Cpu>>.value(
      value: FireBase().cpus,
      initialData: [],
      child: builder(component, context) ,
    );
  }
}