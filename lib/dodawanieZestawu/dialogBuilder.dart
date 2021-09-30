import 'package:flutter/material.dart';
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

class dialogBuilder extends StatelessWidget {
  String component;
  var cpus, psus, gpus, coolers, mtbs, drives, cases, rams;
  dialogBuilder({this.component});
  TextStyle style = TextStyle(
    overflow: TextOverflow.visible

  );
  @override
  Widget build(BuildContext context) {
    if (component == 'CPU') {
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
                        Text(cpus[i].manufacturer + " " + cpus[i].model + " ",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(cpus[i].cores + "x " + cpus[i].clocker + "GHz")
                      ],
                    ),
                  ],
                ),
              ],
            ),
            onPressed: () {
              if (globals.ktoro == 0)
                dodaj.chosenCpu = cpus[i];
              else if (globals.ktoro == 1) Edit.chosenCpu = cpus[i];
              Navigator.pop(context);
            },
          )
      ]);
    }
    if (component == 'PSU') {
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
              if (globals.ktoro == 0)
                dodaj.chosenPsu = psus[i];
              else if (globals.ktoro == 1) Edit.chosenPsu = psus[i];
              Navigator.pop(context);
            },
          )
      ]);
    }

    if (component == 'GPU') {
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
              if (globals.ktoro == 0)
                dodaj.chosenGpu = gpus[i];
              else if (globals.ktoro == 1) Edit.chosenGpu = gpus[i];
              Navigator.pop(context);
            },
          )
      ]);
    }

    if (component == 'CSTM COOLER') {
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
              if (globals.ktoro == 0)
                dodaj.chosenCooler = coolers[i];
              else if (globals.ktoro == 1) Edit.chosenCooler = coolers[i];
              Navigator.pop(context);
            },
          )
      ]);
    }

    if (component == 'MTBRD') {
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
              if (globals.ktoro == 0)
                dodaj.chosenMtb = mtbs[i];
              else if (globals.ktoro == 1) Edit.chosenMtb = mtbs[i];
              Navigator.pop(context);
            },
          )
      ]);
    }

    if (component == 'DRIVE') {
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
              if (globals.ktoro == 0)
                dodaj.chosenDrive = drives[i];
              else if (globals.ktoro == 1) Edit.chosenDrive = drives[i];
              Navigator.pop(context);
            },
          )
      ]);
    }

    if (component == 'CASE') {
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
              if (globals.ktoro == 0)
                dodaj.chosenCase = cases[i];
              else if (globals.ktoro == 1) Edit.chosenCase = cases[i];
              Navigator.pop(context);
            },
          )
      ]);
    }

    if (component == 'RAM') {
      rams = Provider.of<List<Ram>>(context) ?? [];
      return SimpleDialog(title: Text('Choose your $component'), children: [
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
              if (globals.ktoro == 0)
                dodaj.chosenRam = rams[i];
              else if (globals.ktoro == 1) Edit.chosenRam = rams[i];
              Navigator.pop(context);
            },
          )
      ]);
    }
  }
}
