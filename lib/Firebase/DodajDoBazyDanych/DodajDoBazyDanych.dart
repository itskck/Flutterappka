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

class addUserToDatabase {
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users"); //odwołanie do kolekcji w Firebase

  Future<void> updateUserData(String nick, String uid) async { //metoda dodania dokumentu
    var aid = Random().nextInt(5); //ustawienie losowego awatara
    return await userCollection //stworzenie dokumentu i zapisanie do niego wartosci
        .doc(uid)
        .set({'aid': aid, 'nick': nick, 'uid': uid});
  }
}

class addBuildToDatabse {
  Random _rnd = Random();
  final _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  int licznik = 0;
  String pom;
  final Cpu chosenCpu;
  final Psu chosenPsu;
  final Motherboard chosenMtb;
  final Drive chosenDrive;
  final Ram chosenRam;
  final Case chosenCase;
  final Gpu chosenGpu;
  final Cooler chosenCooler;
  final List<Drive> extraDrive;
  final num minTdp,maxTdp;
  final double iloscRam;
  String uid = FirebaseAuth.instance.currentUser.uid;
  DateTime now = new DateTime.now();

  addBuildToDatabse(
      {this.chosenCpu,
      this.chosenRam,
      this.chosenPsu,
      this.chosenMtb,
      this.chosenGpu,
      this.chosenDrive,
      this.chosenCooler,
      this.chosenCase,
      this.extraDrive,
      this.maxTdp,
      this.minTdp,
      this.iloscRam
      });

  final CollectionReference buildCollection =
      FirebaseFirestore.instance.collection("builds");

  Future<String> generateRandomString() async {
    String randomString = String.fromCharCodes(List.generate(
        5, (index) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
    return randomString;
  }

  Future<bool> checkexist() async {
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection("builds")
        .where("generatedCode", isEqualTo: pom)
        .limit(1)
        .get();
    final List<DocumentSnapshot> documents = result.docs;
    if (documents.length == 1)
      return true;
    else
      return false;
  }

  Future<void> addBuildData() async {
    pom = "pcqxs";
    while (await checkexist() == true) {
      pom = await generateRandomString();
    }
    List<String> extra_drives;
    extra_drives = new List<String>();
    if (extraDrive != null) {
      if (extraDrive.length > 0)
        for (int i = 0; i < extraDrive.length; i++) {
          for (int j = 0; j < extraDrive.length; j++) {
            if (extraDrive[i].model == extraDrive[j].model) {
              licznik++;
            }
          }
          extra_drives.add(licznik.toString()+" "+extraDrive[i].model);
          licznik=0;
        }
      else
        extra_drives.add("Brak");
    }
    return await buildCollection.doc(pom + " " + uid).set({
      "cpuId": chosenCpu.model,
      "caseId": chosenCase.model,
      "coolerId": chosenCooler.model,
      "driveId": chosenDrive.model,
      "gpuId": chosenGpu.model,
      "motherboardId": chosenMtb.model,
      "psuId": chosenPsu.model,
      "ramId": chosenRam.model,
      "generatedCode": pom,
      "timestamp":
          new DateTime(now.year, now.month, now.day, now.hour, now.minute)
              .toString(),
      "uid": uid,
      "extradisk": FieldValue.arrayUnion(extra_drives),
      "minTdp": minTdp,
      "maxTdp": maxTdp,
      "ramNumber": iloscRam,
    });
  }

  Future<void> editBuildData(String code) async {
    return await buildCollection.doc(code + " " + uid).set({
      "cpuId": chosenCpu.model,
      "caseId": chosenCase.model,
      "coolerId": chosenCooler.model,
      "driveId": chosenDrive.model,
      "gpuId": chosenGpu.model,
      "motherboardId": chosenMtb.model,
      "psuId": chosenPsu.model,
      "ramId": chosenRam.model,
      "timestamp":
          new DateTime(now.year, now.month, now.day, now.hour, now.minute)
              .toString(),
      "generatedCode": code,
      "uid": uid,
    });
  }
}
