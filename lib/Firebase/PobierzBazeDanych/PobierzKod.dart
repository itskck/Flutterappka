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
import 'package:skladappka/Firebase/Builds.dart';
import 'package:skladappka/Firebase/PobierzBazeDanych/PobierzZapisany.dart';
class getFromCode {
  static Cpu chosenCpu;
  static Psu chosenPsu;
  static Motherboard chosenMtb;
  static Drive chosenDrive;
  static Ram chosenRam;
  static Case chosenCase;
  static Gpu chosenGpu;
  static Cooler chosenCooler;
  static String uid;
  static Builds builds;
  String code;
  List<Drive> extradisk;
  getFromCode({this.code});
  
  Future<bool> corrCode() async{
    final QuerySnapshot result=await FirebaseFirestore.instance
        .collection("builds")
        .where("generatedCode", isEqualTo: code)
        .limit(1)
        .get(); //pobranie dokumentu o odpowiednim kodzie z bazy
    final List<DocumentSnapshot> documents=result.docs;
    if(documents.length==1) return true; //jesli lista dokumentow jest rowna 1 to dokument istnieje
    else return false; //w przeciwnym wypadku dokument nie istnieje
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
      String url=doc.data().toString().contains('manufacturer') ? doc.get('manufacturer') : 'placeholder';
      Image img=Image.asset("assets/companies logo/"+url.toLowerCase()+".png");
      chosenCpu=Cpu(
          benchScore: doc.data().toString().contains('benchScore') ? doc.get('benchScore') : 'Nieznaleziono',
          manufacturer: doc.data().toString().contains('manufacturer') ? doc.get('manufacturer') : 'Nieznaleziono',
          model: doc.data().toString().contains('model') ? doc.get('model') : 'Nieznaleziono',
          clocker: doc.data().toString().contains('clock') ? doc.get('clock') : 'Nieznaleziono',
          cores: doc.data().toString().contains('cores') ? doc.get('cores') : 'Nieznaleziono',
          hasGpu: doc.data().toString().contains('hasGpu') ? doc.get('hasGpu') : 'Nieznaleziono',
          isCoolerIncluded: doc.data().toString().contains('isCoolerIncluded') ? doc.get('isCoolerIncluded') : 'Nieznaleziono',
          isUnlocked: doc.data().toString().contains('isUnlocked') ? doc.get('isUnlocked') : 'Nieznaleziono',
          socket: doc.data().toString().contains('socket') ? doc.get('socket') : 'Nieznaleziono',
          tdp: doc.data().toString().contains('tdp') ? doc.get('tdp') : 'Nieznaleziono',
          threads: doc.data().toString().contains('threads') ? doc.get('threads') : 'Nieznaleziono',
          year: doc.data().toString().contains('year') ? doc.get('year') : 'Nieznaleziono',
          img: img
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
      String url=doc.data().toString().contains('manufacturer') ? doc.get('manufacturer') : 'placeholder';
      Image img=Image.asset("assets/companies logo/"+url.toLowerCase()+".png");
      chosenGpu=Gpu(
          benchScore: doc.data().toString().contains('benchScore') ? doc.get('benchScore') : 'Nieznaleziono',
          VRAM: doc.data().toString().contains('VRAM') ? doc.get('VRAM') : 'Nieznaleziono',
          manufacturer: doc.data().toString().contains('manufacturer') ? doc.get('manufacturer') : 'Nieznaleziono',
          model: doc.data().toString().contains('model') ? doc.get('model') : 'Nieznaleziono',
          year: doc.data().toString().contains('year') ? doc.get('year') : 'Nieznaleziono',
          series: doc.data().toString().contains('series') ? doc.get('series') : 'Nieznaleziono',
          tdp: doc.data().toString().contains('tdp') ? doc.get('tdp') : 'Nieznaleziono',
          img: img
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
      String url=doc.data().toString().contains('manufacturer') ? doc.get('manufacturer') : 'placeholder';
      Image img=Image.asset("assets/companies logo/"+url.toLowerCase()+".png");
      chosenCase=Case(
          manufacturer: doc.data().toString().contains('manufacturer') ? doc.get('manufacturer') : 'Nieznaleziono',
          model: doc.data().toString().contains('model') ? doc.get('model') : 'Nieznaleziono',
          standard: doc.data().toString().contains('standard') ? doc.get('standard') : 'Nieznaleziono',
          img: img
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
      String url=doc.data().toString().contains('manufacturer') ? doc.get('manufacturer') : 'placeholder';
      Image img=Image.asset("assets/companies logo/"+url.toLowerCase()+".png");
      chosenCooler=Cooler(
          manufacturer: doc.data().toString().contains('manufacturer') ? doc.get('manufacturer') : 'Nieznaleziono',
          model: doc.data().toString().contains('model') ? doc.get('model') : 'Nieznaleziono',
          socket: doc.data().toString().contains('socket') ? doc.get('socket') : 'Nieznaleziono',
          img: img
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
      String url=doc.data().toString().contains('manufacturer') ? doc.get('manufacturer') : 'placeholder';
      Image img=Image.asset("assets/companies logo/"+url.toLowerCase()+".png");
      chosenDrive=Drive(
          manufacturer: doc.data().toString().contains('manufacturer') ? doc.get('manufacturer') : 'Nieznaleziono',
          model: doc.data().toString().contains('model') ? doc.get('model') : 'Nieznaleziono',
          capacity: doc.data().toString().contains('capacity') ? doc.get('capacity') : 'Nieznaleziono',
          connectionType: doc.data().toString().contains('connectionType') ? doc.get('connectionType') : 'Nieznaleziono',
          type: doc.data().toString().contains('type') ? doc.get('type') : 'Nieznaleziono',
          img: img
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
      String url=doc.data().toString().contains('manufacturer') ? doc.get('manufacturer') : 'placeholder';
      Image img=Image.asset("assets/companies logo/"+url.toLowerCase()+".png");
      chosenMtb=Motherboard(
          manufacturer: doc.data().toString().contains('manufacturer') ? doc.get('manufacturer') : 'Nieznaleziono',
          model: doc.data().toString().contains('model') ? doc.get('model') : 'Nieznaleziono',
          chipset: doc.data().toString().contains('chipset') ? doc.get('chipset') : 'Nieznaleziono',
          hasNvmeSlot: doc.data().toString().contains('hasNvmeSlot') ? doc.get('hasNvmeSlot') : 'Nieznaleziono',
          ramSlots: doc.data().toString().contains('ramSlots') ? doc.get('ramSlots') : 'Nieznaleziono',
          ramType: doc.data().toString().contains('ramType') ? doc.get('ramType') : 'Nieznaleziono',
          socket: doc.data().toString().contains('socket') ? doc.get('socket') : 'Nieznaleziono',
          standard: doc.data().toString().contains('standard') ? doc.get('standard') : 'Nieznaleziono',
          img: img,
          wifi: doc.data().toString().contains('wifi') ? doc.get('wifi') : false,
          usb3: doc.data().toString().contains('usb3') ? doc.get('usb3') : 'Nieznaleziono',
          usb2and1: doc.data().toString().contains('usb2and1') ? doc.get('usb2and1') : 'Nieznaleziono',
          ethernetSpeed: doc.data().toString().contains('ethernetSpeed') ? doc.get('ethernetSpeed') : 'Nieznaleziono',
          sataPorts: doc.data().toString().contains('sataPorts') ? doc.get('sataPorts') : 'Nieznaleziono'
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
      String url=doc.data().toString().contains('manufacturer') ? 
      doc.get('manufacturer') : 'placeholder';
      Image img=Image.asset("assets/companies logo/"+url.toLowerCase()+".png");
      chosenPsu=Psu(
          manufacturer: doc.data().toString().contains('manufacturer') ? 
          doc.get('manufacturer') : 'Nieznaleziono',
          model: doc.data().toString().contains('model') ? 
          doc.get('model') : 'Nieznaleziono',
          power: doc.data().toString().contains('power') ? 
          doc.get('power') : 'Nieznaleziono',
          img: img
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
      String url=doc.data().toString().contains('manufacturer') ? doc.get('manufacturer') : 'placeholder';
      Image img=Image.asset("assets/companies logo/"+url.toLowerCase()+".png");
      chosenRam=Ram(
          benchScore: doc.data().toString().contains('benchScore') ? doc.get('benchScore') : 'Nieznaleziono',
          manufacturer: doc.data().toString().contains('manufacturer') ? doc.get('manufacturer') : 'Nieznaleziono',
          model: doc.data().toString().contains('model') ? doc.get('model') : 'Nieznaleziono',
          capacity: doc.data().toString().contains('capacity') ? doc.get('capacity') : 'Nieznaleziono',
          speed: doc.data().toString().contains('speed') ? doc.get('speed') : 'Nieznaleziono',
          type: doc.data().toString().contains('type') ? doc.get('type') : 'Nieznaleziono',
          img: img
      );
    }).toList();
    return chosenRam;
  }
  Future<String> getUid() async{
    var ktoro;
    await FirebaseFirestore.instance.collection("builds")
    .where('generatedCode', isEqualTo: code)
    .get()
    .then((QuerySnapshot result) => {
      result.docs.forEach((element) {
        ktoro=element['uid'];
      })
    });
    return ktoro;
  }
  //pobieranie builda
  Future<Builds> getBuild() async{
    var snapshot= await FirebaseFirestore.instance
        .collection("builds")
        .where("generatedCode", isEqualTo: code)
        .get(); //pobranie odpowiedniego dokumentu
    snapshot.docs.map((doc){
      builds=Builds(
          cpuId: doc.data().toString().contains('cpuId') ? 
          doc.get('cpuId') : 'Nieznaleziono',
          caseId: doc.data().toString().contains('caseId') ? 
          doc.get('caseId') : 'Nieznaleziono',
          coolerId: doc.data().toString().contains('coolerId') ?
          doc.get('coolerId') : 'Nieznaleziono',
          driveId: doc.data().toString().contains('driveId') ? 
          doc.get('driveId') : 'Nieznaleziono',
          generatedCode: doc.data().toString().contains('generatedCode') ? 
          doc.get('generatedCode') : 'Nieznaleziono',
          gpuId: doc.data().toString().contains('gpuId') ? 
          doc.get('gpuId') : 'Nieznaleziono',
          motherboardId: doc.data().toString().contains('motherboardId') ? 
          doc.get('motherboardId') : 'Nieznaleziono',
          psuId: doc.data().toString().contains('psuId') ? 
          doc.get('psuId') : 'Nieznaleziono',
          ramId: doc.data().toString().contains('ramId') ? 
          doc.get('ramId') : 'Nieznaleziono',
          timestamp: doc.data().toString().contains('timestamp') ?
          doc.get('timestamp') : 'Nieznaleziono',
          uid: doc.data().toString().contains('uid') ? 
          doc.get('uid') : 'Nieznaleziono',
          minTdp: doc.data().toString().contains('minTdp') ? 
          doc.get('minTdp') : 'Nieznaleziono',
          maxTdp: doc.data().toString().contains('maxTdp') ? 
          doc.get('maxTdp') : 'Nieznaleziono',
          extradisk: List.from(doc.data().toString().contains('extradisk') ? 
          doc.get('extradisk') : 'Nieznaleziono'),
          ramNumber: doc.data().toString().contains('ramNumber') ? 
          doc.get('ramNumber') : 'Nieznaleziono',
      );
    }).toList(); //stworzenie obiektu typu Builds na podstawie pobranego dokumentu
    return builds; //zwrocenie tego obiektu
  }

  Future<List<Drive>> setExtra() async{
    await(getBuild());
    extradisk = new List<Drive>();
    String number="", disk="";
    int space=0, numberint;
    if(builds.extradisk[0]=="Brak"){
      return extradisk;
    }
    for(int i=0; i<builds.extradisk.length;i++){
      while(builds.extradisk[i][space]!=" "){
        print("dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd");
        print(builds.extradisk[i][space]);
        number+=builds.extradisk[i][space];
        space++;
      }
      space++;
      print("cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc");
      print(builds.extradisk[i][space]);
      for(;space<builds.extradisk[i].length;space++)
        disk+=builds.extradisk[i][space];
      space=0;
      numberint=int.parse(number);
      number="";
      for(int j=0;j<numberint;j++){
        extradisk.add(await getFromSaved(id: disk).getDrive());
      }
      disk="";
    }
    // print("cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc");
    //print(extradisk.length);
    return extradisk;
  }

}