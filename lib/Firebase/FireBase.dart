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
import 'package:rxdart/rxdart.dart';
import 'package:async/async.dart' show StreamGroup;
import 'Builds.dart';
import 'package:skladappka/dodawanieZestawu/Dodaj.dart';

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
      if(url.toLowerCase()=='amd')url='radeon';
      Image img=Image.asset("assets/companies logo/"+url.toLowerCase()+".png");
      print('gpuuuuuuuuuuuuu'+url);
      return Gpu(
        VRAM: doc.data().toString().contains('VRAM') ? doc.get('VRAM') : '1',
        manufacturer: doc.data().toString().contains('manufacturer') ? doc.get('manufacturer') : 'Nieznaleziono',
        model: doc.data().toString().contains('model') ? doc.get('model') : 'Nieznaleziono',
        year: doc.data().toString().contains('year') ? doc.get('year') : '2000',
        series: doc.data().toString().contains('series') ? doc.get('series') : 'Nieznaleziono',
        tdp: doc.data().toString().contains('tdp') ? doc.get('tdp') : '1',
        integra: doc.data().toString().contains('integra') ? doc.get('integra') : false,
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
          manufacturer: doc.data().toString().contains('manufacturer') ? doc.get('manufacturer') : 'Nieznaleziono',
          model: doc.data().toString().contains('model') ? doc.get('model') : 'Nieznaleziono',
          standard: doc.data().toString().contains('standard') ? doc.get('standard') : 'Nieznaleziono',
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
          manufacturer: doc.data().toString().contains('manufacturer') ? doc.get('manufacturer') : 'Nieznaleziono',
          model: doc.data().toString().contains('model') ? doc.get('model') : 'Nieznaleziono',
          socket: doc.data().toString().contains('socket') ? doc.get('socket') : 'Nieznaleziono',
          img: img
      );
    }).toList();
  }
  Stream<List<Cooler>> get coolers {
    if(cpuSocket!=null) {
      return FirebaseFirestore.instance.collection('coolers').where(
          'model', isNotEqualTo: "Fabryczne ch??odzenie").where(
          'socket', arrayContains : cpuSocket.toString())
          .snapshots().map(coolerListFromSnapshot);
    }
    else
      return FirebaseFirestore.instance.collection('coolers')
          .where('model',isNotEqualTo: "Fabryczne ch??odzenie").snapshots()
          .map(coolerListFromSnapshot);
  }

  List<Cpu> cpuListFromSnapshot(QuerySnapshot snapshot){

    return snapshot.docs.map((doc){
      String url=doc.data().toString().contains('manufacturer') ? doc.get('manufacturer') : 'placeholder';
      Image img=Image.asset("assets/companies logo/"+url.toLowerCase()+".png");
      return Cpu(
          manufacturer: doc.data().toString().contains('manufacturer') ? doc.get('manufacturer') : 'Nieznaleziono',
          model: doc.data().toString().contains('model') ? doc.get('model') : 'Nieznaleziono',
          clocker: doc.data().toString().contains('clock') ? doc.get('clock') : '1.0',
          cores: doc.data().toString().contains('cores') ? doc.get('cores') : '1',
          hasGpu: doc.data().toString().contains('hasGpu') ? doc.get('hasGpu') : 'none',
          isCoolerIncluded: doc.data().toString().contains('isCoolerIncluded') ? doc.get('isCoolerIncluded') : false,
          isUnlocked: doc.data().toString().contains('isUnlocked') ? doc.get('isUnlocked') : false,
          socket: doc.data().toString().contains('socket') ? doc.get('socket') : 'Nieznaleziono',
          tdp: doc.data().toString().contains('tdp') ? doc.get('tdp') : '1',
          threads: doc.data().toString().contains('threads') ? doc.get('threads') : '1',
          year: doc.data().toString().contains('year') ? doc.get('year') : '2000',
          benchScore: doc.data().toString().contains('benchScore') ? doc.get('benchScore') : '1',
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
          manufacturer: doc.data().toString().contains('manufacturer') ? doc.get('manufacturer') : 'Nieznaleziono',
          model: doc.data().toString().contains('model') ? doc.get('model') : 'Nieznaleziono',
          capacity: doc.data().toString().contains('capacity') ? doc.get('capacity') : '1',
          connectionType: doc.data().toString().contains('connectionType') ? doc.get('connectionType') : 'Nieznaleziono',
          type: doc.data().toString().contains('type') ? doc.get('type') : 'Nieznaleziono',
          img: img
      );
    }).toList();
  }
  Stream<List<Drive>> get drives {
    if(dodaj.extraDrives.length>0){
      if(dodaj.usedNvme==false && dodaj.extraDrives.length < int.parse(dodaj.chosenMtb.sataPorts))
        return FirebaseFirestore.instance.collection('drives').snapshots().map(driveListFromSnapshot);
      else if(dodaj.usedNvme==true)
        return FirebaseFirestore.instance.collection('drives').where('connectionType', isEqualTo: 'SATA')
            .snapshots().map(driveListFromSnapshot);
      else
        return FirebaseFirestore.instance.collection('drives').where('connectionType', isEqualTo: 'NVMe')
            .snapshots().map(driveListFromSnapshot);
    }
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
          manufacturer: doc.data().toString().contains('manufacturer') ? doc.get('manufacturer') : 'Nieznaleziono',
          model: doc.data().toString().contains('model') ? doc.get('model') : 'Nieznaleziono',
          chipset: doc.data().toString().contains('chipset') ? doc.get('chipset') : 'Nieznaleziono',
          hasNvmeSlot: doc.data().toString().contains('hasNvmeSlot') ? doc.get('hasNvmeSlot') : false,
          ramSlots: doc.data().toString().contains('ramSlots') ? doc.get('ramSlots') : '1',
          ramType: doc.data().toString().contains('ramType') ? doc.get('ramType') : 'Nieznaleziono',
          socket: doc.data().toString().contains('socket') ? doc.get('socket') : 'Nieznaleziono',
          standard: doc.data().toString().contains('standard') ? doc.get('standard') : 'Nieznaleziono',
          img: img,
          wifi: doc.data().toString().contains('wifi') ? doc.get('wifi') : false,
          usb3: doc.data().toString().contains('usb3') ? doc.get('usb3') : '1',
          usb2and1: doc.data().toString().contains('usb2and1') ? doc.get('usb2and1') : '1',
          ethernetSpeed: doc.data().toString().contains('ethernetSpeed') ? doc.get('ethernetSpeed') : '1',
          sataPorts: doc.data().toString().contains('sataPorts') ? doc.get('sataPorts') : '1'
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
     
      return FirebaseFirestore.instance.collection('motherboard')
          .where('ramType', isEqualTo: ramRamType).where(
          'socket', isEqualTo: cpuSocket)
          .snapshots().map(motherboardListFromSnapshot);
    }
    else if(caseStandard!=null) {
      
      return FirebaseFirestore.instance
            .collection('motherboard').where('standard', whereIn: caseStandard)
            .where('ramType', isEqualTo: ramRamType)
            .where('socket', isEqualTo: cpuSocket)
            .where('hasNvmeSlot', isEqualTo: true).snapshots().map(motherboardListFromSnapshot);

    } else
   
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
          manufacturer: doc.data().toString().contains('manufacturer') ? doc.get('manufacturer') : 'Nieznaleziono',
          model: doc.data().toString().contains('model') ? doc.get('model') : 'Nieznaleziono',
          power: doc.data().toString().contains('power') ? doc.get('power') : '1',
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
          manufacturer: doc.data().toString().contains('manufacturer') ? doc.get('manufacturer') : 'Nieznaleziono',
          model: doc.data().toString().contains('model') ? doc.get('model') : 'Nieznaleziono',
          capacity: doc.data().toString().contains('capacity') ? doc.get('capacity') : '1',
          speed: doc.data().toString().contains('speed') ? doc.get('speed') : '1',
          type: doc.data().toString().contains('type') ? doc.get('type') : 'Nieznaleziono',
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
        uid: doc.data().toString().contains('uid') ? doc.get('uid') : 'Error not found',
        minTdp: doc.data().toString().contains('minTdp') ? doc.get('minTdp') : 'Error not found',
        maxTdp: doc.data().toString().contains('maxTdp') ? doc.get('maxTdp') : 'Error not found',
        extradisk: List.from(doc.data().toString().contains('extradisk') ? doc.get('extradisk') : 'Error not found'),
        ramNumber: doc.data().toString().contains('ramNumber') ? doc.get('ramNumber') : 'Error not found',
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
      if(url.toLowerCase()=='amd')url='radeon';
      Image img=Image.asset("assets/companies logo/"+url.toLowerCase()+".png");
      print('gpuuuuuuuuuuuuu'+url);
      chosenGpu=Gpu(
          VRAM: doc.data().toString().contains('VRAM') ? doc.get('VRAM') : '1',
          manufacturer: doc.data().toString().contains('manufacturer') ? doc.get('manufacturer') : 'Nieznaleziono',
          model: doc.data().toString().contains('model') ? doc.get('model') : 'Nieznaleziono',
          year: doc.data().toString().contains('year') ? doc.get('year') : '2000',
          series: doc.data().toString().contains('series') ? doc.get('series') : 'Nieznaleziono',
          tdp: doc.data().toString().contains('tdp') ? doc.get('tdp') : '1',
          integra: doc.data().toString().contains('integra') ? doc.get('integra') : false,
          img:img
      );
    }).toList();
    return chosenGpu;
  }
  Future<Cooler> addCooler() async{
    Cooler chosenCooler;
    var snapshot= await FirebaseFirestore.instance
        .collection("coolers")
        .where("model", isEqualTo: 'Fabryczne ch??odzenie')
        .get();
    snapshot.docs.map((doc){
      chosenCooler=Cooler(
          manufacturer: doc.data().toString().contains('manufacturer') ? doc.get('manufacturer') : 'Nieznaleziono',
          model: doc.data().toString().contains('model') ? doc.get('model') : 'Nieznaleziono',
          socket: doc.data().toString().contains('socket') ? doc.get('socket') : 'Nieznaleziono',
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
          manufacturer: doc.data().toString().contains('manufacturer') ? doc.get('manufacturer') : 'Nieznaleziono',
          model: doc.data().toString().contains('model') ? doc.get('model') : 'Nieznaleziono',
          capacity: doc.data().toString().contains('capacity') ? doc.get('capacity') : '1',
          connectionType: doc.data().toString().contains('connectionType') ? doc.get('connectionType') : 'Nieznaleziono',
          type: doc.data().toString().contains('type') ? doc.get('type') : 'Nieznaleziono',
          img: img
      );
    }).toList();
  }
  Stream<List<Drive>> get extradrives {
    if(dodaj.chosenDrive!=null)
      if(dodaj.chosenDrive.connectionType=="SATA" && dodaj.chosenMtb.hasNvmeSlot==true && dodaj.slots==1 && dodaj.usedNvme==false)
        return FirebaseFirestore.instance.collection('drives').where('connectionType', isEqualTo: 'NVMe')
            .snapshots().map(driveListFromSnapshot);
    if(dodaj.usedNvme==false && dodaj.extraDrives.length < int.parse(dodaj.chosenMtb.sataPorts))
      return FirebaseFirestore.instance.collection('drives').snapshots().map(driveListFromSnapshot);
    else if(dodaj.usedNvme==true)
      return FirebaseFirestore.instance.collection('drives').where('connectionType', isEqualTo: 'SATA')
          .snapshots().map(driveListFromSnapshot);
    else
      return FirebaseFirestore.instance.collection('drives').where('connectionType', isEqualTo: 'NVMe')
          .snapshots().map(driveListFromSnapshot);
  }
}

