import 'package:flutter/material.dart';
import 'package:skladappka/Firebase/Cpu.dart';
import 'package:provider/provider.dart';
import 'package:skladappka/Firebase/FireBase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:core';
class dialogWidget{
  
   Future<int> getListLength(){
    Stream<List<Cpu>> list = FireBase().cpus;
    return list.length;
  }
  
  Future<void> showPopup(BuildContext context,String component) async { 
    int length = await getListLength();
    showDialog(    
    context: context,
    builder: (BuildContext context) => popupWindow(context, component,length) 
  );}
  
  Widget popupWindow(BuildContext context, String component, int length) {
    
    return StreamProvider<List<Cpu>>.value(
      value: FireBase().cpus,
      initialData: [],
      child:
    SimpleDialog(      
      title: Text('Choose your $component: '),
      children: [
        for(int i=0;i< length ; i++)
        SimpleDialogOption(
          padding: EdgeInsets.symmetric(horizontal: 25,vertical: 25),
          child: Text('gruszka'),
          onPressed: (){
            Navigator.pop(context);
            
          },
        )
      ],      
      
    ));
  }
}