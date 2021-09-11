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
import 'package:skladappka/Porownywarka/Porownywarka.dart';

class getFromCode {
  String code;
  getFromCode({this.code});

  Future<bool> corrCode() async{
    final QuerySnapshot result=await FirebaseFirestore.instance
        .collection("builds")
        .where("generatedCode", isEqualTo: code)
        .limit(1)
        .get();
    final List<DocumentSnapshot> documents=result.docs;
    if(documents.length==1) return true;
    else return false;
  }

  Future<Cpu> getCpu() async{
    final QuerySnapshot result=await FirebaseFirestore.instance.
    collection("builds")
        .where("generatedCode", isEqualTo: code)
        .get();
    final List<DocumentSnapshot> ours=result.docs;
    /*
    Porownywarka.chosenCpu=await FirebaseFirestore.instance
        .collection("cpus")
        .where("model",isEqualTo: ours.) */
  }

}