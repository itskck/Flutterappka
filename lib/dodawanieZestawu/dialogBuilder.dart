import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
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
  double iloscRam = 1.0;
  double ram = 1;
  String component;
  var cpus, psus, gpus, coolers, mtbs, drives, cases, rams;
  TextStyle style = TextStyle(overflow: TextOverflow.visible);
  bool gpuAzState = false,gpuPowerState=false,gpuYearState=false;
  @override
  initState() {
    component = widget.component;
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
            child: Container(
              width: MediaQuery.of(context).size.width,
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
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(cpus[i].manufacturer + " " + cpus[i].model,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16)),
                            Text(
                              cpus[i].cores +
                                  "x " +
                                  cpus[i].clocker +
                                  "GHz, Socket: " +
                                  cpus[i].socket,
                            ),
                            Text(
                              cpus[i].hasGpu == 'none'
                                  ? "Zintegorwana karta graficzna ❌"
                                  : "Zintegrowana karta graficzna ✅",
                            ),
                            Text(
                              cpus[i].isUnlocked
                                  ? "Odblokowany mnożnik ✅"
                                  : "Zablokowany mnożnik ❌",
                            ),
                            Text(
                              'Rocznik: ' + cpus[i].year,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
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
      return SimpleDialog(title: Text('Wybierz zasilacz:'), children: [
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
                          width: MediaQuery.of(context).size.width * 0.50,
                          child: Text(
                            psus[i].manufacturer + " " + psus[i].model,
                            style: TextStyle(fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                          ),
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
      
      return SimpleDialog(title: Text('Wybierz kartę graficzną:'), children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 40),
          
          child: Row(
            
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  gpuAzState = true;
                  if (gpuAzState) {
                    setState(() {
                      gpuPowerState=false;
                      gpuYearState=false;
                      gpus.sort((Gpu a, Gpu b) {
                        return a.model
                            .toLowerCase()
                            .compareTo(b.model.toLowerCase());
                      });
                    });
                  } 
                },
                child: Container(
                  width: 20,
                  height: 20,
                  child: Icon(Icons.sort_by_alpha,
                      color: gpuAzState ? Colors.green : Colors.grey),
                ),
              ),
              GestureDetector(
                onTap: () {
                  gpuPowerState = true;
                  if (gpuPowerState) {
                    setState(() {
                      gpuAzState=false;
                      gpuYearState=false;
                      gpus.sort((Gpu a, Gpu b) {
                        return a.VRAM
                            .toLowerCase()
                            .compareTo(b.VRAM.toLowerCase());
                      });
                    });
                  } 
                },
                child: Container(
                  width: 20,
                  height: 20,
                  child: Icon(Icons.memory,
                      color: gpuPowerState ? Colors.green : Colors.grey),
                ),
              ),
              GestureDetector(
                onTap: () {
                  gpuYearState = true;
                  if (gpuYearState) {
                    setState(() {
                      gpuPowerState=false;
                      gpuAzState=false;
                      gpus.sort((Gpu a, Gpu b) {
                        return a.year
                            .toLowerCase()
                            .compareTo(b.year.toLowerCase());
                      });
                    });
                  } 
                },
                child: Container(
                  width: 20,
                  height: 20,
                  child: Center(child: Text('\'99',style:TextStyle(color: gpuYearState ? Colors.green : Colors.grey,fontSize: 15),)),
                ),
              ),
            ],
          ),
        ),
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
                        Text("VRAM: " + gpus[i].VRAM + " GB"),
                        Text('Seria: ' + gpus[i].series),
                        Text('Rocznik: ' + gpus[i].year)
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
      return SimpleDialog(title: Text('Wybierz chłodzenie'), children: [
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
                        Text('Kompatybilność z gniazdami: '),
                        Row(
                          children: [
                            for (int j = 0; j < coolers[i].socket.length; j++)
                              Row(
                                children: [
                                  Text(coolers[i].socket[j] + ", "),
                                  if (j + 1 % 3 == 0) Text('\n')
                                ],
                              )
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
                dodaj.chosenCooler = coolers[i];
              else if (globals.ktoro == 1) Edit.chosenCooler = coolers[i];
              Navigator.pop(context);
            },
          )
      ]);
    }

    if (widget.component == 'MTBRD') {
      mtbs = Provider.of<List<Motherboard>>(context) ?? [];
      return SimpleDialog(title: Text('Wybierz płytę główną'), children: [
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
                        Row(
                          children: [
                            Text(mtbs[i].sataPorts + 'x SATA, '),
                            Text(mtbs[i].usb3 + 'x USB v3')
                          ],
                        ),
                        if (mtbs[i].hasNvmeSlot)
                          Text('Obsługa dysków NVMe M.2'),
                        Text(mtbs[i].wifi ? 'Wifi: ✅' : 'Wifi: ❌'),
                        Text('Przepustowość portu ethernet: \n' +
                            mtbs[i].ethernetSpeed +
                            "Mb/s")
                      ],
                    ),
                  ],
                ),
              ],
            ),
            onPressed: () {
              if (globals.ktoro == 2) {
                dodaj.chosenMtb = mtbs[i];
                if (mtbs[i].hasNvmeSlot == true && dodaj.chosenDrive == null)
                  dodaj.usedNvme = false;
                if (dodaj.chosenMtb.hasNvmeSlot == true)
                  dodaj.slots = int.parse(dodaj.chosenMtb.sataPorts);
                else
                  dodaj.slots = int.parse(dodaj.chosenMtb.sataPorts) - 1;
              } else if (globals.ktoro == 1) Edit.chosenMtb = mtbs[i];
              Navigator.pop(context);
            },
          )
      ]);
    }

    if (widget.component == 'DRIVE') {
      drives = Provider.of<List<Drive>>(context) ?? [];
      return SimpleDialog(title: Text('Wybierz dysk systemowy: '), children: [
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
                            "GB"),
                        Text('Typ złącza: ' + drives[i].connectionType)
                      ],
                    ),
                  ],
                ),
              ],
            ),
            onPressed: () {
              if (globals.ktoro == 2) {
                dodaj.chosenDrive = drives[i];
                if (drives[i].connectionType == "NVMe") dodaj.usedNvme = true;
              } else if (globals.ktoro == 1) Edit.chosenDrive = drives[i];
              Navigator.pop(context);
            },
          )
      ]);
    }

    if (widget.component == 'CASE') {
      cases = Provider.of<List<Case>>(context) ?? [];
      return SimpleDialog(title: Text('Wybierz obudowę: '), children: [
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
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Text(
                            cases[i].manufacturer + " " + cases[i].model,
                            style: TextStyle(fontWeight: FontWeight.bold),
                            maxLines: 1,
                          ),
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
      return SimpleDialog(title: Text('Wybierz RAM: '), children: [
        Column(
          children: [
            Text(
              'Liczba kości: ' + ram.toString()[0],
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  fontFamily: GoogleFonts.workSans().fontFamily,
                  color: Colors.black),
            ),
            Slider(
              inactiveColor: Colors.grey,
              activeColor: Colors.pink,
              value: iloscRam,
              onChanged: (rating) {
                setState(() {
                  if (rating % 2 == 0) {
                    iloscRam = rating;
                    ram = iloscRam;
                  } else {
                    print(rating);
                    iloscRam = (rating.floor()).toDouble();
                    ram = iloscRam;
                  }
                  if (ram == 3.0)
                    ram = 2;
                  else if (ram == 5.0) ram = 4;
                });
              },
              min: 1,
              max: double.parse(dodaj.chosenMtb.ramSlots),
              divisions: int.parse(dodaj.chosenMtb.ramSlots) == 1
                  ? 1
                  : int.parse(dodaj.chosenMtb.ramSlots) == 2
                      ? 2
                      : int.parse(dodaj.chosenMtb.ramSlots) == 4
                          ? 2
                          : 3,
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
                        Text(rams[i].type + ", " + rams[i].speed + " MHz, "),
                        Text('Pojemność jednej kości: ' +
                            rams[i].capacity +
                            " GB")
                      ],
                    ),
                  ],
                ),
              ],
            ),
            onPressed: () {
              if (globals.ktoro == 2) {
                dodaj.chosenRam = rams[i];
                dodaj.iloscRam = ram;
              } else if (globals.ktoro == 1) Edit.chosenRam = rams[i];
              Navigator.pop(context);
            },
          )
      ]);
    }

    if (widget.component == 'EXTRA DRIVE') {
      drives = Provider.of<List<Drive>>(context) ?? [];
      return SimpleDialog(title: Text('Wybierz dodatkowy dysk'), children: [
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
                            "GB"),
                        Text('Typ złącza: ' + drives[i].connectionType)
                      ],
                    ),
                  ],
                ),
              ],
            ),
            onPressed: () {
              if (globals.ktoro == 2) {
                dodaj.extraDrives.add(drives[i]);
                if (drives[i].connectionType == "NVMe") {
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
