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
  static Cpu chosenCpu;
  static Psu chosenPsu;
  static Motherboard chosenMtb;
  static Drive chosenDrive;
  static Ram chosenRam;
  static Case chosenCase;
  static Gpu chosenGpu;
  static Cooler chosenCooler;

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
    var cpu;
    await FirebaseFirestore.instance.
    collection("builds")
        .where("generatedCode", isEqualTo: code)
        .get()
        .then((QuerySnapshot result) => {
          result.docs.forEach((element) {
           cpu=element["cpuId"];
          })});

    var snapshot= await FirebaseFirestore.instance
    .collection("cpus")
    .where("model", isEqualTo: cpu)
    .get();
    snapshot.docs.map((doc){
      chosenCpu=Cpu(
          manufacturer: doc.data().toString().contains('manufacturer') ? doc.get('manufacturer') : 'Error not found',
          model: doc.data().toString().contains('model') ? doc.get('model') : 'Error not found',
          clocker: doc.data().toString().contains('clock') ? doc.get('clock') : 'Error not found',
          cores: doc.data().toString().contains('cores') ? doc.get('cores') : 'Error not found',
          hasGpu: doc.data().toString().contains('hasGpu') ? doc.get('hasGpu') : 'Error not found',
          isCoolerIncluded: doc.data().toString().contains('isCoolerIncluded') ? doc.get('isCoolerIncluded') : 'Error not found',
          isUnlocked: doc.data().toString().contains('isUnlocked') ? doc.get('isUnlocked') : 'Error not found',
          socket: doc.data().toString().contains('socket') ? doc.get('socket') : 'Error not found',
          tdp: doc.data().toString().contains('tdp') ? doc.get('tdp') : 'Error not found',
          threads: doc.data().toString().contains('threads') ? doc.get('threads') : 'Error not found',
          year: doc.data().toString().contains('year') ? doc.get('year') : 'Error not found'
      );
    }).toList();
    return chosenCpu;
  }

  Future<Gpu> getGpu() async{
    var ktoro;
    await FirebaseFirestore.instance.
    collection("builds")
        .where("generatedCode", isEqualTo: code)
        .get()
        .then((QuerySnapshot result) => {
      result.docs.forEach((element) {
        ktoro=element["gpuId"];
      })});

    var snapshot= await FirebaseFirestore.instance
        .collection("gpus")
        .where("model", isEqualTo: ktoro)
        .get();
    snapshot.docs.map((doc){
      chosenGpu=Gpu(
          VRAM: doc.data().toString().contains('VRAM') ? doc.get('VRAM') : 'Error not found',
          manufacturer: doc.data().toString().contains('manufacturer') ? doc.get('manufacturer') : 'Error not found',
          model: doc.data().toString().contains('model') ? doc.get('model') : 'Error not found',
          year: doc.data().toString().contains('year') ? doc.get('year') : 'Error not found',
          series: doc.data().toString().contains('series') ? doc.get('series') : 'Error not found',
          tdp: doc.data().toString().contains('tdp') ? doc.get('tdp') : 'Error not found'
      );
    }).toList();
    return chosenGpu;
  }

  Future<Case> getCase() async{
    var ktoro;
    await FirebaseFirestore.instance.
    collection("builds")
        .where("generatedCode", isEqualTo: code)
        .get()
        .then((QuerySnapshot result) => {
      result.docs.forEach((element) {
        ktoro=element["caseId"];
      })});

    var snapshot= await FirebaseFirestore.instance
        .collection("cases")
        .where("model", isEqualTo: ktoro)
        .get();
    snapshot.docs.map((doc){
      chosenCase=Case(
          manufacturer: doc.data().toString().contains('manufacturer') ? doc.get('manufacturer') : 'Error not found',
          model: doc.data().toString().contains('model') ? doc.get('model') : 'Error not found',
          standard: doc.data().toString().contains('standard') ? doc.get('standard') : 'Error not found'
      );
    }).toList();
    return chosenCase;
  }

  Future<Cooler> getCooler() async{
    var ktoro;
    await FirebaseFirestore.instance.
    collection("builds")
        .where("generatedCode", isEqualTo: code)
        .get()
        .then((QuerySnapshot result) => {
      result.docs.forEach((element) {
        ktoro=element["coolerId"];
      })});

    var snapshot= await FirebaseFirestore.instance
        .collection("coolers")
        .where("model", isEqualTo: ktoro)
        .get();
    snapshot.docs.map((doc){
      chosenCooler=Cooler(
          manufacturer: doc.data().toString().contains('manufacturer') ? doc.get('manufacturer') : 'Error not found',
          model: doc.data().toString().contains('model') ? doc.get('model') : 'Error not found',
          socket: doc.data().toString().contains('socket') ? doc.get('socket') : 'Error not found'
      );
    }).toList();
    return chosenCooler;
  }

  Future<Drive> getDrive() async{
    var ktoro;
    await FirebaseFirestore.instance.
    collection("builds")
        .where("generatedCode", isEqualTo: code)
        .get()
        .then((QuerySnapshot result) => {
      result.docs.forEach((element) {
        ktoro=element["driveId"];
      })});

    var snapshot= await FirebaseFirestore.instance
        .collection("drives")
        .where("model", isEqualTo: ktoro)
        .get();
    snapshot.docs.map((doc){
      chosenDrive=Drive(
          manufacturer: doc.data().toString().contains('manufacturer') ? doc.get('manufacturer') : 'Error not found',
          model: doc.data().toString().contains('model') ? doc.get('model') : 'Error not found',
          capacity: doc.data().toString().contains('capacity') ? doc.get('capacity') : 'Error not found',
          connectionType: doc.data().toString().contains('connectionType') ? doc.get('connectionType') : 'Error not found',
          type: doc.data().toString().contains('type') ? doc.get('type') : 'Error not found'
      );
    }).toList();
    return chosenDrive;
  }

  Future<Motherboard> getMotherboard() async{
    var ktoro;
    await FirebaseFirestore.instance.
    collection("builds")
        .where("generatedCode", isEqualTo: code)
        .get()
        .then((QuerySnapshot result) => {
      result.docs.forEach((element) {
        ktoro=element["motherboardId"];
      })});

    var snapshot= await FirebaseFirestore.instance
        .collection("motherboard")
        .where("model", isEqualTo: ktoro)
        .get();
    snapshot.docs.map((doc){
      chosenMtb=Motherboard(
          manufacturer: doc.data().toString().contains('manufacturer') ? doc.get('manufacturer') : 'Error not found',
          model: doc.data().toString().contains('model') ? doc.get('model') : 'Error not found',
          chipset: doc.data().toString().contains('chipset') ? doc.get('chipset') : 'Error not found',
          hasNvmeSlot: doc.data().toString().contains('hasNvmeSlot') ? doc.get('hasNvmeSlot') : 'Error not found',
          ramSlots: doc.data().toString().contains('ramSlots') ? doc.get('ramSlots') : 'Error not found',
          ramType: doc.data().toString().contains('ramType') ? doc.get('ramType') : 'Error not found',
          socket: doc.data().toString().contains('socket') ? doc.get('socket') : 'Error not found',
          standard: doc.data().toString().contains('standard') ? doc.get('standard') : 'Error not found'
      );
    }).toList();
    return chosenMtb;
  }

  Future<Psu> getPsu() async{
    var ktoro;
    await FirebaseFirestore.instance.
    collection("builds")
        .where("generatedCode", isEqualTo: code)
        .get()
        .then((QuerySnapshot result) => {
      result.docs.forEach((element) {
        ktoro=element["psuId"];
      })});

    var snapshot= await FirebaseFirestore.instance
        .collection("psus")
        .where("model", isEqualTo: ktoro)
        .get();
    snapshot.docs.map((doc){
      chosenPsu=Psu(
          manufacturer: doc.data().toString().contains('manufacturer') ? doc.get('manufacturer') : 'Error not found',
          model: doc.data().toString().contains('model') ? doc.get('model') : 'Error not found',
          power: doc.data().toString().contains('power') ? doc.get('power') : 'Error not found'
      );
    }).toList();
    return chosenPsu;
  }

  Future<Ram> getRam() async{
    var ktoro;
    await FirebaseFirestore.instance.
    collection("builds")
        .where("generatedCode", isEqualTo: code)
        .get()
        .then((QuerySnapshot result) => {
      result.docs.forEach((element) {
        ktoro=element["ramId"];
      })});

    var snapshot= await FirebaseFirestore.instance
        .collection("rams")
        .where("model", isEqualTo: ktoro)
        .get();
    snapshot.docs.map((doc){
      chosenRam=Ram(
          manufacturer: doc.data().toString().contains('manufacturer') ? doc.get('manufacturer') : 'Error not found',
          model: doc.data().toString().contains('model') ? doc.get('model') : 'Error not found',
          capacity: doc.data().toString().contains('capacity') ? doc.get('capacity') : 'Error not found',
          speed: doc.data().toString().contains('speed') ? doc.get('speed') : 'Error not found',
          type: doc.data().toString().contains('type') ? doc.get('type') : 'Error not found'
      );
    }).toList();
    return chosenRam;
  }

}