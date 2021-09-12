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

import 'package:skladappka/Porownywarka/Porownywarka.dart';

class dialogBuilderForCompare extends StatelessWidget{

  User _firebaseUser=FirebaseAuth.instance.currentUser;

  Future<void> getUserBuilds() async{
    String uid=_firebaseUser.uid;
    print('hello');
    var snapshot=await FirebaseFirestore.instance
    .collection("builds")
    .where("uid", isEqualTo: uid)
    .get();

    print(snapshot.size.toString());
    snapshot.docs.map((doc){
      for(int i=0;i<snapshot.size;i++){
        print(i);
      Porownywarka.chosenBuild[0]=Builds(
        cpuId: doc.data().toString().contains('cpuId') ? doc.get('cpuId') : 'Error not found',
        caseId: doc.data().toString().contains('caseId') ? doc.get('caseId') : 'Error not found',
        coolerId: doc.data().toString().contains('coolerId') ? doc.get('coolerId') : 'Error not found',
        driveId: doc.data().toString().contains('driveId') ? doc.get('driveId') : 'Error not found',
        generatedCode: doc.data().toString().contains('generatedCode') ? doc.get('generatedCode') : 'Error not found',
        gpuId: doc.data().toString().contains('gpuId') ? doc.get('gpuId') : 'Error not found',
        motherboardId: doc.data().toString().contains('motherboardId') ? doc.get('motherboardId') : 'Error not found',
        psuId: doc.data().toString().contains('psuId') ? doc.get('psuId') : 'Error not found',
        ramId: doc.data().toString().contains('ramId') ? doc.get('ramId') : 'Error not found',
        //timestamp: doc.data().toString().contains('timestamp') ? doc.get('timestamp') : 'error',
        uid: doc.data().toString().contains('uid') ? doc.get('uid') : 'Error not found',
      );

      }
    }).toList();

    
  }
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
        title: Text('Choose your build'),
        children: [
          for(int i=0;i<Porownywarka.chosenBuild.length ; i++)
            SimpleDialogOption(
              padding: EdgeInsets.symmetric(horizontal: 25,vertical: 25),
              child: Text(Porownywarka.chosenBuild[i].cpuId.toString()),
              onPressed: (){

              },
            )]);

  }
}