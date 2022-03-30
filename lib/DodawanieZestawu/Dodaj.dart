import 'dart:math';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
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
import 'OknoDialogoweWidget.dart';
import 'package:skladappka/Firebase/DodajDoBazyDanych/DodajDoBazyDanych.dart';
import 'package:skladappka/Firebase/FireBase.dart';

import 'package:skladappka/main.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:skladappka/Cache.dart' as cache;

class dodaj extends StatefulWidget with ChangeNotifier {
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
  static bool usedNvme = true;
  static int pom1 = 8;
  static int slots = 0;
  static double iloscRam = 1.0;
  static double minTdp = 0.0;
  static double maxTdp = 0.0;
  static FireBase base = FireBase();
  @override
  _dodaj createState() => _dodaj();
}

class _dodaj extends State<dodaj> {
  String pom;

  @override
  initState() {
    print("raz dwa trzy");
    if (dodaj.chosenMtb == null) {
      dodaj.extraDrives = new List<Drive>();
      dodaj.extra = -1;
      dodaj.usedNvme = true;
      dodaj.pom1 = 8;
      dodaj.slots = 0;
    }
    super.initState();
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
            if (dodaj.chosenGpu != null) if (dodaj.chosenGpu.integra == true)
              dodaj.chosenGpu = null;
            if (component == "RAM" && dodaj.chosenMtb == null)
              Fluttertoast.showToast(
                  msg: "Wybierz najpierw płytę główną",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 2);
            else
              await dialogwidget.showPopup(context, component, dodaj.base);
            if (component == 'CPU' && dodaj.chosenCpu != null) {
              dodaj.minTdp += double.parse(dodaj.chosenCpu.tdp) * 0.9;
              dodaj.maxTdp += double.parse(dodaj.chosenCpu.tdp);
              dodaj.base.cpuSocket = dodaj.chosenCpu.socket;
            } else {
              if (component == 'CSTM COOLER' && dodaj.chosenCooler != null) {
                dodaj.minTdp += 1.0;
                dodaj.maxTdp += 2.0;
                dodaj.base.coolerSocket = dodaj.chosenCooler.socket;
              }
            }

            if (component == 'MTBRD' && dodaj.chosenMtb != null) {
              dodaj.minTdp += 50;
              dodaj.maxTdp += 150;
              dodaj.base.mtbRamType = dodaj.chosenMtb.ramType;
              dodaj.base.mtbNvmeSlot = dodaj.chosenMtb.hasNvmeSlot;
              dodaj.base.mtbSocket = dodaj.chosenMtb.socket;
              dodaj.base.mtbStandard = dodaj.chosenMtb.standard;
            }
            if (component == 'DRIVE' && dodaj.chosenDrive != null) {
              if (dodaj.chosenDrive.type == "HDD") {
                dodaj.minTdp += 1.5;
                dodaj.maxTdp += 2.5;
              } else {
                dodaj.minTdp += 0.5;
                dodaj.maxTdp += 1;
              }
              dodaj.base.driveConnectionType = dodaj.chosenDrive.connectionType;
            }

            if (component == 'CASE' && dodaj.chosenCase != null) {
              dodaj.base.caseStandard = dodaj.chosenCase.standard;
            }

            if (component == 'RAM' && dodaj.chosenRam != null) {
              dodaj.minTdp += dodaj.iloscRam * 30;
              dodaj.maxTdp += dodaj.iloscRam * 60;
              dodaj.base.ramRamType = dodaj.chosenRam.type;
            }
            if (component == 'GPU' && dodaj.chosenGpu != null) {
              dodaj.minTdp += double.parse(dodaj.chosenGpu.tdp);
              dodaj.maxTdp += double.parse(dodaj.chosenGpu.tdp);
            }
            if (component == 'EXTRA DRIVE') {
              for (int i = 0; i < dodaj.extraDrives.length; i++) {
                if (dodaj.extraDrives[i].connectionType == "NVMe")
                  dodaj.base.mtbNvmeSlot = false;
              }
            }
            setState(() {});
          } else
            Fluttertoast.showToast(
                msg: "Brak połączenia z internetem",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
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
                        dodaj.minTdp -= double.parse(dodaj.chosenCpu.tdp) * 0.9;
                        dodaj.maxTdp -= double.parse(dodaj.chosenCpu.tdp);
                        dodaj.base.cpuSocket = null;
                        if (dodaj.chosenGpu != null) if (dodaj
                                    .chosenCpu.hasGpu !=
                                "none" &&
                            dodaj.chosenGpu.integra == true)
                          dodaj.chosenGpu = null;
                        dodaj.chosenCpu = null;
                      });
                      break;
                    case 'PSU':
                      setState(() {
                        dodaj.chosenPsu = null;
                      });
                      break;
                    case 'GPU':
                      dodaj.minTdp -= double.parse(dodaj.chosenGpu.tdp);
                      dodaj.maxTdp -= double.parse(dodaj.chosenGpu.tdp);
                      setState(() {
                        dodaj.chosenGpu = null;
                      });
                      break;
                    case 'CSTM COOLER':
                      dodaj.minTdp -= 1.0;
                      dodaj.maxTdp -= 2.0;
                      setState(() {
                        dodaj.base.coolerSocket = null;
                        dodaj.chosenCooler = null;
                      });
                      break;
                    case 'MTBRD':
                      dodaj.minTdp -= 50;
                      dodaj.maxTdp -= 150;
                      if (dodaj.chosenRam != null) {
                        dodaj.minTdp -= 30 * dodaj.iloscRam;
                        dodaj.maxTdp -= 60 * dodaj.iloscRam;
                      }
                      setState(() {
                        dodaj.base.mtbRamType = null;
                        dodaj.base.mtbNvmeSlot = null;
                        dodaj.base.mtbStandard = null;
                        dodaj.base.caseStandard = null;
                        dodaj.chosenMtb = null;
                        dodaj.base.mtbSocket = null;
                        dodaj.extraDrives = new List<Drive>();
                        dodaj.extra = -1;
                        dodaj.usedNvme = true;
                        dodaj.pom1 = 8;
                        dodaj.slots = 0;
                        if (dodaj.chosenRam != null) {
                          dodaj.iloscRam = 1;
                          dodaj.base.ramRamType = null;
                          dodaj.chosenRam = null;
                        }
                      });
                      break;
                    case 'DRIVE':
                      if (dodaj.chosenDrive.type == "HDD") {
                        dodaj.minTdp -= 1.5;
                        dodaj.maxTdp -= 2.5;
                      } else {
                        dodaj.minTdp -= 0.5;
                        dodaj.maxTdp -= 1;
                      }
                      if (dodaj.chosenDrive.connectionType == "NVMe")
                        dodaj.usedNvme = false;
                      //dodaj.slots++;
                      setState(() {
                        dodaj.base.driveConnectionType = null;
                        dodaj.chosenDrive = null;
                      });
                      break;
                    case 'CASE':
                      setState(() {
                        dodaj.base.caseStandard = null;
                        dodaj.chosenCase = null;
                      });
                      break;
                    case 'RAM':
                      dodaj.minTdp -= 30 * dodaj.iloscRam;
                      dodaj.maxTdp -= 60 * dodaj.iloscRam;
                      setState(() {
                        dodaj.base.ramRamType = null;
                        dodaj.chosenRam = null;
                        dodaj.iloscRam = 1;
                      });
                      break;
                    case 'EXTRA DRIVE':
                      switch (background) {
                        case 'DODATKOWY DYSK 10':
                          print("Ja przepraszam zabladzilem");
                          if (dodaj.extraDrives[9].connectionType == "NVMe")
                            dodaj.base.mtbNvmeSlot = true;
                          if (dodaj.extraDrives[9].type == 'HDD') {
                            dodaj.minTdp -= 1.5;
                            dodaj.maxTdp -= 2.5;
                          } else {
                            dodaj.minTdp -= 0.5;
                            dodaj.maxTdp -= 1;
                          }
                          if (dodaj.extraDrives[9].connectionType == "NVMe")
                            dodaj.usedNvme = false;
                          setState(() {
                            dodaj.extraDrives.removeAt(9);
                          });
                          break;
                        case 'DODATKOWY DYSK 1':
                          if (dodaj.extraDrives[0].connectionType == "NVMe")
                            dodaj.base.mtbNvmeSlot = true;
                          if (dodaj.extraDrives[0].type == 'HDD') {
                            dodaj.minTdp -= 1.5;
                            dodaj.maxTdp -= 2.5;
                          } else {
                            dodaj.minTdp -= 0.5;
                            dodaj.maxTdp -= 1;
                          }
                          if (dodaj.extraDrives[0].connectionType == "NVMe")
                            dodaj.usedNvme = false;
                          setState(() {
                            dodaj.extraDrives.removeAt(0);
                          });
                          break;
                        case 'DODATKOWY DYSK 2':
                          if (dodaj.extraDrives[1].connectionType == "NVMe")
                            dodaj.base.mtbNvmeSlot = true;
                          if (dodaj.extraDrives[1].type == 'HDD') {
                            dodaj.minTdp -= 1.5;
                            dodaj.maxTdp -= 2.5;
                          } else {
                            dodaj.minTdp -= 0.5;
                            dodaj.maxTdp -= 1;
                          }
                          if (dodaj.extraDrives[1].connectionType == "NVMe")
                            dodaj.usedNvme = false;
                          setState(() {
                            dodaj.extraDrives.removeAt(1);
                          });
                          break;
                        case 'DODATKOWY DYSK 3':
                          if (dodaj.extraDrives[2].connectionType == "NVMe")
                            dodaj.base.mtbNvmeSlot = true;
                          if (dodaj.extraDrives[2].type == 'HDD') {
                            dodaj.minTdp -= 1.5;
                            dodaj.maxTdp -= 2.5;
                          } else {
                            dodaj.minTdp -= 0.5;
                            dodaj.maxTdp -= 1;
                          }
                          if (dodaj.extraDrives[2].connectionType == "NVMe")
                            dodaj.usedNvme = false;
                          setState(() {
                            dodaj.extraDrives.removeAt(2);
                          });
                          break;
                        case 'DODATKOWY DYSK 4':
                          if (dodaj.extraDrives[3].connectionType == "NVMe")
                            dodaj.base.mtbNvmeSlot = true;
                          if (dodaj.extraDrives[3].type == 'HDD') {
                            dodaj.minTdp -= 1.5;
                            dodaj.maxTdp -= 2.5;
                          } else {
                            dodaj.minTdp -= 0.5;
                            dodaj.maxTdp -= 1;
                          }
                          if (dodaj.extraDrives[3].connectionType == "NVMe")
                            dodaj.usedNvme = false;
                          setState(() {
                            dodaj.extraDrives.removeAt(3);
                          });
                          break;
                        case 'DODATKOWY DYSK 5':
                          if (dodaj.extraDrives[4].connectionType == "NVMe")
                            dodaj.base.mtbNvmeSlot = true;
                          if (dodaj.extraDrives[4].type == 'HDD') {
                            dodaj.minTdp -= 1.5;
                            dodaj.maxTdp -= 2.5;
                          } else {
                            dodaj.minTdp -= 0.5;
                            dodaj.maxTdp -= 1;
                          }
                          if (dodaj.extraDrives[4].connectionType == "NVMe")
                            dodaj.usedNvme = false;
                          setState(() {
                            dodaj.extraDrives.removeAt(4);
                          });
                          break;
                        case 'DODATKOWY DYSK 6':
                          if (dodaj.extraDrives[5].connectionType == "NVMe")
                            dodaj.base.mtbNvmeSlot = true;
                          if (dodaj.extraDrives[5].type == 'HDD') {
                            dodaj.minTdp -= 1.5;
                            dodaj.maxTdp -= 2.5;
                          } else {
                            dodaj.minTdp -= 0.5;
                            dodaj.maxTdp -= 1;
                          }
                          if (dodaj.extraDrives[5].connectionType == "NVMe")
                            dodaj.usedNvme = false;
                          setState(() {
                            dodaj.extraDrives.removeAt(5);
                          });
                          break;
                        case 'DODATKOWY DYSK 7':
                          if (dodaj.extraDrives[6].connectionType == "NVMe")
                            dodaj.base.mtbNvmeSlot = true;
                          if (dodaj.extraDrives[6].type == 'HDD') {
                            dodaj.minTdp -= 1.5;
                            dodaj.maxTdp -= 2.5;
                          } else {
                            dodaj.minTdp -= 0.5;
                            dodaj.maxTdp -= 1;
                          }
                          if (dodaj.extraDrives[6].connectionType == "NVMe")
                            dodaj.usedNvme = false;
                          setState(() {
                            dodaj.extraDrives.removeAt(6);
                          });
                          break;
                        case 'DODATKOWY DYSK 8':
                          if (dodaj.extraDrives[7].connectionType == "NVMe")
                            dodaj.base.mtbNvmeSlot = true;
                          if (dodaj.extraDrives[7].type == 'HDD') {
                            dodaj.minTdp -= 1.5;
                            dodaj.maxTdp -= 2.5;
                          } else {
                            dodaj.minTdp -= 0.5;
                            dodaj.maxTdp -= 1;
                          }
                          if (dodaj.extraDrives[7].connectionType == "NVMe")
                            dodaj.usedNvme = false;
                          setState(() {
                            dodaj.extraDrives.removeAt(7);
                          });
                          break;
                        case 'DODATKOWY DYSK 9':
                          if (dodaj.extraDrives[8].connectionType == "NVMe")
                            dodaj.base.mtbNvmeSlot = true;
                          if (dodaj.extraDrives[8].type == 'HDD') {
                            dodaj.minTdp -= 1.5;
                            dodaj.maxTdp -= 2.5;
                          } else {
                            dodaj.minTdp -= 0.5;
                            dodaj.maxTdp -= 1;
                          }
                          if (dodaj.extraDrives[8].connectionType == "NVMe")
                            dodaj.usedNvme = false;
                          setState(() {
                            dodaj.extraDrives.removeAt(8);
                          });
                          break;
                      }
                      dodaj.extra--;
                      dodaj.slots++;
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
    dodaj.panelsGrid = [
      addButton('CPU', "PROCESOR"),
      addButton('PSU', 'ZASILACZ'),
      addButton('MTBRD', 'PŁYTA GŁÓWNA'),
      addButton('DRIVE', 'DYSK SYSTEMOWY'),
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

    if (dodaj.chosenCpu != null) {
      setState(() {
        dodaj.panelsGrid[0] = itemFrame(
            dodaj.chosenCpu.model, 'CPU', dodaj.chosenCpu.img, 'PROCESOR');
        print('aaa');
      });
    } else
      dodaj.panelsGrid[0] = addButton('CPU', 'PROCESOR');
////////////////////////////////////////////////////////////
    if (dodaj.chosenPsu != null) {
      setState(() {
        dodaj.panelsGrid[1] = itemFrame(
            dodaj.chosenPsu.model, 'PSU', dodaj.chosenPsu.img, 'ZASILACZ');
      });
    } else
      dodaj.panelsGrid[1] = addButton('PSU', 'ZASILACZ');
////////////////////////////////////////////////////
    if (dodaj.chosenMtb != null) {
      setState(() {
        dodaj.panelsGrid[2] = itemFrame(dodaj.chosenMtb.model, 'MTBRD',
            dodaj.chosenMtb.img, 'PŁYTA GŁÓWNA');
      });
    } else
      dodaj.panelsGrid[2] = addButton('MTBRD', 'PŁYTA GŁÓWNA');
    ///////////////////////////////////////////////////////
    if (dodaj.chosenDrive != null) {
      setState(() {
        dodaj.panelsGrid[3] = itemFrame(dodaj.chosenDrive.model, 'DRIVE',
            dodaj.chosenDrive.img, 'DYSK SYSTEMOWY');
      });
    } else
      dodaj.panelsGrid[3] = addButton('DRIVE', 'DYSK');
    ////////////////////////////////////////////////////
    if (dodaj.chosenRam != null) {
      setState(() {
        dodaj.panelsGrid[4] =
            itemFrame(dodaj.chosenRam.model, 'RAM', dodaj.chosenRam.img, 'RAM');
      });
    } else
      dodaj.panelsGrid[4] = addButton('RAM', 'RAM');
    ////////////////////////////////////////////////////
    if (dodaj.chosenCase != null) {
      setState(() {
        dodaj.panelsGrid[5] = itemFrame(
            dodaj.chosenCase.model, 'CASE', dodaj.chosenCase.img, 'OBUDOWA');
      });
    } else
      dodaj.panelsGrid[5] = addButton('CASE', 'OBUDOWA');
    ///////////////////////////////////////////////////
    if (dodaj.chosenGpu != null) {
      setState(() {
        dodaj.panelsGrid[6] = itemFrame(dodaj.chosenGpu.model, 'GPU',
            dodaj.chosenGpu.img, 'KARTA GRAFICZNA');
      });
    } else
      dodaj.panelsGrid[6] = addButton('GPU', 'KARTA GRAFICZNA');
    //////////////////////////////////////////////////////
    if (dodaj.chosenCooler != null) {
      setState(() {
        dodaj.panelsGrid[7] = itemFrame(dodaj.chosenCooler.model, 'CSTM COOLER',
            dodaj.chosenCooler.img, 'CHŁODZENIE');
      });
    } else
      dodaj.panelsGrid[7] = addButton('CSTM COOLER', 'CHŁODZENIE');
    ///////////////////////////////////////////////////
    if (dodaj.extraDrives == null)
      print("CZEMU JEST NULL");
    else
      print(dodaj.extraDrives.length);
    if (dodaj.chosenMtb != null && dodaj.extraDrives.length > 0) {
      print('wykonuje sie');
      setState(() {
        for (int i = 0; i < dodaj.extra + 1; i++) {
          var pom = i + 1;
          dodaj.panelsGrid[i + 8] = itemFrame(dodaj.extraDrives[i].model,
              'EXTRA DRIVE', dodaj.extraDrives[i].img, 'DODATKOWY DYSK $pom');
        }
      });
    } else
      dodaj.panelsGrid[dodaj.pom1] = addButton('EXTRA DRIVE', 'DODATKOWY DYSK');

    //if (dodaj.panelsGrid != firstPanels)

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
              for (var i = 0; i < 6; i++) dodaj.panelsGrid[i],
              styledTextBar('↓ Dobrze mieć ↓'),
              for (var i = 6; i < 8; i++) dodaj.panelsGrid[i],
              for (dodaj.pom1 = 8; dodaj.pom1 < dodaj.extra + 9; dodaj.pom1++)
                dodaj.panelsGrid[dodaj.pom1],
              if (dodaj.chosenMtb != null)
                if (dodaj.slots > 0) dodaj.panelsGrid[dodaj.pom1],
            ]),
      ])),
      Align(
        alignment: Alignment(0.92, 0.95),
        child: SpeedDial(
          backgroundColor: Colors.lightBlue[300],
          overlayOpacity: 0,
          curve: Curves.linear,
          animatedIcon: AnimatedIcons.menu_arrow,
          direction: SpeedDialDirection.left,
          children: [
            SpeedDialChild(
              child: Icon(Icons.save),
              backgroundColor: Colors.lightBlue[300],
              foregroundColor: Colors.white,
              onTap: () async {
                if (Skladapka.connectivityResult == ConnectivityResult.none)
                  Fluttertoast.showToast(
                      msg: "Brak połączenia z internetem",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 2);
                else if (cache.czyZalogowany == "czyZalogowany=false")
                  Fluttertoast.showToast(
                      msg: "Musisz być zalogowany",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 2);
                else {
                  if (dodaj.chosenGpu == null && dodaj.chosenCpu != null)
                    dodaj.chosenGpu =
                        await dodaj.base.addGpu(dodaj.chosenCpu.hasGpu);
                  if ((dodaj.chosenCpu == null ||
                      dodaj.chosenRam == null ||
                      dodaj.chosenCase == null ||
                      dodaj.chosenDrive == null ||
                      dodaj.chosenMtb == null ||
                      dodaj.chosenPsu == null ||
                      dodaj.chosenGpu == null) || (dodaj.chosenCooler==null && dodaj.chosenCpu.isCoolerIncluded==false))
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                              title: Text('Błąd'),
                              content: Text(
                                  'Nie wybrano ktoregoś z niezbędnych komponentów lub wybrany procesor nie posiada karty graficznej lub chłodzenia'
                                  ),
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
                            content: Text(
                                'Czy chcesz zapisać zestaw na swoim koncie?'),
                            actions: [
                              TextButton(
                                  onPressed: () async {
                                    if (dodaj.chosenCooler == null)
                                      dodaj.chosenCooler =
                                          await dodaj.base.addCooler();
                                    addBuildToDatabse(
                                            chosenCase: dodaj.chosenCase,
                                            chosenCooler: dodaj.chosenCooler,
                                            chosenCpu: dodaj.chosenCpu,
                                            chosenDrive: dodaj.chosenDrive,
                                            chosenGpu: dodaj.chosenGpu,
                                            chosenMtb: dodaj.chosenMtb,
                                            chosenPsu: dodaj.chosenPsu,
                                            chosenRam: dodaj.chosenRam,
                                            extraDrive: dodaj.extraDrives,
                                            minTdp: dodaj.minTdp,
                                            maxTdp: dodaj.maxTdp,
                                            iloscRam: dodaj.iloscRam)
                                        .addBuildData();
                                    dodaj.chosenCooler = null;
                                    dodaj.chosenGpu = null;
                                    dodaj.chosenCase = null;
                                    dodaj.chosenRam = null;
                                    dodaj.chosenDrive = null;
                                    dodaj.chosenMtb = null;
                                    dodaj.chosenPsu = null;
                                    dodaj.chosenCpu = null;
                                    dodaj.base.caseStandard = null;
                                    dodaj.base.ramRamType = null;
                                    dodaj.base.driveConnectionType = null;
                                    dodaj.base.mtbStandard = null;
                                    dodaj.base.mtbNvmeSlot = null;
                                    dodaj.base.mtbRamType = null;
                                    dodaj.base.coolerSocket = null;
                                    dodaj.base.cpuSocket = null;
                                    dodaj.base.mtbSocket = null;
                                    dodaj.extraDrives = new List<Drive>();
                                    dodaj.extra = -1;
                                    dodaj.usedNvme = true;
                                    dodaj.pom1 = 8;
                                    dodaj.slots = 0;
                                    setState(() {});
                                    Navigator.of(context).pop();
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
                }
              },
            ),
            SpeedDialChild(
                child: Icon(Icons.delete),
                backgroundColor: Colors.lightBlue[300],
                foregroundColor: Colors.white,
                onTap: () {
                  setState(() {
                    dodaj.chosenCase = null;
                    dodaj.chosenCooler = null;
                    dodaj.chosenCpu = null;
                    dodaj.chosenDrive = null;
                    dodaj.chosenGpu = null;
                    dodaj.chosenMtb = null;
                    dodaj.chosenPsu = null;
                    dodaj.chosenRam = null;
                    dodaj.minTdp = 0.0;
                    dodaj.maxTdp = 0.0;
                    dodaj.extraDrives = new List<Drive>();
                    dodaj.extra = -1;
                    dodaj.usedNvme = true;
                    dodaj.pom1 = 8;
                    dodaj.slots = 0;
                    dodaj.base=new FireBase();
                  });
                }),
            SpeedDialChild(
                label: 'Szacowane zużycie mocy:\n' +
                    dodaj.minTdp.toStringAsFixed(1) +
                    "W - " +
                    dodaj.maxTdp.toStringAsFixed(1) +
                    "W")
          ],
        ),
      )
    ]);
  }
}
