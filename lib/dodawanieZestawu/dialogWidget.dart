import 'package:flutter/material.dart';
import 'package:skladappka/Firebase/Cpu.dart';
import 'package:provider/provider.dart';
import 'package:skladappka/Firebase/FireBase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dialogBuilder.dart';
import 'dart:core';
class dialogWidget{
  final pomysl=pomyslXD();
   Future<int> getListLength(){
     print('hello');
    Stream<List<Cpu>> list = FireBase().cpus;
    return list.length;
  }

  void showPopup(BuildContext context,String component) {
    showDialog(    
    context: context,
    builder: (BuildContext context) => popupWindow(context, component)
  );}

  @override
  Widget popupWindow(BuildContext context, String component) {
    return StreamProvider<List<Cpu>>.value(
      value: FireBase().cpus,
      child: dialogBuilder(),
    );
  }
}