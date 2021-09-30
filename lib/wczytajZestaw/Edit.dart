import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
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
import 'package:skladappka/dodawanieZestawu/dialogWidget.dart';
import 'package:skladappka/Firebase/addToDatabase/addToDatabase.dart';
import 'package:skladappka/Firebase/FireBase.dart';
import 'package:skladappka/dodawanieZestawu/Logo.dart';
import 'package:skladappka/Logowanie/Zalogowany.dart';
import 'package:skladappka/Globalne.dart' as globalna;
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
      this.diffUser});

  @override
  _Edit createState() => _Edit();
}

class _Edit extends State<Edit> {
  var minTdp = 0.0, maxTdp = 0.0;
  final FireBase base = FireBase();
  final Logo logo = Logo();
  String pom;
  @override
  initState() {
    super.initState();
    setComponents();
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
    print("JEstem tu");
    base.mtbRamType=Edit.chosenMtb.ramType;
    base.mtbNvmeSlot=Edit.chosenMtb.hasNvmeSlot;
    base.mtbSocket=Edit.chosenMtb.socket;
    base.mtbStandard=Edit.chosenMtb.standard;

    base.driveConnectionType=Edit.chosenDrive.connectionType;
    base.caseStandard=Edit.chosenCase.standard;
    base.ramRamType = Edit.chosenRam.type;
    setState(() { });
  }

  dialogWidget dialogwidget = new dialogWidget();

  Widget componentsList(String component) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.8,
    );
  }

  Widget addButton(String component) {

    return GestureDetector(
        onTap: () async {
          if (Edit.chosenGpu != null) if (Edit.chosenGpu.integra == true)
            Edit.chosenGpu = null;
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
            minTdp += 50;
            maxTdp += 150;
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
            minTdp += 30;
            maxTdp += 60;
            base.ramRamType = Edit.chosenRam.type;
          }
          if (component == 'GPU' && Edit.chosenGpu != null) {
            minTdp += double.parse(Edit.chosenGpu.tdp);
            maxTdp += double.parse(Edit.chosenGpu.tdp);
          }
          setState(() {});
        },
        child: Container(
            margin: EdgeInsets.all(15),
            width: MediaQuery.of(context).size.width * 0.4,
            height: MediaQuery.of(context).size.width * 0.4,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromRGBO(240, 84, 84, 1),
                      Theme.of(context).shadowColor
                    ])),
            child: Stack(fit: StackFit.passthrough, children: <Widget>[
              Blur(
                blur: 0.8,
                blurColor: Colors.transparent,
                colorOpacity: 0,
                child: Text(
                  '$component ' * 150,
                  overflow: TextOverflow.fade,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w800,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 1
                        ..color = Color.fromRGBO(255, 255, 255, 50)),
                ),
              ),
              Icon(
                Icons.add,
                size: 100,
                color: Colors.white,
              ),
            ])));
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
          child: Text(content,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'coolvetica',
                  fontWeight: FontWeight.normal,
                  fontSize: 25,
                  letterSpacing: 2,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 0.8
                    ..color = Colors.red))),
    );
  }

  Widget itemFrame(String model, String component, Image photoURL) {
    return Container(
        margin: EdgeInsets.all(15),
        width: MediaQuery.of(context).size.width * 0.4,
        height: MediaQuery.of(context).size.width * 0.4,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.grey, Colors.redAccent])),
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
                    fontFamily: 'coolvetica',
                    fontWeight: FontWeight.normal,
                    fontSize: 15,
                    letterSpacing: 2,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 1
                      ..color = Colors.white),
              )),
          GestureDetector(
            onTap: () {
              switch (component) {
                case 'CPU':
                  setState(() {
                    minTdp -= double.parse(Edit.chosenCpu.tdp) * 0.9;
                    maxTdp -= double.parse(Edit.chosenCpu.tdp);
                    base.cpuSocket = null;
                    if (Edit.chosenGpu != null) if (Edit.chosenCpu.hasGpu !=
                        "none" &&
                        Edit.chosenGpu.integra == true) Edit.chosenGpu = null;
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
                  minTdp -= 50;
                  maxTdp -= 150;
                  setState(() {
                    base.mtbRamType = null;
                    base.mtbNvmeSlot = null;
                    base.mtbStandard = null;
                    base.caseStandard = null;
                    Edit.chosenMtb = null;
                    base.mtbSocket=null;
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
                  minTdp -= 30;
                  maxTdp -= 60;
                  setState(() {
                    base.ramRamType = null;
                    Edit.chosenRam = null;
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
                    color: Colors.white),
                child: Icon(
                  Icons.cancel,
                  color: Color.fromRGBO(240, 84, 84, 1),
                ),
              ),
            ),
          ),
        ]));
  }

  List<Widget> firstPanels;

  @override
  Widget build(BuildContext context) {
    firstPanels = [
      addButton('CPU'),
      addButton('PSU'),
      addButton('MTBRD'),
      addButton('DRIVE'),
      addButton('RAM'),
      addButton('CASE'),
      addButton('GPU'),
      addButton('CSTM COOLER')
    ];

    Edit.panelsGrid = [
      addButton('CPU'),
      addButton('PSU'),
      addButton('MTBRD'),
      addButton('DRIVE'),
      addButton('RAM'),
      addButton('CASE'),
      addButton('GPU'),
      addButton('CSTM COOLER')
    ];

    if (Edit.chosenCpu != null) {
      setState(() {
        Edit.panelsGrid[0] = itemFrame(Edit.chosenCpu.model, 'CPU', Edit.chosenCpu.img);
      });
    } else
      Edit.panelsGrid[0] = addButton('CPU');
////////////////////////////////////////////////////////////
    if (Edit.chosenPsu != null) {
      setState(() {
        Edit.panelsGrid[1] = itemFrame(Edit.chosenPsu.model, 'PSU', Edit.chosenPsu.img);
      });
    } else
      Edit.panelsGrid[1] = addButton('PSU');
////////////////////////////////////////////////////
    if (Edit.chosenMtb != null) {
      setState(() {
        Edit.panelsGrid[2] =
            itemFrame(Edit.chosenMtb.model, 'MTBRD', Edit.chosenMtb.img);
      });
    } else
      Edit.panelsGrid[2] = addButton('MTBRD');
    ///////////////////////////////////////////////////////
    if (Edit.chosenDrive != null) {
      setState(() {
        Edit.panelsGrid[3] =
            itemFrame(Edit.chosenDrive.model, 'DRIVE', Edit.chosenDrive.img);
      });
    } else
      Edit.panelsGrid[3] = addButton('DRIVE');
    ////////////////////////////////////////////////////
    if (Edit.chosenRam != null) {
      setState(() {
        Edit.panelsGrid[4] = itemFrame(Edit.chosenRam.model, 'RAM', Edit.chosenRam.img);
      });
    } else
      Edit.panelsGrid[4] = addButton('RAM');
    ////////////////////////////////////////////////////
    if (Edit.chosenCase != null) {
      setState(() {
        Edit.panelsGrid[5] =
            itemFrame(Edit.chosenCase.model, 'CASE', Edit.chosenCase.img);
      });
    } else
      Edit.panelsGrid[5] = addButton('CASE');
    ///////////////////////////////////////////////////
    if (Edit.chosenGpu != null) {
      setState(() {
        Edit.panelsGrid[6] = itemFrame(Edit.chosenGpu.model, 'GPU', Edit.chosenGpu.img);
      });
    } else
      Edit.panelsGrid[6] = addButton('GPU');
    //////////////////////////////////////////////////////
    if (Edit.chosenCooler != null) {
      setState(() {
        Edit.panelsGrid[7] =
            itemFrame(Edit.chosenCooler.model, 'CSTM COOLER', Edit.chosenCooler.img);
      });
    } else
      Edit.panelsGrid[7] = addButton('CSTM COOLER');

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
                ]),
          ])),

      Align(
        alignment: Alignment(0.92,0.98),
        child: SpeedDial(
          backgroundColor: Color.fromRGBO(240, 84, 84, 1),
          overlayOpacity: 0,
          curve: Curves.linear,
          animatedIcon: AnimatedIcons.menu_arrow,
          direction: SpeedDialDirection.left,
          children: [
            SpeedDialChild(
              child: widget.diffUser==false ? Icon(Icons.edit) : Icon(Icons.save),
              backgroundColor:Color.fromRGBO(240, 84, 84, 1) ,
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
                    Edit.chosenGpu == null)
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
                                  globalna.ktoro=4;
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
                backgroundColor:Color.fromRGBO(240, 84, 84, 1) ,
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
