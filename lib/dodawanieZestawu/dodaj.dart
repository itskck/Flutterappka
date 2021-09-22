import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
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
import 'Logo.dart';

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
  final Logo logo=Logo();
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

  Widget addButton(String component) {
    return GestureDetector(
        onTap: () async {
          if(dodaj.chosenGpu!=null)
            if(dodaj.chosenGpu.integra==true)
              dodaj.chosenGpu=null;
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
                    if(dodaj.chosenGpu!=null)
                    if(dodaj.chosenCpu.hasGpu!="none" && dodaj.chosenGpu.integra==true)
                      dodaj.chosenGpu=null;
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
      switch(dodaj.chosenCpu.manufacturer){
        case 'Intel': logo.cpu='assets/companies logo/cpu/intel.png'; break;
        case 'AMD': logo.cpu='assets/companies logo/cpu/ryzen.png'; break;
        default: logo.cpu='assets/placeholder.png';
      }
      setState(() {
        dodaj.panelsGrid[0] =
            itemFrame(dodaj.chosenCpu.model, 'CPU', logo.cpu);
      });
    } else
      dodaj.panelsGrid[0] = addButton('CPU');
////////////////////////////////////////////////////////////
    if (dodaj.chosenPsu != null) {
      switch(dodaj.chosenPsu.manufacturer){
        case 'SilentiumPC': logo.psu='assets/companies logo/case/Silentiumpc.png'; break;
        case 'SeaSonic': logo.psu='assets/companies logo/psu/SeaSonic.png'; break;
        default: logo.psu='assets/placeholder.png';
      }
      setState(() {
        dodaj.panelsGrid[1] =
            itemFrame(dodaj.chosenPsu.model, 'PSU', logo.psu);
      });
    } else
      dodaj.panelsGrid[1] = addButton('PSU');
////////////////////////////////////////////////////
    if (dodaj.chosenMtb != null) {
      switch(dodaj.chosenMtb.manufacturer){
        case 'Gigabyte': logo.mtb='assets/companies logo/motherboard/gigabyte.png'; break;
        case 'Asus': logo.mtb='assets/companies logo/motherboard/Asus.png'; break;
        case 'Biostar': logo.mtb='assets/companies logo/motherboard/biostar.png'; break;
        case 'MSI': logo.mtb='assets/companies logo/motherboard/msi.png'; break;
        case 'ASRock': logo.mtb='assets/companies logo/motherboard/Asrock.png'; break;
        default: logo.mtb='assets/placeholder.png';
      }
      setState(() {
        dodaj.panelsGrid[2] =
            itemFrame(dodaj.chosenMtb.model, 'MTBRD', logo.mtb);
      });
    } else
      dodaj.panelsGrid[2] = addButton('MTBRD');
    ///////////////////////////////////////////////////////
    if (dodaj.chosenDrive != null) {
      switch(dodaj.chosenDrive.manufacturer){
        case 'Kingston': logo.drive='assets/companies logo/drive/Kingston.png'; break;
        case 'Toshiba': logo.drive='assets/companies logo/drive/toshiba.png'; break;
        case 'ADATA': logo.drive='assets/companies logo/drive/adata.png'; break;
        case 'Seagate': logo.drive='assets/companies logo/drive/seagate.png'; break;
        case 'Transcend': logo.drive='assets/companies logo/drive/trranscend.png'; break;
        case 'WD': logo.drive='assets/companies logo/drive/wd.png'; break;
        default: logo.drive='assets/placeholder.png';
      }
      setState(() {
        dodaj.panelsGrid[3] = itemFrame(
            dodaj.chosenDrive.model, 'DRIVE', logo.drive);
      });
    } else
      dodaj.panelsGrid[3] = addButton('DRIVE');
    ////////////////////////////////////////////////////
    if (dodaj.chosenRam != null) {
      switch(dodaj.chosenRam.manufacturer){
        case 'Kingston': logo.ram='assets/companies logo/drive/Kingston.png'; break;
        case 'GoodRam': logo.ram='assets/companies logo/ram/Goodram.png'; break;
        case 'G.Skill': logo.ram='assets/companies logo/ram/Gskill.png'; break;
        default: logo.ram='assets/placeholder.png';
      }
      setState(() {
        dodaj.panelsGrid[4] =
            itemFrame(dodaj.chosenRam.model, 'RAM', logo.ram);
      });
    } else
      dodaj.panelsGrid[4] = addButton('RAM');
    ////////////////////////////////////////////////////
    if (dodaj.chosenCase != null) {
      switch(dodaj.chosenCase.manufacturer){
        case 'MSI': logo.cases='assets/companies logo/motherboard/msi.png'; break;
        case 'Aerocool': logo.cases='assets/companies logo/case/aerocool.png'; break;
        case 'Cooler Master': logo.cases='assets/companies logo/case/Coolermaster.png'; break;
        case 'Corsair': logo.cases='assets/companies logo/case/corsair.png'; break;
        case 'Fractal Design': logo.cases='assets/companies logo/case/fractal.png'; break;
        case 'SilentiumPC': logo.cases='assets/companies logo/case/Silentiumpc.png'; break;
        case 'SilverStone': logo.cases='assets/companies logo/case/Silverstone.png'; break;
        case 'Thermaltake': logo.cases='assets/companies logo/case/thermaltake.png'; break;
        default: logo.cases='assets/placeholder.png';
      }
      setState(() {
        dodaj.panelsGrid[5] =
            itemFrame(dodaj.chosenCase.model, 'CASE', logo.cases);
      });
    } else
      dodaj.panelsGrid[5] = addButton('CASE');
    ///////////////////////////////////////////////////
    if (dodaj.chosenGpu != null) {
      switch(dodaj.chosenGpu.manufacturer){
        case 'NVIDIA': logo.gpu='assets/companies logo/gpu/nvidia.png'; break;
        case "Radeon": logo.gpu='assets/companies logo/gpu/radeon.png'; break;
        default: logo.gpu='assets/placeholder.png';
      }
      setState(() {
        dodaj.panelsGrid[6] =
            itemFrame(dodaj.chosenGpu.model, 'GPU', logo.gpu);
      });
    } else
      dodaj.panelsGrid[6] = addButton('GPU');
    //////////////////////////////////////////////////////
    if (dodaj.chosenCooler != null) {
      switch(dodaj.chosenCooler.manufacturer){
        case 'Corsair': logo.cooler='assets/companies logo/case/corsair.png'; break;
        case 'SilentiumPC': logo.cooler='assets/companies logo/case/Silentiumpc.png'; break;
        case 'Arctic': logo.cooler='assets/companies logo/cooler/arctic.png'; break;
        case 'Noctua': logo.cooler='assets/companies logo/cooler/noctua.png'; break;
        case 'Cooler Master': logo.cooler='assets/companies logo/case/Coolermaster.png'; break;
        case 'SilverStone': logo.cooler='assets/companies logo/case/Silverstone.png'; break;
        case 'Deepcool': logo.cooler='assets/companies logo/cooler/deepcool.png'; break;
        case 'Thermaltake': logo.cooler='assets/companies logo/case/thermaltake.png'; break;
        default: logo.cooler='assets/placeholder.png';
      }
      setState(() {
        dodaj.panelsGrid[7] = itemFrame(
            dodaj.chosenCooler.model, 'CSTM COOLER', logo.cooler);
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
            onPressed: () async{
              if(dodaj.chosenGpu==null && dodaj.chosenCpu!=null)
                 dodaj.chosenGpu= await base.addGpu(dodaj.chosenCpu.hasGpu);
              if(dodaj.chosenCpu==null || dodaj.chosenRam==null || dodaj.chosenCase==null || dodaj.chosenDrive==null || dodaj.chosenMtb==null || dodaj.chosenPsu==null || dodaj.chosenGpu==null )
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Blad'),
                        content:
                        Text('Nie wybrano ktoregos z niezbednych komponentow lub wybrany procesor '
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
                          Text('Czy chcesz zapisać zestaw na swoim koncie?'),
                      actions: [
                        TextButton(
                            onPressed: () async{
                              if(dodaj.chosenCooler==null)
                                dodaj.chosenCooler=await base.addCooler();
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