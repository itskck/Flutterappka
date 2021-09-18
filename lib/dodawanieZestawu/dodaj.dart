import 'dart:ui';
import 'package:flutter/painting.dart';
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

class dodaj extends StatefulWidget with ChangeNotifier {
  dodaj({Key key, this.title}) : super(key: key);

  static Cpu chosenCpu;
  static Psu chosenPsu;
  static Motherboard chosenMtb;
  static Drive chosenDrive;
  static Ram chosenRam;
  static Case chosenCase;
  static Gpu chosenGpu;
  static Cooler chosenCooler;
  static List<Widget> panelsGrid;

  final String title;

  @override
  _dodaj createState() => _dodaj();
}

class _dodaj extends State<dodaj> {
  final FireBase base=FireBase();
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

  Widget addButton(String component) {
    return GestureDetector(
        onTap: () async {
          await dialogwidget.showPopup(context, component, base);
          if (component == 'CPU')
            base.cpuSocket=dodaj.chosenCpu.socket;

          else if (component == 'CSTM COOLER')
            base.coolerSocket=dodaj.chosenCooler.socket;

          if (component == 'MTBRD'){
            print("hhhhhhhhhhhhhhhhh");
            print(base.ramRamType);
            print("gggggggggggggggggggggggg");
            base.mtbRamType=dodaj.chosenMtb.ramType;
            base.mtbNvmeSlot=dodaj.chosenMtb.hasNvmeSlot;
            base.mtbSocket=dodaj.chosenMtb.socket;
            base.mtbStandard=dodaj.chosenMtb.standard;
          }

          if (component == 'DRIVE')
            base.driveConnectionType=dodaj.chosenDrive.connectionType;

          if (component == 'CASE')
            base.caseStandard=dodaj.chosenCase.standard;

          if (component == 'RAM') {
            base.ramRamType = dodaj.chosenRam.type;
            print("uuuuuuuuuuuuuuuuu");
            print(base.ramRamType);
            print("wwwwwwwwwwwwww");
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

  Widget itemFrame(String model, String component, String photoURL) {
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
            child: Image(
              image: AssetImage(photoURL),
            ),
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
                    base.cpuSocket=null;
                    dodaj.chosenCpu = null;
                  });
                  break;
                case 'PSU':
                  setState(() {
                    dodaj.chosenPsu = null;
                  });
                  break;
                case 'GPU':
                  setState(() {
                    dodaj.chosenGpu = null;
                  });
                  break;
                case 'CSTM COOLER':
                  setState(() {
                    base.coolerSocket=null;
                    dodaj.chosenCooler = null;
                  });
                  break;
                case 'MTBRD':
                  setState(() {
                    base.mtbRamType=null;
                    base.mtbNvmeSlot=null;
                    base.mtbStandard=null;
                    base.caseStandard=null;
                    dodaj.chosenMtb = null;
                  });
                  break;
                case 'DRIVE':
                  setState(() {
                    base.driveConnectionType=null;
                    dodaj.chosenDrive = null;
                  });
                  break;
                case 'CASE':
                  setState(() {
                    base.caseStandard=null;
                    dodaj.chosenCase = null;
                  });
                  break;
                case 'RAM':
                  setState(() {
                    base.ramRamType=null;
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

    dodaj.panelsGrid = [
      addButton('CPU'),
      addButton('PSU'),
      addButton('MTBRD'),
      addButton('DRIVE'),
      addButton('RAM'),
      addButton('CASE'),
      addButton('GPU'),
      addButton('CSTM COOLER')
    ];

    if (dodaj.chosenCpu != null) {
      setState(() {
        dodaj.panelsGrid[0] =
            itemFrame(dodaj.chosenCpu.model, 'CPU', 'assets/placeholder.png');
      });
    } else
      dodaj.panelsGrid[0] = addButton('CPU');
////////////////////////////////////////////////////////////
    if (dodaj.chosenPsu != null) {
      setState(() {
        dodaj.panelsGrid[1] =
            itemFrame(dodaj.chosenPsu.model, 'PSU', 'assets/placeholder.png');
      });
    } else
      dodaj.panelsGrid[1] = addButton('PSU');
////////////////////////////////////////////////////
    if (dodaj.chosenMtb != null) {
      setState(() {
        dodaj.panelsGrid[2] =
            itemFrame(dodaj.chosenMtb.model, 'MTBRD', 'assets/placeholder.png');
      });
    } else
      dodaj.panelsGrid[2] = addButton('MTBRD');
    ///////////////////////////////////////////////////////
    if (dodaj.chosenDrive != null) {
      setState(() {
        dodaj.panelsGrid[3] = itemFrame(
            dodaj.chosenDrive.model, 'DRIVE', 'assets/placeholder.png');
      });
    } else
      dodaj.panelsGrid[3] = addButton('DRIVE');
    ////////////////////////////////////////////////////
    if (dodaj.chosenRam != null) {
      setState(() {
        dodaj.panelsGrid[4] =
            itemFrame(dodaj.chosenRam.model, 'RAM', 'assets/placeholder.png');
      });
    } else
      dodaj.panelsGrid[4] = addButton('RAM');
    ////////////////////////////////////////////////////
    if (dodaj.chosenCase != null) {
      setState(() {
        dodaj.panelsGrid[5] =
            itemFrame(dodaj.chosenCase.model, 'CASE', 'assets/placeholder.png');
      });
    } else
      dodaj.panelsGrid[5] = addButton('CASE');
    ///////////////////////////////////////////////////
    if (dodaj.chosenGpu != null) {
      setState(() {
        dodaj.panelsGrid[6] =
            itemFrame(dodaj.chosenGpu.model, 'GPU', 'assets/placeholder.png');
      });
    } else
      dodaj.panelsGrid[6] = addButton('GPU');
    //////////////////////////////////////////////////////
    if (dodaj.chosenCooler != null) {
      setState(() {
        dodaj.panelsGrid[7] = itemFrame(
            dodaj.chosenCooler.model, 'CSTM COOLER', 'assets/placeholder.png');
      });
    } else
      dodaj.panelsGrid[7] = addButton('CSTM COOLER');

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
          alignment: Alignment(0.95, 0.95),
          child: FloatingActionButton(
            onPressed: () {
              print('elo');
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Dodawanie zestawu'),
                      content:
                          Text('Czy chcesz zapisać zestaw na swoim koncie?'),
                      actions: [
                        TextButton(
                            onPressed: () {
                              addBuildToDatabse(chosenCase: dodaj.chosenCase,chosenCooler: dodaj.chosenCooler,chosenCpu: dodaj.chosenCpu,chosenDrive: dodaj.chosenDrive,chosenGpu: dodaj.chosenGpu,chosenMtb: dodaj.chosenMtb,chosenPsu: dodaj.chosenPsu,chosenRam: dodaj.chosenRam).addBuildData();
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
            },
            child: Icon(Icons.save),
            backgroundColor: Color.fromRGBO(240, 84, 84, 1),
          )),
    ]);
  }
}