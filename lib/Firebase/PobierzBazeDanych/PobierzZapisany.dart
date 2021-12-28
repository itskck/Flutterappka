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
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:skladappka/Porownywarka/Porownywarka.dart';

class getFromSaved {
  static Cpu chosenCpu;
  static Psu chosenPsu;
  static Motherboard chosenMtb;
  static Drive chosenDrive;
  static Ram chosenRam;
  static Case chosenCase;
  static Gpu chosenGpu;
  static Cooler chosenCooler;
  static String uid;
  String id;
  Builds builds;
  getFromSaved({this.id,this.builds});
  List<Drive> extradisk;


  Future<Cpu> getCpu() async{

    var snapshot= await FirebaseFirestore.instance
        .collection("cpus")
        .where("model", isEqualTo: id)
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
          img:img
      );
    }).toList();
    return chosenCpu;
  }

  Future<Gpu> getGpu() async{

    var snapshot= await FirebaseFirestore.instance
        .collection("gpus")
        .where("model", isEqualTo: id)
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
          integra: doc.data().toString().contains('integra')? doc.get('integra'): 'Error',
          img:img
      );
    }).toList();
    return chosenGpu;
  }

  Future<Case> getCase() async{


    var snapshot= await FirebaseFirestore.instance
        .collection("cases")
        .where("model", isEqualTo: id)
        .get();
    snapshot.docs.map((doc){
      String url=doc.data().toString().contains('manufacturer') ? doc.get('manufacturer') : 'placeholder';
      Image img=Image.asset("assets/companies logo/"+url.toLowerCase()+".png");
      chosenCase=Case(
          manufacturer: doc.data().toString().contains('manufacturer') ? doc.get('manufacturer') : 'Nieznaleziono',
          model: doc.data().toString().contains('model') ? doc.get('model') : 'Nieznaleziono',
          standard: doc.data().toString().contains('standard') ? doc.get('standard') : 'Nieznaleziono',
          img:img
      );
    }).toList();
    return chosenCase;
  }

  Future<Cooler> getCooler() async{


    var snapshot= await FirebaseFirestore.instance
        .collection("coolers")
        .where("model", isEqualTo: id)
        .get();
    snapshot.docs.map((doc){
      String url=doc.data().toString().contains('manufacturer') ? doc.get('manufacturer') : 'placeholder';
      Image img=Image.asset("assets/companies logo/"+url.toLowerCase()+".png");
      chosenCooler=Cooler(
          manufacturer: doc.data().toString().contains('manufacturer') ? doc.get('manufacturer') : 'Nieznaleziono',
          model: doc.data().toString().contains('model') ? doc.get('model') : 'Nieznaleziono',
          socket: doc.data().toString().contains('socket') ? doc.get('socket') : 'Nieznaleziono',
          img:img
      );
    }).toList();
    return chosenCooler;
  }

  Future<Drive> getDrive() async{

    var snapshot= await FirebaseFirestore.instance
        .collection("drives")
        .where("model", isEqualTo: id)
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
          img:img
      );
    }).toList();
    return chosenDrive;
  }

  Future<Motherboard> getMotherboard() async{

    var snapshot= await FirebaseFirestore.instance
        .collection("motherboard")
        .where("model", isEqualTo: id)
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
          img:img,
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

    var snapshot= await FirebaseFirestore.instance
        .collection("psus")
        .where("model", isEqualTo: id)
        .get();
    snapshot.docs.map((doc){
      String url=doc.data().toString().contains('manufacturer') ? doc.get('manufacturer') : 'placeholder';
      Image img=Image.asset("assets/companies logo/"+url.toLowerCase()+".png");
      chosenPsu=Psu(
          manufacturer: doc.data().toString().contains('manufacturer') ? doc.get('manufacturer') : 'Nieznaleziono',
          model: doc.data().toString().contains('model') ? doc.get('model') : 'Nieznaleziono',
          power: doc.data().toString().contains('power') ? doc.get('power') : 'Nieznaleziono',
          img:img
      );
    }).toList();
    return chosenPsu;
  }
  Future<String> getUid()async{
    
  }
  Future<Ram> getRam() async{

    var snapshot= await FirebaseFirestore.instance
        .collection("rams")
        .where("model", isEqualTo: id)
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
          img:img
      );
    }).toList();
    return chosenRam;
  }

  Future<List<Drive>> setExtra() async{
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