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
import 'dialogWidget.dart';
import 'package:skladappka/Firebase/addToDatabase/addToDatabase.dart';
import 'package:skladappka/Firebase/FireBase.dart';
import 'Logo.dart';
import 'package:skladappka/Glowna/Glowna.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:skladappka/Globalne.dart' as globalna;

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

  @override
  _dodaj createState() => _dodaj();
}

class _dodaj extends State<dodaj> {
  var minTdp = 0.0, maxTdp = 0.0;
  final FireBase base = FireBase();
  final Logo logo = Logo();
  String pom;
  @override
  initState() {
    super.initState();
  }

  dialogWidget dialogwidget = new dialogWidget();

  Widget componentsList(String component) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.8,
    );
  }

  Widget addButton(String component,String background) {
    
    return GestureDetector(
        onTap: () async {
          if(Glowna.connectivityResult!=ConnectivityResult.none) {
            if (dodaj.chosenGpu != null) if (dodaj.chosenGpu.integra == true)
              dodaj.chosenGpu = null;

            await dialogwidget.showPopup(context, component, base);
            if (component == 'CPU' && dodaj.chosenCpu != null) {
              minTdp += double.parse(dodaj.chosenCpu.tdp) * 0.9;
              maxTdp += double.parse(dodaj.chosenCpu.tdp);
              base.cpuSocket = dodaj.chosenCpu.socket;
            } else {
              if (component == 'CSTM COOLER' && dodaj.chosenCooler != null) {
                minTdp += 1.0;
                maxTdp += 2.0;
                base.coolerSocket = dodaj.chosenCooler.socket;
              }
            }

            if (component == 'MTBRD' && dodaj.chosenMtb != null) {
              minTdp += 50;
              maxTdp += 150;
              base.mtbRamType = dodaj.chosenMtb.ramType;
              base.mtbNvmeSlot = dodaj.chosenMtb.hasNvmeSlot;
              base.mtbSocket = dodaj.chosenMtb.socket;
              base.mtbStandard = dodaj.chosenMtb.standard;
            }
            if (component == 'DRIVE' && dodaj.chosenDrive != null) {
              if (dodaj.chosenDrive.type == "HDD") {
                minTdp += 1.5;
                maxTdp += 2.5;
              } else {
                minTdp += 0.5;
                maxTdp += 1;
              }
              base.driveConnectionType = dodaj.chosenDrive.connectionType;
            }

            if (component == 'CASE' && dodaj.chosenCase != null) {
              base.caseStandard = dodaj.chosenCase.standard;
            }

            if (component == 'RAM' && dodaj.chosenRam != null) {
              minTdp += 30;
              maxTdp += 60;
              base.ramRamType = dodaj.chosenRam.type;
            }
            if (component == 'GPU' && dodaj.chosenGpu != null) {
              minTdp += double.parse(dodaj.chosenGpu.tdp);
              maxTdp += double.parse(dodaj.chosenGpu.tdp);
            }
            setState(() {});
          }
          else Fluttertoast.showToast(msg: "Brak połączenia z internetem",
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
                child: Text(background,
                style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                fontFamily: GoogleFonts.workSans().fontFamily,   
                                color: Colors.white
                                ),),
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
                          Color.fromRGBO(45, 45, 45,1),
                          Color.fromRGBO(59, 55, 68,1)
                        ]
                      )
                    ),
                    child: GradientText(
                      '+',
                      
                      colors :[
                        Colors.white,
                       Colors.white

                      ],
                      
                      style: TextStyle(
                        fontSize: 120
                      ),
                      
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
              colors: [
                Colors.lightBlue[300],
                Color.fromRGBO(178, 150, 255,1)
              ],
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: GoogleFonts.workSans().fontFamily, 
                  fontWeight: FontWeight.normal,
                  fontSize: 22,
                  letterSpacing: 2,
                 ))),
    );
  }

  Widget itemFrame(String model, String component, Image photoURL) {
    return Container(
        margin: EdgeInsets.all(15),
        width: MediaQuery.of(context).size.width * 0.4,
        height: MediaQuery.of(context).size.width * 0.4,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.lightBlue[300],
                Color.fromRGBO(178, 150, 255,1)])),
        child: Stack(fit: StackFit.passthrough, children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(15, 0, 15, 15),
            padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
            child: photoURL
          ),
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
                    color: Colors.white
                    ),
              )),
          GestureDetector(
            onTap: () {
              switch (component) {
                case 'CPU':
                  setState(() {
                    minTdp -= double.parse(dodaj.chosenCpu.tdp) * 0.9;
                    maxTdp -= double.parse(dodaj.chosenCpu.tdp);
                    base.cpuSocket = null;
                    if (dodaj.chosenGpu != null) if (dodaj.chosenCpu.hasGpu !=
                            "none" &&
                        dodaj.chosenGpu.integra == true) dodaj.chosenGpu = null;
                    dodaj.chosenCpu = null;
                  });
                  break;
                case 'PSU':
                  setState(() {
                    dodaj.chosenPsu = null;
                  });
                  break;
                case 'GPU':
                  minTdp -= double.parse(dodaj.chosenGpu.tdp);
                  maxTdp -= double.parse(dodaj.chosenGpu.tdp);
                  setState(() {
                    dodaj.chosenGpu = null;
                  });
                  break;
                case 'CSTM COOLER':
                  minTdp -= 1.0;
                  maxTdp -= 2.0;
                  setState(() {
                    base.coolerSocket = null;
                    dodaj.chosenCooler = null;
                  });
                  break;
                case 'MTBRD':
                  minTdp -= 50;
                  maxTdp -= 150;
                  setState(() {
                    base.mtbRamType = null;
                    base.mtbNvmeSlot = null;
                    base.mtbStandard = null;
                    base.caseStandard = null;
                    dodaj.chosenMtb = null;
                    base.mtbSocket=null;
                  });
                  break;
                case 'DRIVE':
                  if (dodaj.chosenDrive.type == "HDD") {
                    minTdp -= 1.5;
                    maxTdp -= 2.5;
                  } else {
                    minTdp -= 0.5;
                    maxTdp -= 1;
                  }
                  setState(() {
                    base.driveConnectionType = null;
                    dodaj.chosenDrive = null;
                  });
                  break;
                case 'CASE':
                  setState(() {
                    base.caseStandard = null;
                    dodaj.chosenCase = null;
                  });
                  break;
                case 'RAM':
                  minTdp -= 30;
                  maxTdp -= 60;
                  setState(() {
                    base.ramRamType = null;
                    dodaj.chosenRam = null;
                  });
                  break;
              }
            },
            child: Align(
              alignment: Alignment(1.55, -1.55),
              child: Container(
                
                margin: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Color.fromRGBO(45, 45, 45,1)),
                child: Icon(
                  Icons.cancel,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ]));
  }

  List<Widget> firstPanels;

  @override
  Widget build(BuildContext context) {
   

    dodaj.panelsGrid = [
      addButton('CPU',"PROCESOR"),
      addButton('PSU','ZASILACZ'),
      addButton('MTBRD','PŁYTA GŁÓWNA'),
      addButton('DRIVE','DYSK'),
      addButton('RAM','RAM'),
      addButton('CASE','OBUDOWA'),
      addButton('GPU','KARTA GRAFICZNA'),
      addButton('CSTM COOLER','CHŁODZENIE')
    ];

    if (dodaj.chosenCpu != null) {
      
      setState(() {
        dodaj.panelsGrid[0] = itemFrame(dodaj.chosenCpu.model, 'CPU', dodaj.chosenCpu.img);
        print('aaa');
      });
    } else
      dodaj.panelsGrid[0] = addButton('CPU','PROCESOR');
////////////////////////////////////////////////////////////
    if (dodaj.chosenPsu != null) {
      setState(() {
        dodaj.panelsGrid[1] = itemFrame(dodaj.chosenPsu.model, 'PSU', dodaj.chosenPsu.img);
      });
    } else
      dodaj.panelsGrid[1] = addButton('PSU','ZASILACZ');
////////////////////////////////////////////////////
    if (dodaj.chosenMtb != null) {
      setState(() {
        dodaj.panelsGrid[2] =
            itemFrame(dodaj.chosenMtb.model, 'MTBRD', dodaj.chosenMtb.img);
      });
    } else
      dodaj.panelsGrid[2] = addButton('MTBRD','PŁYTA GŁÓWNA');
    ///////////////////////////////////////////////////////
    if (dodaj.chosenDrive != null) {
      setState(() {
        dodaj.panelsGrid[3] =
            itemFrame(dodaj.chosenDrive.model, 'DRIVE', dodaj.chosenDrive.img);
      });
    } else
      dodaj.panelsGrid[3] = addButton('DRIVE','DYSK');
    ////////////////////////////////////////////////////
    if (dodaj.chosenRam != null) {
      setState(() {
        dodaj.panelsGrid[4] = itemFrame(dodaj.chosenRam.model, 'RAM', dodaj.chosenRam.img);
      });
    } else
      dodaj.panelsGrid[4] = addButton('RAM','RAM');
    ////////////////////////////////////////////////////
    if (dodaj.chosenCase != null) {
      setState(() {
        dodaj.panelsGrid[5] =
            itemFrame(dodaj.chosenCase.model, 'CASE', dodaj.chosenCase.img);
      });
    } else
      dodaj.panelsGrid[5] = addButton('CASE','OBUDOWA');
    ///////////////////////////////////////////////////
    if (dodaj.chosenGpu != null) {
      setState(() {
        dodaj.panelsGrid[6] = itemFrame(dodaj.chosenGpu.model, 'GPU', dodaj.chosenGpu.img);
      });
    } else
      dodaj.panelsGrid[6] = addButton('GPU','KARTA GRAFICZNA');
    //////////////////////////////////////////////////////
    if (dodaj.chosenCooler != null) {
      setState(() {
        dodaj.panelsGrid[7] =
            itemFrame(dodaj.chosenCooler.model, 'CSTM COOLER', dodaj.chosenCooler.img);
      });
    } else
      dodaj.panelsGrid[7] = addButton('CSTM COOLER','CHŁODZENIE');

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
            ]),
      ])),
      
      Align(
        alignment: Alignment(0.92,0.98),
        child: SpeedDial(
          backgroundColor: Colors.lightBlue[300].withOpacity(0.8),
          overlayOpacity: 0,
          curve: Curves.linear,
          animatedIcon: AnimatedIcons.menu_arrow,          
          direction: SpeedDialDirection.left,
          children: [
            SpeedDialChild(
              child: Icon(Icons.save),
              backgroundColor:Colors.lightBlue[300].withOpacity(0.8) ,
              foregroundColor: Colors.white,
              onTap: () async {
                if(Glowna.connectivityResult==ConnectivityResult.none)
                  Fluttertoast.showToast(msg: "Brak połączenia z internetem",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 2);
                else if(globalna.czyZalogowany=="czyZalogowany=false")
                  Fluttertoast.showToast(msg: "Musisz być zalogowany",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 2);
                else {
                  if (dodaj.chosenGpu == null && dodaj.chosenCpu != null)
                    dodaj.chosenGpu = await base.addGpu(dodaj.chosenCpu.hasGpu);
                  if (dodaj.chosenCpu == null ||
                      dodaj.chosenRam == null ||
                      dodaj.chosenCase == null ||
                      dodaj.chosenDrive == null ||
                      dodaj.chosenMtb == null ||
                      dodaj.chosenPsu == null ||
                      dodaj.chosenGpu == null)
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
                            content: Text(
                                'Czy chcesz zapisać zestaw na swoim koncie?'),
                            actions: [
                              TextButton(
                                  onPressed: () async {
                                    if (dodaj.chosenCooler == null)
                                      dodaj.chosenCooler =
                                          await base.addCooler();
                                    addBuildToDatabse(
                                            chosenCase: dodaj.chosenCase,
                                            chosenCooler: dodaj.chosenCooler,
                                            chosenCpu: dodaj.chosenCpu,
                                            chosenDrive: dodaj.chosenDrive,
                                            chosenGpu: dodaj.chosenGpu,
                                            chosenMtb: dodaj.chosenMtb,
                                            chosenPsu: dodaj.chosenPsu,
                                            chosenRam: dodaj.chosenRam)
                                        .addBuildData();
                                    dodaj.chosenCooler = null;
                                    dodaj.chosenGpu = null;
                                    dodaj.chosenCase = null;
                                    dodaj.chosenRam = null;
                                    dodaj.chosenDrive = null;
                                    dodaj.chosenMtb = null;
                                    dodaj.chosenPsu = null;
                                    dodaj.chosenCpu = null;
                                    base.caseStandard = null;
                                    base.ramRamType = null;
                                    base.driveConnectionType = null;
                                    base.mtbStandard = null;
                                    base.mtbNvmeSlot = null;
                                    base.mtbRamType = null;
                                    base.coolerSocket = null;
                                    base.cpuSocket = null;
                                    base.mtbSocket = null;
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
              backgroundColor:Colors.lightBlue[300].withOpacity(0.8) ,
              foregroundColor: Colors.white,
              onTap: (){
                setState(() {
                dodaj.chosenCase=null;
                dodaj.chosenCooler=null;
                dodaj.chosenCpu=null;
                dodaj.chosenDrive=null;
                dodaj.chosenGpu=null;
                dodaj.chosenMtb=null;
                dodaj.chosenPsu=null;
                dodaj.chosenRam=null;
                minTdp=0.0;
                maxTdp=0.0;
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
