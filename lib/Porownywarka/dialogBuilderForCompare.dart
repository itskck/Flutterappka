import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:skladappka/Firebase/Case.dart';
import 'package:skladappka/Firebase/Cooler.dart';
import 'package:skladappka/Firebase/Cpu.dart';
import 'package:provider/provider.dart';
import 'package:skladappka/Firebase/Drive.dart';
import 'package:skladappka/Firebase/Gpu.dart';
import 'package:skladappka/Firebase/Motherboard.dart';
import 'package:skladappka/Firebase/Psu.dart';
import 'package:skladappka/Firebase/Builds.dart';
import 'dart:core';
 import 'package:skladappka/Firebase/getFromDatabase/getFromSaved.dart';

import 'package:skladappka/Porownywarka/Porownywarka.dart';

class dialogBuilderForCompare extends StatelessWidget{
  var builds;
  int ktoro;
  dialogBuilderForCompare({this.ktoro});
  @override
  Widget build(BuildContext context) {
    builds = Provider.of<List<Builds>>(context)??[];
    return SimpleDialog(
        title: Text('Choose your build'),
        children: [
          for(int i=0;i<builds.length ; i++)
            SimpleDialogOption(
              padding: EdgeInsets.symmetric(horizontal: 25,vertical: 25),
              child: Text(builds[i].timestamp),
              onPressed: () async{
                if(ktoro==9) {
                  Porownywarka.chosenCpu = await getFromSaved(id: builds[i].cpuId).getCpu();
                }
                else{

                }
                Navigator.pop(context);
              },
            )]);

  }
}