import 'dart:ffi';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:skladappka/Firebase/Case.dart';
import 'package:skladappka/Firebase/Cooler.dart';
import 'package:skladappka/Firebase/Cpu.dart';
import 'package:skladappka/Firebase/Drive.dart';
import 'package:skladappka/Firebase/Gpu.dart';
import 'package:skladappka/Firebase/Motherboard.dart';
import 'package:skladappka/Firebase/Psu.dart';
import 'package:skladappka/Firebase/Ram.dart';
import 'package:flutter/material.dart';
import 'package:blur/blur.dart';
import 'package:skladappka/dodawanieZestawu/OknoDialogoweWidget.dart';
import 'package:skladappka/Firebase/DodajDoBazyDanych/DodajDoBazyDanych.dart';
import 'package:skladappka/Firebase/FireBase.dart';
import 'package:skladappka/Logowanie/Zalogowany.dart';
import 'package:skladappka/Cache.dart' as cache;
import 'package:skladappka/main.dart';

class Edit extends StatefulWidget with ChangeNotifier {
  static Cpu chosenCpu;
  static Psu chosenPsu;
  static Motherboard chosenMtb;
  static Drive chosenDrive;
  static Ram chosenRam;
  static Case chosenCase;
  static Gpu chosenGpu;
  static Cooler chosenCooler;
  static List<Widget> panelsGrid;
  static List<Drive> extraDrives;
  static int extra = -1;
  static bool usedNvme = false;
  static int pom1 = 8;
  static int slots = 0;
  static double iloscRam=1.0;

  final Cpu cpu;
  final Psu psu;
  final Motherboard mtb;
  final Drive drive;
  final Ram ram;
  final Case cases;
  final Gpu gpu;
  final Cooler cooler;
  final String code;
  final bool diffUser;
  final double minTdp,maxTdp;
  final List<Drive> extradisk;
  final double ramNumber;

  Edit(
      {this.cpu,
        this.psu,
        this.mtb,
        this.drive,
        this.ram,
        this.cases,
        this.gpu,
        this.cooler,
        this.code,
        this.diffUser,
        this.maxTdp,
        this.minTdp,
        this.extradisk,
        this.ramNumber});

  @override
  _Edit createState() => _Edit();
}

class _Edit extends State<Edit> {
  double minTdp, maxTdp;
  FireBase base = FireBase();
  String pom;
  @override
  initState() {
    super.initState();
    setComponents();
    print(Skladapka.test);
  }

  void setComponents(){
    Edit.chosenCpu=widget.cpu;
    Edit.chosenPsu=widget.psu;
    Edit.chosenMtb=widget.mtb;
    Edit.chosenDrive=widget.drive;
    Edit.chosenRam=widget.ram;
    Edit.chosenCase=widget.cases;
    Edit.chosenGpu=widget.gpu;
    if(widget.cooler.model!='Fabryczne chłodzenie') {
      Edit.chosenCooler = widget.cooler;
      base.coolerSocket=Edit.chosenCooler.socket;
    }
    base.cpuSocket = Edit.chosenCpu.socket;

    base.mtbRamType=Edit.chosenMtb.ramType;
    base.mtbNvmeSlot=Edit.chosenMtb.hasNvmeSlot;
    base.mtbSocket=Edit.chosenMtb.socket;
    base.mtbStandard=Edit.chosenMtb.standard;

    base.driveConnectionType=Edit.chosenDrive.connectionType;
    base.caseStandard=Edit.chosenCase.standard;
    base.ramRamType = Edit.chosenRam.type;
    minTdp=widget.minTdp;
    maxTdp=widget.maxTdp;
    Edit.extraDrives=widget.extradisk;
    Edit.iloscRam=widget.ramNumber.toDouble();
    if(Edit.chosenMtb.hasNvmeSlot==true){
      if(Edit.chosenDrive.connectionType=="NVMe")
        Edit.usedNvme=true;
      else
        for(int i=0;i<Edit.extraDrives.length;i++){
            if(Edit.extraDrives[i].connectionType=="NVMe")
              Edit.usedNvme=true;
          }

    }

      Edit.extra=Edit.extraDrives.length-1;
    if(Edit.usedNvme==true)
    Edit.slots=int.parse(Edit.chosenMtb.sataPorts)-Edit.extraDrives.length;
    else
      Edit.slots=int.parse(Edit.chosenMtb.sataPorts)-(Edit.extraDrives.length + 1);
    print("JEstem tu");
    setState(() { });
  }

  dialogWidget dialogwidget = new dialogWidget();


  Widget componentsList(String component) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.8,
    );
  }

  Widget addButton(String component, String background) {
    return GestureDetector(
        onTap: () async {
          if (Skladapka.connectivityResult != ConnectivityResult.none) {
            if (Edit.chosenGpu != null) if (Edit.chosenGpu.integra == true)
              Edit.chosenGpu = null;
            if(component=="RAM" && Edit.chosenMtb==null)
              Fluttertoast.showToast(
                  msg: "Wybierz najpierw płytę główną",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 2);
            else
              await dialogwidget.showPopup(context, component, base);
            if (component == 'CPU' && Edit.chosenCpu != null) {
              minTdp += double.parse(Edit.chosenCpu.tdp) * 0.9;
              maxTdp += double.parse(Edit.chosenCpu.tdp);
              base.cpuSocket = Edit.chosenCpu.socket;
            } else {
              if (component == 'CSTM COOLER' && Edit.chosenCooler != null) {
                minTdp += 1.0;
                maxTdp += 2.0;
                base.coolerSocket = Edit.chosenCooler.socket;
              }
            }

            if (component == 'MTBRD' && Edit.chosenMtb != null) {
              minTdp += 40;
              maxTdp += 60;
              base.mtbRamType = Edit.chosenMtb.ramType;
              base.mtbNvmeSlot = Edit.chosenMtb.hasNvmeSlot;
              base.mtbSocket = Edit.chosenMtb.socket;
              base.mtbStandard = Edit.chosenMtb.standard;
            }
            if (component == 'DRIVE' && Edit.chosenDrive != null) {
              if (Edit.chosenDrive.type == "HDD") {
                minTdp += 1.5;
                maxTdp += 2.5;
              } else {
                minTdp += 0.5;
                maxTdp += 1;
              }
              base.driveConnectionType = Edit.chosenDrive.connectionType;
            }

            if (component == 'CASE' && Edit.chosenCase != null) {
              base.caseStandard = Edit.chosenCase.standard;
            }

            if (component == 'RAM' && Edit.chosenRam != null) {
              minTdp += Edit.iloscRam*30;
              maxTdp += Edit.iloscRam*60;
              base.ramRamType = Edit.chosenRam.type;
            }
            if (component == 'GPU' && Edit.chosenGpu != null) {
              minTdp += double.parse(Edit.chosenGpu.tdp);
              maxTdp += double.parse(Edit.chosenGpu.tdp);
            }
            if(component == 'EXTRA DRIVE'){
              for(int i=0;i<Edit.extraDrives.length;i++){
                if(Edit.extraDrives[i].connectionType=="NVMe")
                  base.mtbNvmeSlot=false;
              }
            }
            setState(() {});
          } else
            Fluttertoast.showToast(
                msg: "Brak połączenia z internetem",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 2);
        },
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: 15),
                child: Text(
                  background,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      fontFamily: GoogleFonts.workSans().fontFamily,
                      color: Colors.white),
                ),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(15, 0, 15, 15),
                  padding: EdgeInsets.all(4),
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.width * 0.4,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color.fromRGBO(142, 223, 255, 1),
                            Color.fromRGBO(255, 0, 140, 1)
                          ])),
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color.fromRGBO(45, 45, 45, 1),
                              Color.fromRGBO(59, 55, 68, 1)
                            ])),
                    child: GradientText(
                      '+',
                      colors: [Colors.white, Colors.white],
                      style: TextStyle(fontSize: 120),
                    ),
                  )),
            ],
          ),
        ));
  }

  Widget emptyBar() {
    return Opacity(
        opacity: 0,
        child: Container(height: 50, width: MediaQuery.of(context).size.width));
  }

  Widget styledTextBar(String content) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: Align(
          alignment: Alignment.center,
          child: GradientText(content,
              colors: [Colors.lightBlue[300], Color.fromRGBO(178, 150, 255, 1)],
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: GoogleFonts.workSans().fontFamily,
                fontWeight: FontWeight.normal,
                fontSize: 22,
                letterSpacing: 2,
              ))),
    );
  }

  Widget itemFrame(
      String model, String component, Image photoURL, String background) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 15),
          child: Text(
            background,
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w800,
                fontFamily: GoogleFonts.workSans().fontFamily,
                color: Colors.white),
          ),
        ),
        Container(
            margin: EdgeInsets.fromLTRB(15, 0, 15, 15),
            width: MediaQuery.of(context).size.width * 0.4,
            height: MediaQuery.of(context).size.width * 0.4,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.lightBlue[300],
                      Color.fromRGBO(178, 150, 255, 1)
                    ])),
            child: Stack(fit: StackFit.passthrough, children: <Widget>[
              Container(
                  margin: EdgeInsets.fromLTRB(15, 0, 15, 15),
                  padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                  child: photoURL),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    model,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: GoogleFonts.workSans().fontFamily,
                        fontWeight: FontWeight.normal,
                        fontSize: 15,
                        letterSpacing: 2,
                        color: Colors.white),
                  )),
              GestureDetector(
                onTap: () {
                  switch (component) {
                    case 'CPU':
                      setState(() {
                        minTdp -= double.parse(Edit.chosenCpu.tdp) * 0.9;
                        maxTdp -= double.parse(Edit.chosenCpu.tdp);
                        base.cpuSocket = null;
                        if (Edit.chosenGpu != null) if (Edit
                            .chosenCpu.hasGpu !=
                            "none" &&
                            Edit.chosenGpu.integra == true)
                          Edit.chosenGpu = null;
                        Edit.chosenCpu = null;
                      });
                      break;
                    case 'PSU':
                      setState(() {
                        Edit.chosenPsu = null;
                      });
                      break;
                    case 'GPU':
                      minTdp -= double.parse(Edit.chosenGpu.tdp);
                      maxTdp -= double.parse(Edit.chosenGpu.tdp);
                      setState(() {
                        Edit.chosenGpu = null;
                      });
                      break;
                    case 'CSTM COOLER':
                      minTdp -= 1.0;
                      maxTdp -= 2.0;
                      setState(() {
                        base.coolerSocket = null;
                        Edit.chosenCooler = null;
                      });
                      break;
                    case 'MTBRD':
                      minTdp -= 40;
                      maxTdp -= 60;
                      if(Edit.chosenRam!=null) {
                        minTdp -= 30*Edit.iloscRam;
                        maxTdp -= 60*Edit.iloscRam;
                      }
                      setState(() {
                        base.mtbRamType = null;
                        base.mtbNvmeSlot = null;
                        base.mtbStandard = null;
                        base.caseStandard = null;
                        Edit.chosenMtb = null;
                        base.mtbSocket = null;
                        Edit.extraDrives = new List<Drive>();
                        Edit.extra = -1;
                        Edit.usedNvme = true;
                        Edit.pom1 = 8;
                        Edit.slots = 0;
                        if(Edit.chosenRam!=null){
                          Edit.iloscRam=1;
                          base.ramRamType = null;
                          Edit.chosenRam = null;
                        }
                      });
                      break;
                    case 'DRIVE':
                      if (Edit.chosenDrive.type == "HDD") {
                        minTdp -= 1.5;
                        maxTdp -= 2.5;
                      } else {
                        minTdp -= 0.5;
                        maxTdp -= 1;
                      }
                      if(Edit.chosenDrive.connectionType=="NVMe")
                        Edit.usedNvme=false;
                      //Edit.slots++;
                      setState(() {
                        base.driveConnectionType = null;
                        Edit.chosenDrive = null;
                      });
                      break;
                    case 'CASE':
                      setState(() {
                        base.caseStandard = null;
                        Edit.chosenCase = null;
                      });
                      break;
                    case 'RAM':
                      minTdp -= 30*Edit.iloscRam;
                      maxTdp -= 60*Edit.iloscRam;
                      setState(() {
                        base.ramRamType = null;
                        Edit.chosenRam = null;
                        Edit.iloscRam=1;
                      });
                      break;
                    case 'EXTRA DRIVE':
                      switch (background) {
                        case 'DODATKOWY DYSK 10':
                          print("Ja przepraszam zabladzilem");
                          if(Edit.extraDrives[9].connectionType=="NVMe")
                            base.mtbNvmeSlot=true;
                          if (Edit.extraDrives[9].type == 'HDD') {
                            minTdp -= 1.5;
                            maxTdp -= 2.5;
                          } else {
                            minTdp -= 0.5;
                            maxTdp -= 1;
                          }
                          if(Edit.extraDrives[9].connectionType=="NVMe") Edit.usedNvme=false;
                          setState(() {
                            Edit.extraDrives.removeAt(9);
                          });
                          break;
                        case 'DODATKOWY DYSK 1':
                          if(Edit.extraDrives[0].connectionType=="NVMe")
                            base.mtbNvmeSlot=true;
                          if (Edit.extraDrives[0].type == 'HDD') {
                            minTdp -= 1.5;
                            maxTdp -= 2.5;
                          } else {
                            minTdp -= 0.5;
                            maxTdp -= 1;
                          }
                          if(Edit.extraDrives[0].connectionType=="NVMe") Edit.usedNvme=false;
                          setState(() {
                            Edit.extraDrives.removeAt(0);
                          });
                          break;
                        case 'DODATKOWY DYSK 2':
                          if(Edit.extraDrives[1].connectionType=="NVMe")
                            base.mtbNvmeSlot=true;
                          if (Edit.extraDrives[1].type == 'HDD') {
                            minTdp -= 1.5;
                            maxTdp -= 2.5;
                          } else {
                            minTdp -= 0.5;
                            maxTdp -= 1;
                          }
                          if(Edit.extraDrives[1].connectionType=="NVMe") Edit.usedNvme=false;
                          setState(() {
                            Edit.extraDrives.removeAt(1);
                          });
                          break;
                        case 'DODATKOWY DYSK 3':
                          if(Edit.extraDrives[2].connectionType=="NVMe")
                            base.mtbNvmeSlot=true;
                          if (Edit.extraDrives[2].type == 'HDD') {
                            minTdp -= 1.5;
                            maxTdp -= 2.5;
                          } else {
                            minTdp -= 0.5;
                            maxTdp -= 1;
                          }
                          if(Edit.extraDrives[2].connectionType=="NVMe") Edit.usedNvme=false;
                          setState(() {
                            Edit.extraDrives.removeAt(2);
                          });
                          break;
                        case 'DODATKOWY DYSK 4':
                          if(Edit.extraDrives[3].connectionType=="NVMe")
                            base.mtbNvmeSlot=true;
                          if (Edit.extraDrives[3].type == 'HDD') {
                            minTdp -= 1.5;
                            maxTdp -= 2.5;
                          } else {
                            minTdp -= 0.5;
                            maxTdp -= 1;
                          }
                          if(Edit.extraDrives[3].connectionType=="NVMe") Edit.usedNvme=false;
                          setState(() {
                            Edit.extraDrives.removeAt(3);
                          });
                          break;
                        case 'DODATKOWY DYSK 5':
                          if(Edit.extraDrives[4].connectionType=="NVMe")
                            base.mtbNvmeSlot=true;
                          if (Edit.extraDrives[4].type == 'HDD') {
                            minTdp -= 1.5;
                            maxTdp -= 2.5;
                          } else {
                            minTdp -= 0.5;
                            maxTdp -= 1;
                          }
                          if(Edit.extraDrives[4].connectionType=="NVMe") Edit.usedNvme=false;
                          setState(() {
                            Edit.extraDrives.removeAt(4);
                          });
                          break;
                        case 'DODATKOWY DYSK 6':
                          if(Edit.extraDrives[5].connectionType=="NVMe")
                            base.mtbNvmeSlot=true;
                          if (Edit.extraDrives[5].type == 'HDD') {
                            minTdp -= 1.5;
                            maxTdp -= 2.5;
                          } else {
                            minTdp -= 0.5;
                            maxTdp -= 1;
                          }
                          if(Edit.extraDrives[5].connectionType=="NVMe") Edit.usedNvme=false;
                          setState(() {
                            Edit.extraDrives.removeAt(5);
                          });
                          break;
                        case 'DODATKOWY DYSK 7':
                          if(Edit.extraDrives[6].connectionType=="NVMe")
                            base.mtbNvmeSlot=true;
                          if (Edit.extraDrives[6].type == 'HDD') {
                            minTdp -= 1.5;
                            maxTdp -= 2.5;
                          } else {
                            minTdp -= 0.5;
                            maxTdp -= 1;
                          }
                          if(Edit.extraDrives[6].connectionType=="NVMe") Edit.usedNvme=false;
                          setState(() {
                            Edit.extraDrives.removeAt(6);
                          });
                          break;
                        case 'DODATKOWY DYSK 8':
                          if(Edit.extraDrives[7].connectionType=="NVMe")
                            base.mtbNvmeSlot=true;
                          if (Edit.extraDrives[7].type == 'HDD') {
                            minTdp -= 1.5;
                            maxTdp -= 2.5;
                          } else {
                            minTdp -= 0.5;
                            maxTdp -= 1;
                          }
                          if(Edit.extraDrives[7].connectionType=="NVMe") Edit.usedNvme=false;
                          setState(() {
                            Edit.extraDrives.removeAt(7);
                          });
                          break;
                        case 'DODATKOWY DYSK 9':
                          if(Edit.extraDrives[8].connectionType=="NVMe")
                            base.mtbNvmeSlot=true;
                          if (Edit.extraDrives[8].type == 'HDD') {
                            minTdp -= 1.5;
                            maxTdp -= 2.5;
                          } else {
                            minTdp -= 0.5;
                            maxTdp -= 1;
                          }
                          if(Edit.extraDrives[8].connectionType=="NVMe") Edit.usedNvme=false;
                          setState(() {
                            Edit.extraDrives.removeAt(8);
                          });
                          break;
                      }
                      Edit.extra--;
                      Edit.slots++;
                      break;
                  }
                },
                child: Align(
                  alignment: Alignment(1.55, -1.55),
                  child: Container(
                    margin: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Color.fromRGBO(45, 45, 45, 1)),
                    child: Icon(
                      Icons.cancel,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ])),
      ],
    );
  }

  List<Widget> firstPanels;

  @override
  Widget build(BuildContext context) {
    Edit.panelsGrid = [
      addButton('CPU', "PROCESOR"),
      addButton('PSU', 'ZASILACZ'),
      addButton('MTBRD', 'PŁYTA GŁÓWNA'),
      addButton('DRIVE', 'DYSK'),
      addButton('RAM', 'RAM'),
      addButton('CASE', 'OBUDOWA'),
      addButton('GPU', 'KARTA GRAFICZNA'),
      addButton('CSTM COOLER', 'CHŁODZENIE'),
      addButton('EXTRA DRIVE', 'DODATKOWY DYSK 1'),
      addButton('EXTRA DRIVE', 'DODATKOWY DYSK 2'),
      addButton('EXTRA DRIVE', 'DODATKOWY DYSK 3'),
      addButton('EXTRA DRIVE', 'DODATKOWY DYSK 4'),
      addButton('EXTRA DRIVE', 'DODATKOWY DYSK 5'),
      addButton('EXTRA DRIVE', 'DODATKOWY DYSK 6'),
      addButton('EXTRA DRIVE', 'DODATKOWY DYSK 7'),
      addButton('EXTRA DRIVE', 'DODATKOWY DYSK 8'),
      addButton('EXTRA DRIVE', 'DODATKOWY DYSK 9'),
      addButton('EXTRA DRIVE', 'DODATKOWY DYSK 10')
    ];

    if (Edit.chosenCpu != null) {
      setState(() {
        Edit.panelsGrid[0] = itemFrame(
            Edit.chosenCpu.model, 'CPU', Edit.chosenCpu.img, 'PROCESOR');
        print('aaa');
      });
    } else
      Edit.panelsGrid[0] = addButton('CPU', 'PROCESOR');
////////////////////////////////////////////////////////////
    if (Edit.chosenPsu != null) {
      setState(() {
        Edit.panelsGrid[1] = itemFrame(
            Edit.chosenPsu.model, 'PSU', Edit.chosenPsu.img, 'ZASILACZ');
      });
    } else
      Edit.panelsGrid[1] = addButton('PSU', 'ZASILACZ');
////////////////////////////////////////////////////
    if (Edit.chosenMtb != null) {
      setState(() {
        Edit.panelsGrid[2] = itemFrame(Edit.chosenMtb.model, 'MTBRD',
            Edit.chosenMtb.img, 'PŁYTA GŁÓWNA');
      });
    } else
      Edit.panelsGrid[2] = addButton('MTBRD', 'PŁYTA GŁÓWNA');
    ///////////////////////////////////////////////////////
    if (Edit.chosenDrive != null) {
      setState(() {
        Edit.panelsGrid[3] = itemFrame(Edit.chosenDrive.model, 'DRIVE',
            Edit.chosenDrive.img, 'DYSK SYSTEMOWY');
      });
    } else
      Edit.panelsGrid[3] = addButton('DRIVE', 'DYSK');
    ////////////////////////////////////////////////////
    if (Edit.chosenRam != null) {
      setState(() {
        Edit.panelsGrid[4] =
            itemFrame(Edit.chosenRam.model, 'RAM', Edit.chosenRam.img, 'RAM');
      });
    } else
      Edit.panelsGrid[4] = addButton('RAM', 'RAM');
    ////////////////////////////////////////////////////
    if (Edit.chosenCase != null) {
      setState(() {
        Edit.panelsGrid[5] = itemFrame(
            Edit.chosenCase.model, 'CASE', Edit.chosenCase.img, 'OBUDOWA');
      });
    } else
      Edit.panelsGrid[5] = addButton('CASE', 'OBUDOWA');
    ///////////////////////////////////////////////////
    if (Edit.chosenGpu != null) {
      setState(() {
        Edit.panelsGrid[6] = itemFrame(Edit.chosenGpu.model, 'GPU',
            Edit.chosenGpu.img, 'KARTA GRAFICZNA');
      });
    } else
      Edit.panelsGrid[6] = addButton('GPU', 'KARTA GRAFICZNA');
    //////////////////////////////////////////////////////
    if (Edit.chosenCooler != null) {
      setState(() {
        Edit.panelsGrid[7] = itemFrame(Edit.chosenCooler.model, 'CSTM COOLER',
            Edit.chosenCooler.img, 'CHŁODZENIE');
      });
    } else
      Edit.panelsGrid[7] = addButton('CSTM COOLER', 'CHŁODZENIE');
    ///////////////////////////////////////////////////
    if (Edit.extraDrives == null)
      print("CZEMU JEST NULL");
    else
      print(Edit.extraDrives.length);
    if (Edit.chosenMtb != null && Edit.extraDrives.length > 0) {
      setState(() {
        for (int i = 0; i < Edit.extra + 1; i++) {
          print('wykonuje sie');
          var pom=i+1;
          Edit.panelsGrid[i + 8] = itemFrame(Edit.extraDrives[i].model,
              'EXTRA DRIVE', Edit.extraDrives[i].img, 'DODATKOWY DYSK $pom');
        }
      });
    } else
      Edit.panelsGrid[Edit.pom1] = addButton('EXTRA DRIVE', 'DODATKOWY DYSK');

    //if (Edit.panelsGrid != firstPanels)

    //build context gives the layout, when you build widget it will always have this line
    return Stack(children: [
      SingleChildScrollView(
          child: Stack(children: [
            Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment.center,
                direction: Axis.horizontal,
                children: [
                  styledTextBar('↓ Niezbędniki ↓'),
                  for (var i = 0; i < 6; i++) Edit.panelsGrid[i],
                  styledTextBar('↓ Dobrze mieć ↓'),
                  for (var i = 6; i < 8; i++) Edit.panelsGrid[i],
                  for (Edit.pom1 = 8; Edit.pom1 < Edit.extra + 9; Edit.pom1++)
                    Edit.panelsGrid[Edit.pom1],
                  if (Edit.chosenMtb != null)
                    if (Edit.slots > 0) Edit.panelsGrid[Edit.pom1],
                ]),
          ])),
      Align(
        alignment: Alignment(0.92,0.98),
        child: SpeedDial(
          backgroundColor:Colors.lightBlue[300].withOpacity(0.8) ,
          overlayOpacity: 0,
          curve: Curves.linear,
          animatedIcon: AnimatedIcons.menu_arrow,
          direction: SpeedDialDirection.left,
          children: [
            SpeedDialChild(
              child: widget.diffUser==false ? Icon(Icons.edit) : Icon(Icons.save),
              backgroundColor:Colors.lightBlue[300].withOpacity(0.8) ,
              foregroundColor: Colors.white,
              onTap: () async {
                if (Edit.chosenGpu == null && Edit.chosenCpu != null)
                  Edit.chosenGpu = await base.addGpu(Edit.chosenCpu.hasGpu);
                if (Edit.chosenCpu == null ||
                    Edit.chosenRam == null ||
                    Edit.chosenCase == null ||
                    Edit.chosenDrive == null ||
                    Edit.chosenMtb == null ||
                    Edit.chosenPsu == null ||
                    Edit.chosenGpu == null || (Edit.chosenCooler==null && Edit.chosenCpu.isCoolerIncluded==false))
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                            title: Text('Blad'),
                            content: Text(
                                'Nie wybrano ktoregos z niezbednych komponentow lub wybrany procesor '
                                    'nie posiada zintegrowanej karty graficznej'),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Ok')),
                            ]);
                      });
                else
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Dodawanie zestawu'),
                          content:
                          Text('Czy chcesz edytować wybrany zestaw?'),
                          actions: [
                            TextButton(
                                onPressed: () async {
                                  if (Edit.chosenCooler == null)
                                    Edit.chosenCooler = await base.addCooler();
                                  if(widget.diffUser==false)addBuildToDatabse(
                                      chosenCase: Edit.chosenCase,
                                      chosenCooler: Edit.chosenCooler,
                                      chosenCpu: Edit.chosenCpu,
                                      chosenDrive: Edit.chosenDrive,
                                      chosenGpu: Edit.chosenGpu,
                                      chosenMtb: Edit.chosenMtb,
                                      chosenPsu: Edit.chosenPsu,
                                      chosenRam: Edit.chosenRam)
                                      .editBuildData(widget.code);
                                  else addBuildToDatabse(
                                      chosenCase: Edit.chosenCase,
                                      chosenCooler: Edit.chosenCooler,
                                      chosenCpu: Edit.chosenCpu,
                                      chosenDrive: Edit.chosenDrive,
                                      chosenGpu: Edit.chosenGpu,
                                      chosenMtb: Edit.chosenMtb,
                                      chosenPsu: Edit.chosenPsu,
                                      chosenRam: Edit.chosenRam)
                                      .addBuildData();
                                  Navigator.of(context).pop();
                                  cache.ktoro=4;
                                  inicjalizuj(null);
                                },
                                child: Text('Tak')),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Anuluj'))
                          ],
                        );
                      });
              },
            ),
            SpeedDialChild(
                child: Icon(Icons.delete),
                backgroundColor:Colors.lightBlue[300].withOpacity(0.8) ,
                foregroundColor: Colors.white,
                onTap: (){
                  setState(() {
                    Edit.chosenCase=null;
                    Edit.chosenCooler=null;
                    Edit.chosenCpu=null;
                    Edit.chosenDrive=null;
                    Edit.chosenGpu=null;
                    Edit.chosenMtb=null;
                    Edit.chosenPsu=null;
                    Edit.chosenRam=null;
                    minTdp=0.0;
                    maxTdp=0.0;
                    Edit.extraDrives=new List<Drive>();
                    Edit.extra=-1;
                    Edit.usedNvme=true;
                    Edit.pom1=8;
                    Edit.slots=0;
                    base=new FireBase();
                  });
                }
            ),
            SpeedDialChild(
                label: 'Szacowane zużycie mocy:\n'+minTdp.toStringAsFixed(1)+"W - "+maxTdp.toStringAsFixed(1)+"W"
            )
          ],
        ),
      )
    ]);
  }

}
