import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:skladappka/Firebase/Case.dart';
import 'package:skladappka/Firebase/Cooler.dart';
import 'package:skladappka/Firebase/Cpu.dart';
import 'package:skladappka/Firebase/Drive.dart';
import 'package:skladappka/Firebase/Gpu.dart';
import 'package:skladappka/Firebase/Motherboard.dart';
import 'package:skladappka/Firebase/Psu.dart';
import 'package:skladappka/Firebase/Ram.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
class addNickToDatabase{
  //var _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';

  final String uid;
  addNickToDatabase({this.uid});
  final CollectionReference userCollection = FirebaseFirestore.instance.collection("users");


  Future<void> updateUserData(String nick) async {
    return await userCollection.doc(uid).set({
      'nick': nick,
    });
  }

}

class addBuildToDatabse{
  Random _rnd = Random();
  int a=0;
  String pom;
  final Cpu chosenCpu;
  final Psu chosenPsu;
  final Motherboard chosenMtb;
  final Drive chosenDrive;
  final Ram chosenRam;
  final Case chosenCase;
  final Gpu chosenGpu;
  final Cooler chosenCooler;
  String uid=FirebaseAuth.instance.currentUser.uid;

  addBuildToDatabse({this.chosenCpu,this.chosenRam,this.chosenPsu,this.chosenMtb,this.chosenGpu,this.chosenDrive,this.chosenCooler,this.chosenCase});

  final CollectionReference buildCollection = FirebaseFirestore.instance.collection("builds");

  Future<String> generateRandomString() async{
    String randomString =String.fromCharCodes(List.generate(5, (index)=> _rnd.nextInt(33) + 89));
    return randomString;
  }
  Future<void> addBuildData() async{
    pom="pcqxs"+" "+uid;
    var canI=FirebaseFirestore.instance.doc('builds/$pom').get();
    while(canI==null){
      print("elo");
      if(a>10)
        canI=FirebaseFirestore.instance.doc('builds/$pom').get();
      a++;
    }
    pom=pom+" "+uid;
    return await buildCollection.doc(pom).set({
      "cpuId": chosenCpu.model,
      "caseId": chosenCase.model,
      "coolerId": chosenCooler.model,
      "driveId": chosenDrive.model,
      "gpuId": chosenGpu.model,
      "motherboardId": chosenMtb.model,
      "psuId": chosenPsu.model,
      "ramId": chosenRam.model,
    });
  }
}