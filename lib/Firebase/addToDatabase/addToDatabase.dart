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

  
  
  final CollectionReference userCollection = FirebaseFirestore.instance.collection("users");

  Future<void> updateUserData(String nick,String uid) async {
    var aid= Random().nextInt(5);
    print('id zarejstrowanego: ' + uid);
    return await userCollection.doc(uid).set({
      'aid': aid,
      'nick': nick,
      'uid': uid
    });
  }

}

class addBuildToDatabse{
  Random _rnd = Random();
  final _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
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
  DateTime now=new DateTime.now();

  addBuildToDatabse({this.chosenCpu,this.chosenRam,this.chosenPsu,this.chosenMtb,this.chosenGpu,this.chosenDrive,this.chosenCooler,this.chosenCase});

  final CollectionReference buildCollection = FirebaseFirestore.instance.collection("builds");

  Future<String> generateRandomString() async{
    String randomString =String.fromCharCodes(List.generate(5, (index)=> _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
    return randomString;
  }

  Future<bool> checkexist() async{
    final QuerySnapshot result=await FirebaseFirestore.instance
        .collection("builds")
        .where("generatedCode", isEqualTo: pom)
        .limit(1)
        .get();
    final List<DocumentSnapshot> documents=result.docs;
  if(documents.length==1) return true;
  else return false;
  }

  Future<void> addBuildData() async{
    pom="pcqxs";
    while(await checkexist()==true){
      print("cos tam");
      pom=await generateRandomString();
    }

    return await buildCollection.doc(pom+" "+uid).set({
      "cpuId": chosenCpu.model,
      "caseId": chosenCase.model,
      "coolerId": chosenCooler.model,
      "driveId": chosenDrive.model,
      "gpuId": chosenGpu.model,
      "motherboardId": chosenMtb.model,
      "psuId": chosenPsu.model,
      "ramId": chosenRam.model,
      "generatedCode": pom,
      "timestamp": new DateTime(now.year, now.month, now.day, now.hour, now.minute).toString(),
      "uid": uid,
    });
  }

  Future<void> editBuildData(String code) async{

    return await buildCollection.doc(code+" "+uid).set({
      "cpuId": chosenCpu.model,
      "caseId": chosenCase.model,
      "coolerId": chosenCooler.model,
      "driveId": chosenDrive.model,
      "gpuId": chosenGpu.model,
      "motherboardId": chosenMtb.model,
      "psuId": chosenPsu.model,
      "ramId": chosenRam.model,
      "generatedCode": pom,
      "timestamp": new DateTime(now.year, now.month, now.day, now.hour, now.minute).toString(),
      "uid": uid,
    });
  }
}