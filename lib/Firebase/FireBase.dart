import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:skladappka/Firebase/Gpu.dart';
import 'package:skladappka/Firebase/Case.dart';
import 'package:skladappka/Firebase/Cooler.dart';
import 'package:skladappka/Firebase/Cpu.dart';
import 'package:skladappka/Firebase/Drive.dart';
import 'package:skladappka/Firebase/Motherboard.dart';
import 'package:skladappka/Firebase/Psu.dart';
import 'package:skladappka/Firebase/Ram.dart';
import 'dart:core';
import 'package:skladappka/Firebase/Code.dart';
import 'package:rxdart/rxdart.dart';
import 'package:async/async.dart' show StreamGroup;
import 'Builds.dart';
import 'package:skladappka/dodawanieZestawu/dodaj.dart';

class FireBase{

  //Cooler
  String cpuSocket; //Mtb

  //Case
  String mtbStandard;

  //Drive
  bool mtbNvmeSlot;

  //Ram
  String mtbRamType;

  //Cpu
  String mtbSocket;
  List <dynamic> coolerSocket;

  //Motherboard
  //20 linika
  String ramRamType;
  String driveConnectionType;
  List <dynamic> caseStandard;

  User _firebaseUser = FirebaseAuth.instance.currentUser;





  List<Gpu> gpuListFromSnapshot(QuerySnapshot snapshot){

    return snapshot.docs.map((doc){
      String url=doc.data().toString().contains('manufacturer') ? doc.get('manufacturer') : 'placeholder';
      Image img=Image.asset("assets/companies logo/"+url.toLowerCase()+".png");
      return Gpu(
        VRAM: doc.data().toString().contains('VRAM') ? doc.get('VRAM') : 'Error not found',
        manufacturer: doc.data().toString().contains('manufacturer') ? doc.get('manufacturer') : 'Error not found',
        model: doc.data().toString().contains('model') ? doc.get('model') : 'Error not found',
        year: doc.data().toString().contains('year') ? doc.get('year') : 'Error not found',
        series: doc.data().toString().contains('series') ? doc.get('series') : 'Error not found',
        tdp: doc.data().toString().contains('tdp') ? doc.get('tdp') : 'Error not found',
        integra: doc.data().toString().contains('integra') ? doc.get('integra') : 'Error not found',
        img: img
      );
    }).toList();
  }
  Stream<List<Gpu>> get gpus {
     return FirebaseFirestore.instance.collection('gpus').where("integra",isEqualTo: false)
         .snapshots().map(gpuListFromSnapshot);
  }

  List<Case> caseListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      String url=doc.data().toString().contains('manufacturer') ? doc.get('manufacturer') : 'placeholder';
      Image img=Image.asset("assets/companies logo/"+url.toLowerCase()+".png");
      return Case(
          manufacturer: doc.data().toString().contains('manufacturer') ? doc.get('manufacturer') : 'Error not found',
          model: doc.data().toString().contains('model') ? doc.get('model') : 'Error not found',
          standard: doc.data().toString().contains('standard') ? doc.get('standard') : 'Error not found',
          img: img
      );
    }).toList();
  }
  Stream<List<Case>> get cases {
    if(mtbStandard==null)
      return FirebaseFirestore.instance.collection('cases').snapshots().map(caseListFromSnapshot);
    else
      return FirebaseFirestore.instance.collection('cases').where('standard', arrayContains: mtbStandard).snapshots()
          .map(caseListFromSnapshot);
  }

  List<Cooler> coolerListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      String url=doc.data().toString().contains('manufacturer') ? doc.get('manufacturer') : 'placeholder';
      Image img=Image.asset("assets/companies logo/"+url.toLowerCase()+".png");
      return Cooler(
          manufacturer: doc.data().toString().contains('manufacturer') ? doc.get('manufacturer') : 'Error not found',
          model: doc.data().toString().contains('model') ? doc.get('model') : 'Error not found',
          socket: doc.data().toString().contains('socket') ? doc.get('socket') : 'Error not found',
          img: img
      );
    }).toList();
  }
  Stream<List<Cooler>> get coolers {
    if(cpuSocket!=null) {
      return FirebaseFirestore.instance.collection('coolers').where(
          'model', isNotEqualTo: "Fabryczne chłodzenie").where(
          'socket', arrayContains : cpuSocket.toString())
          .snapshots().map(coolerListFromSnapshot);
    }
    else
      return FirebaseFirestore.instance.collection('coolers')
          .where('model',isNotEqualTo: "Fabryczne chłodzenie").snapshots()
          .map(coolerListFromSnapshot);
  }

  List<Cpu> cpuListFromSnapshot(QuerySnapshot snapshot){

    return snapshot.docs.map((doc){
      String url=doc.data().toString().contains('manufacturer') ? doc.get('manufacturer') : 'placeholder';
      Image img=Image.asset("assets/companies logo/"+url.toLowerCase()+".png");
      return Cpu(
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
          year: doc.data().toString().contains('year') ? doc.get('year') : 'Error not found',
          benchScore: doc.data().toString().contains('benchScore') ? doc.get('benchScore') : 'Error not found',
          img: img
      );
    }).toList();
  }
  Stream<List<Cpu>> get cpus {
    if(coolerSocket!=null){
        return FirebaseFirestore.instance.collection('cpus')
            .where('socket', whereIn: coolerSocket).where('socket', isEqualTo: mtbSocket)
            .snapshots().map(cpuListFromSnapshot);

    }
    else
      return FirebaseFirestore.instance.collection('cpus')
          .where('socket', isEqualTo: mtbSocket)
          .snapshots().map(cpuListFromSnapshot);
  }

  List<Drive> driveListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      String url=doc.data().toString().contains('manufacturer') ? doc.get('manufacturer') : 'placeholder';
      Image img=Image.asset("assets/companies logo/"+url.toLowerCase()+".png");
      return Drive(
          manufacturer: doc.data().toString().contains('manufacturer') ? doc.get('manufacturer') : 'Error not found',
          model: doc.data().toString().contains('model') ? doc.get('model') : 'Error not found',
          capacity: doc.data().toString().contains('capacity') ? doc.get('capacity') : 'Error not found',
          connectionType: doc.data().toString().contains('connectionType') ? doc.get('connectionType') : 'Error not found',
          type: doc.data().toString().contains('type') ? doc.get('type') : 'Error not found',
          img: img
      );
    }).toList();
  }
  Stream<List<Drive>> get drives {
    if(mtbNvmeSlot==null || mtbNvmeSlot==true)
      return FirebaseFirestore.instance.collection('drives').snapshots().map(driveListFromSnapshot);
    else
      return FirebaseFirestore.instance.collection('drives').where('connectionType', isEqualTo: 'SATA')
          .snapshots().map(driveListFromSnapshot);
  }

  List<Motherboard> motherboardListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      String url=doc.data().toString().contains('manufacturer') ? doc.get('manufacturer') : 'placeholder';
      Image img=Image.asset("assets/companies logo/"+url.toLowerCase()+".png");
      return Motherboard(
          manufacturer: doc.data().toString().contains('manufacturer') ? doc.get('manufacturer') : 'Error not found',
          model: doc.data().toString().contains('model') ? doc.get('model') : 'Error not found',
          chipset: doc.data().toString().contains('chipset') ? doc.get('chipset') : 'Error not found',
          hasNvmeSlot: doc.data().toString().contains('hasNvmeSlot') ? doc.get('hasNvmeSlot') : 'Error not found',
          ramSlots: doc.data().toString().contains('ramSlots') ? doc.get('ramSlots') : 'Error not found',
          ramType: doc.data().toString().contains('ramType') ? doc.get('ramType') : 'Error not found',
          socket: doc.data().toString().contains('socket') ? doc.get('socket') : 'Error not found',
          standard: doc.data().toString().contains('standard') ? doc.get('standard') : 'Error not found',
          img: img,
          wifi: doc.data().toString().contains('wifi') ? doc.get('wifi') : false,
          usb3: doc.data().toString().contains('usb3') ? doc.get('usb3') : 'Error not found',
          usb2and1: doc.data().toString().contains('usb2and1') ? doc.get('usb2and1') : 'Error not found',
          ethernetSpeed: doc.data().toString().contains('ethernetSpeed') ? doc.get('ethernetSpeed') : 'Error not found',
          sataPorts: doc.data().toString().contains('sataPorts') ? doc.get('sataPorts') : 'Error not found'
      );
    }).toList();
  }
  Stream<List<Motherboard>> get motherboards {

    if((driveConnectionType==null || driveConnectionType=="SATA") && caseStandard!=null) {
      return FirebaseFirestore.instance.collection('motherboard')
          .where('standard', whereIn: caseStandard)
          .where('ramType', isEqualTo: ramRamType).where(
          'socket', isEqualTo: cpuSocket).snapshots().map(motherboardListFromSnapshot);
    }
    else if((driveConnectionType==null || driveConnectionType=="SATA") && caseStandard==null) {
      print("was");
      return FirebaseFirestore.instance.collection('motherboard')
          .where('ramType', isEqualTo: ramRamType).where(
          'socket', isEqualTo: cpuSocket)
          .snapshots().map(motherboardListFromSnapshot);
    }
    else if(caseStandard!=null) {
      print("o3o");
      return FirebaseFirestore.instance
            .collection('motherboard').where('standard', whereIn: caseStandard).where('ramType', isEqualTo: ramRamType)
            .where('socket', isEqualTo: cpuSocket).where('hasNvmeSlot', isEqualTo: true).snapshots().map(motherboardListFromSnapshot);

    } else
      print("o4o");
      return FirebaseFirestore.instance.collection('motherboard')
          .where('ramType', isEqualTo: ramRamType).where('socket', isEqualTo: cpuSocket)
          .where('hasNvmeSlot', isEqualTo: true)
          .snapshots().map(motherboardListFromSnapshot);

  }

  List<Psu> psuListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      String url=doc.data().toString().contains('manufacturer') ? doc.get('manufacturer') : 'placeholder';
      Image img=Image.asset("assets/companies logo/"+url.toLowerCase()+".png");
      return Psu(
          manufacturer: doc.data().toString().contains('manufacturer') ? doc.get('manufacturer') : 'Error not found',
          model: doc.data().toString().contains('model') ? doc.get('model') : 'Error not found',
          power: doc.data().toString().contains('power') ? doc.get('power') : 'Error not found',
          img: img
      );
    }).toList();
  }
  Stream<List<Psu>> get psus {
    return FirebaseFirestore.instance.collection('psus').snapshots().map(psuListFromSnapshot);
  }

  List<Ram> ramListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      String url=doc.data().toString().contains('manufacturer') ? doc.get('manufacturer') : 'placeholder';
      Image img=Image.asset("assets/companies logo/"+url.toLowerCase()+".png");
      return Ram(
          manufacturer: doc.data().toString().contains('manufacturer') ? doc.get('manufacturer') : 'Error not found',
          model: doc.data().toString().contains('model') ? doc.get('model') : 'Error not found',
          capacity: doc.data().toString().contains('capacity') ? doc.get('capacity') : 'Error not found',
          speed: doc.data().toString().contains('speed') ? doc.get('speed') : 'Error not found',
          type: doc.data().toString().contains('type') ? doc.get('type') : 'Error not found',
          img: img
      );
    }).toList();
  }
  Stream<List<Ram>> get rams {
    return FirebaseFirestore.instance.collection('rams').where('type',isEqualTo: mtbRamType)
        .snapshots().map(ramListFromSnapshot);
  }

  List<Builds> buildsListFromSnapshot(QuerySnapshot snapshot){
     print(snapshot.docs.length);
    return snapshot.docs.map((doc){
      return Builds(
        cpuId: doc.data().toString().contains('cpuId') ? doc.get('cpuId') : 'Error not found',
        caseId: doc.data().toString().contains('caseId') ? doc.get('caseId') : 'Error not found',
        coolerId: doc.data().toString().contains('coolerId') ? doc.get('coolerId') : 'Error not found',
        driveId: doc.data().toString().contains('driveId') ? doc.get('driveId') : 'Error not found',
        generatedCode: doc.data().toString().contains('generatedCode') ? doc.get('generatedCode') : 'Error not found',
        gpuId: doc.data().toString().contains('gpuId') ? doc.get('gpuId') : 'Error not found',
        motherboardId: doc.data().toString().contains('motherboardId') ? doc.get('motherboardId') : 'Error not found',
        psuId: doc.data().toString().contains('psuId') ? doc.get('psuId') : 'Error not found',
        ramId: doc.data().toString().contains('ramId') ? doc.get('ramId') : 'Error not found',
        timestamp: doc.data().toString().contains('timestamp') ? doc.get('timestamp') : 'Error not found',
        uid: doc.data().toString().contains('uid') ? doc.get('uid') : 'Error not found'
      );
    }).toList();
  }
  Stream<List<Builds>> get builds {
    print(_firebaseUser.uid);
    return FirebaseFirestore.instance.collection('builds').where("uid",isEqualTo: _firebaseUser.uid).snapshots()
        .map(buildsListFromSnapshot);
  }
  Future<Gpu> addGpu(String model) async {
    Gpu chosenGpu;
    var snapshot=await FirebaseFirestore.instance
        .collection("gpus")
        .where('model', isEqualTo: model).get();
    snapshot.docs.map((doc){
      String url=doc.data().toString().contains('manufacturer') ? doc.get('manufacturer') : 'placeholder';
      Image img=Image.asset("assets/companies logo/"+url.toLowerCase()+".png");
      chosenGpu=Gpu(
          VRAM: doc.data().toString().contains('VRAM') ? doc.get('VRAM') : 'Error not found',
          manufacturer: doc.data().toString().contains('manufacturer') ? doc.get('manufacturer') : 'Error not found',
          model: doc.data().toString().contains('model') ? doc.get('model') : 'Error not found',
          year: doc.data().toString().contains('year') ? doc.get('year') : 'Error not found',
          series: doc.data().toString().contains('series') ? doc.get('series') : 'Error not found',
          tdp: doc.data().toString().contains('tdp') ? doc.get('tdp') : 'Error not found',
          integra: doc.data().toString().contains('integra') ? doc.get('integra') : 'Error not found',
          img:img
      );
    }).toList();
    return chosenGpu;
  }
  Future<Cooler> addCooler() async{
    Cooler chosenCooler;
    var snapshot= await FirebaseFirestore.instance
        .collection("coolers")
        .where("model", isEqualTo: 'Fabryczne chłodzenie')
        .get();
    snapshot.docs.map((doc){
      chosenCooler=Cooler(
          manufacturer: doc.data().toString().contains('manufacturer') ? doc.get('manufacturer') : 'Error not found',
          model: doc.data().toString().contains('model') ? doc.get('model') : 'Error not found',
          socket: doc.data().toString().contains('socket') ? doc.get('socket') : 'Error not found',
          img: null
      );
    }).toList();
    return chosenCooler;
  }

  List<Drive> extradriveListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      String url=doc.data().toString().contains('manufacturer') ? doc.get('manufacturer') : 'placeholder';
      Image img=Image.asset("assets/companies logo/"+url.toLowerCase()+".png");
      return Drive(
          manufacturer: doc.data().toString().contains('manufacturer') ? doc.get('manufacturer') : 'Error not found',
          model: doc.data().toString().contains('model') ? doc.get('model') : 'Error not found',
          capacity: doc.data().toString().contains('capacity') ? doc.get('capacity') : 'Error not found',
          connectionType: doc.data().toString().contains('connectionType') ? doc.get('connectionType') : 'Error not found',
          type: doc.data().toString().contains('type') ? doc.get('type') : 'Error not found',
          img: img
      );
    }).toList();
  }
  Stream<List<Drive>> get extradrives {
    if(dodaj.usedNvme==false)
      return FirebaseFirestore.instance.collection('drives').snapshots().map(driveListFromSnapshot);
    else
      return FirebaseFirestore.instance.collection('drives').where('connectionType', isEqualTo: 'SATA')
          .snapshots().map(driveListFromSnapshot);
  }
}

