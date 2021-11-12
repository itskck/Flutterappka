import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skladappka/Firebase/Case.dart';
import 'package:skladappka/Firebase/Cooler.dart';
import 'package:skladappka/Firebase/Cpu.dart';
import 'package:provider/provider.dart';
import 'package:skladappka/Firebase/Drive.dart';
import 'package:skladappka/Firebase/Gpu.dart';
import 'package:skladappka/Firebase/Motherboard.dart';
import 'package:skladappka/Firebase/Psu.dart';
import 'package:skladappka/Firebase/Ram.dart';
import 'dart:core';
import 'dodaj.dart';
import 'package:skladappka/Globalne.dart' as globals;
import 'package:skladappka/wczytajZestaw/Edit.dart';
class dialogBuilder extends StatefulWidget {
  final String component;

  dialogBuilder({this.component});

  @override
  _dialogBuilder createState() => _dialogBuilder();
}

class _dialogBuilder extends State<dialogBuilder> {
  double iloscRam=1.0;
  double ram=1;
  String component;
  var cpus, psus, gpus, coolers, mtbs, drives, cases, rams;
  TextStyle style = TextStyle(
    overflow: TextOverflow.visible

  );
  @override
  initState() {
    component=widget.component;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    if (widget.component == 'CPU') {
      cpus = Provider.of<List<Cpu>>(context) ?? [];
      print("44444444444");
      print(cpus.length);
      
      print("44444444444");
      return SimpleDialog(title: Text('Wybierz procesor:'), children: [
        for (int i = 0; i < cpus.length; i++)
          SimpleDialogOption(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        padding: EdgeInsets.all(5),
                        margin: EdgeInsets.only(right: 20),
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(width: 1)),
                        child: cpus[i].img),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(cpus[i].manufacturer + " " + cpus[i].model ,
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,fontFamily: GoogleFonts.workSans().fontFamily)),
                        Text(cpus[i].cores + "x " + cpus[i].clocker + "GHz, Socket: "+cpus[i].socket,style: TextStyle(fontFamily: GoogleFonts.workSans().fontFamily),),
                        Text(cpus[i].hasGpu=='none'?"Zintegorwana karta graficzna ❌":"Zintegrowana karta graficzna ✅",style: TextStyle(fontFamily: GoogleFonts.workSans().fontFamily),),
                        Text(cpus[i].isUnlocked?"Odblokowany mnożnik ✅":"Zablokowany mnożnik ❌",style: TextStyle(fontFamily: GoogleFonts.workSans().fontFamily),),
                        Text('Rocznik: '+cpus[i].year,style: TextStyle(fontFamily: GoogleFonts.workSans().fontFamily),),

                      ],
                    ),
                  ],
                ),
              ],
            ),
            onPressed: () {
              if (globals.ktoro == 2)
                dodaj.chosenCpu = cpus[i];
              else if (globals.ktoro == 1) Edit.chosenCpu = cpus[i];
              Navigator.pop(context);
            },
          )
      ]);
    }
    if (widget.component == 'PSU') {
      psus = Provider.of<List<Psu>>(context) ?? [];
      return SimpleDialog(title: Text('Choose your $component'), children: [
        for (int i = 0; i < psus.length; i++)
          SimpleDialogOption(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        padding: EdgeInsets.all(5),
                        margin: EdgeInsets.only(right: 20),
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(width: 1)),
                        child: psus[i].img),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width*0.50,
                          child: Text(psus[i].manufacturer + " " + psus[i].model,
                              style: TextStyle(fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis,),
                        ),
                        Text(psus[i].power + " " + "W")
                      ],
                    ),
                  ],
                ),
              ],
            ),
            onPressed: () {
              if (globals.ktoro == 2)
                dodaj.chosenPsu = psus[i];
              else if (globals.ktoro == 1) Edit.chosenPsu = psus[i];
              Navigator.pop(context);
            },
          )
      ]);
    }

    if (widget.component == 'GPU') {
      gpus = Provider.of<List<Gpu>>(context) ?? [];
      return SimpleDialog(title: Text('Choose your $component'), children: [
        for (int i = 0; i < gpus.length; i++)
          SimpleDialogOption(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        padding: EdgeInsets.all(5),
                        margin: EdgeInsets.only(right: 20),
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(width: 1)),
                        child: gpus[i].img),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(gpus[i].manufacturer + " " + gpus[i].model,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(gpus[i].VRAM + " " + "GB")
                      ],
                    ),
                  ],
                ),
              ],
            ),
            onPressed: () {
              if (globals.ktoro == 2)
                dodaj.chosenGpu = gpus[i];
              else if (globals.ktoro == 1) Edit.chosenGpu = gpus[i];
              Navigator.pop(context);
            },
          )
      ]);
    }

    if (widget.component == 'CSTM COOLER') {
      coolers = Provider.of<List<Cooler>>(context) ?? [];
      return SimpleDialog(title: Text('Choose your $component'), children: [
        for (int i = 0; i < coolers.length; i++)
          SimpleDialogOption(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        padding: EdgeInsets.all(5),
                        margin: EdgeInsets.only(right: 20),
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(width: 1)),
                        child: coolers[i].img),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(coolers[i].manufacturer + " " + coolers[i].model,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        
                      ],
                    ),
                  ],
                ),
              ],
            ),
            onPressed: () {
              if (globals.ktoro == 2)
                dodaj.chosenCooler = coolers[i];
              else if (globals.ktoro == 1) Edit.chosenCooler = coolers[i];
              Navigator.pop(context);
            },
          )
      ]);
    }

    if (widget.component == 'MTBRD') {
      mtbs = Provider.of<List<Motherboard>>(context) ?? [];
      return SimpleDialog(title: Text('Choose your $component'), children: [
        for (int i = 0; i < mtbs.length; i++)
          SimpleDialogOption(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        padding: EdgeInsets.all(5),
                        margin: EdgeInsets.only(right: 20),
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(width: 1)),
                        child: mtbs[i].img),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(mtbs[i].manufacturer + " " + mtbs[i].model,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Row(
                          children: [
                            Text(mtbs[i].ramSlots + "x "),
                            Text(mtbs[i].ramType + ", "),
                            Text("Standard: " + mtbs[i].standard)
                          ],
                        ),
                        if (mtbs[i].hasNvmeSlot) Text('Obsługa dysków NVMe M.2')
                      ],
                    ),
                  ],
                ),
              ],
            ),
            onPressed: () {
              if (globals.ktoro == 2) {
                dodaj.chosenMtb = mtbs[i];
                if(mtbs[i].hasNvmeSlot==true && dodaj.chosenDrive==null)
                  dodaj.usedNvme=false;
                if(dodaj.chosenMtb.hasNvmeSlot==true) dodaj.slots=int.parse(dodaj.chosenMtb.sataPorts);
                else dodaj.slots=int.parse(dodaj.chosenMtb.sataPorts)-1;
              } else if (globals.ktoro == 1) Edit.chosenMtb = mtbs[i];
              Navigator.pop(context);
            },
          )
      ]);
    }

    if (widget.component == 'DRIVE') {
      drives = Provider.of<List<Drive>>(context) ?? [];
      return SimpleDialog(title: Text('Choose your $component'), children: [
        for (int i = 0; i < drives.length; i++)
          SimpleDialogOption(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        padding: EdgeInsets.all(5),
                        margin: EdgeInsets.only(right: 20),
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(width: 1)),
                        child: drives[i].img),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(drives[i].manufacturer + " " + drives[i].model,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(drives[i].type +
                            ", " +
                            drives[i].capacity +
                            " " +
                            "GB")
                      ],
                    ),
                  ],
                ),
              ],
            ),
            onPressed: () {
              if (globals.ktoro == 2) {
                dodaj.chosenDrive = drives[i];
                if(drives[i].connectionType=="NVMe") dodaj.usedNvme=true;
              } else if (globals.ktoro == 1) Edit.chosenDrive = drives[i];
              Navigator.pop(context);
            },
          )
      ]);
    }

    if (widget.component == 'CASE') {
      cases = Provider.of<List<Case>>(context) ?? [];
      return SimpleDialog(title: Text('Choose your $component'), children: [
        for (int i = 0; i < cases.length; i++)
          SimpleDialogOption(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        padding: EdgeInsets.all(5),
                        margin: EdgeInsets.only(right: 20),
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(width: 1)),
                        child: cases[i].img),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                          width: MediaQuery.of(context).size.width*0.5,
                          child: Text(cases[i].manufacturer + " " + cases[i].model,
                              style: TextStyle(fontWeight: FontWeight.bold),
                              maxLines: 1,),
                        ),
                        Text("Obsługiwane standardy: "),
                        Row(
                          children: [
                            
                            for (int j = 0; j < cases[i].standard.length; j++)
                              Text(cases[i].standard[j] + ", ")
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
            onPressed: () {
              if (globals.ktoro == 2)
                dodaj.chosenCase = cases[i];
              else if (globals.ktoro == 1) Edit.chosenCase = cases[i];
              Navigator.pop(context);
            },
          )
      ]);
    }

    if (widget.component == 'RAM') {

      rams = Provider.of<List<Ram>>(context) ?? [];
      return SimpleDialog(title: Text('Choose your $component'), children: [
        Column(
          children: [
            Text(
              ram.toString(),
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  fontFamily: GoogleFonts.workSans().fontFamily,
                  color: Colors.black),
            ),
            Slider(
              value: iloscRam,
              onChanged: (rating) {
                setState(() {
                  if (rating % 2 == 0) {
                        iloscRam = rating;
                        ram=iloscRam;
                      }
                  else {
                    print(rating);
                        iloscRam = (rating.floor()).toDouble();
                        ram=iloscRam;
                      }
                  if (ram == 3.0)
                  ram = 2;
                  else if (ram == 5.0) ram = 4;
                    });
              },
              min: 1,
              max: double.parse(dodaj.chosenMtb.ramSlots),
              divisions: int.parse(dodaj.chosenMtb.ramSlots)==1 ? 1 : int.parse(dodaj.chosenMtb.ramSlots)==2 ? 2 : int.parse(dodaj.chosenMtb.ramSlots)==4 ? 2 : 3,
            ),
          ],
        ),
        for (int i = 0; i < rams.length; i++)
          SimpleDialogOption(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        padding: EdgeInsets.all(5),
                        margin: EdgeInsets.only(right: 20),
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(width: 1)),
                        child: rams[i].img),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(rams[i].manufacturer + " " + rams[i].model,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(rams[i].type+", "+rams[i].speed+ " MHz, "+rams[i].capacity+" GB")
                      ],
                    ),
                  ],
                ),
              ],
            ),
            onPressed: () {
              if (globals.ktoro == 2) {
                    dodaj.chosenRam = rams[i];
                    dodaj.iloscRam=ram;
                  } else if (globals.ktoro == 1) Edit.chosenRam = rams[i];
              Navigator.pop(context);
            },
          )
      ]);
    }

    if (widget.component == 'EXTRA DRIVE') {
      drives = Provider.of<List<Drive>>(context) ?? [];
      return SimpleDialog(title: Text('Choose your $component'), children: [
        for (int i = 0; i < drives.length; i++)
          SimpleDialogOption(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        padding: EdgeInsets.all(5),
                        margin: EdgeInsets.only(right: 20),
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(width: 1)),
                        child: drives[i].img),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(drives[i].manufacturer + " " + drives[i].model,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(drives[i].type +
                            ", " +
                            drives[i].capacity +
                            " " +
                            "GB")
                      ],
                    ),
                  ],
                ),
              ],
            ),
            onPressed: () {
              if (globals.ktoro == 2) {
                dodaj.extraDrives.add(drives[i]);
                if(drives[i].connectionType=="NVMe") {
                  dodaj.usedNvme = true;

                }
                dodaj.extra++;
                  dodaj.slots--;
                  print('O co coemone');
                  print(dodaj.slots);
              } else if (globals.ktoro == 1) Edit.chosenDrive = drives[i];
              Navigator.pop(context);
            },
          )
      ]);
    }

  }
}
